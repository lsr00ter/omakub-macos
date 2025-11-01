# Homebrew 架构修复说明

## 问题描述

在 Apple Silicon Mac 上运行 Homebrew 时,如果在 Rosetta 2 环境下执行 `brew install` 命令,会导致以下问题:

1. 安装错误架构的 portable-ruby (x86_64 而非 arm64)
2. 后续所有 `brew install` 命令失败,即使使用 `arch -arm64 brew install` 也无法解决
3. 错误提示: `Cannot install under Rosetta 2 in ARM default prefix (/opt/homebrew)`

## 参考资料

- [Homebrew Discussion #2434](https://github.com/orgs/Homebrew/discussions/2434)
- 问题根源:Rosetta 2 环境下 Homebrew 无法正确检测系统架构

## 解决方案

### 核心修复

创建了 `install/terminal-macos/brew-helpers.sh` 辅助函数库,提供以下功能:

1. **架构检测**: 自动检测系统架构 (arm64/x86_64)
2. **安全执行**: `safe_brew` 函数确保在正确架构下执行 brew 命令
3. **自动修复**: `cleanup_rosetta_ruby` 函数自动检测并清理错误的 portable-ruby 安装
4. **便捷包装**: `brew_install` 和 `brew_install_cask` 简化调用

### 关键函数

#### safe_brew
```zsh
# 在 Apple Silicon 上自动检测并强制使用 ARM64 架构
if [[ $(get_arch) == "arm64" ]]; then
    if running_under_rosetta; then
        arch -arm64 /opt/homebrew/bin/brew "$@"
    else
        /opt/homebrew/bin/brew "$@"
    fi
fi
```

#### cleanup_rosetta_ruby
```zsh
# 检测并清理错误架构的 portable-ruby
if ruby_is_x86_64_on_arm64_system; then
    rm -rf /opt/homebrew/Library/Homebrew/vendor/portable-ruby
    safe_brew update  # 重新下载正确版本
fi
```

### 修复的文件列表

1. **install/terminal-macos/brew-helpers.sh** (新建)
   - 核心辅助函数库
   - 提供架构检测和安全执行功能

2. **boot-macos.sh**
   - 替换直接调用为 `safe_brew install git`
   - 添加 `ensure_homebrew` 调用

3. **install/terminal-macos/libraries-macos.sh**
   - 所有 `brew install` 替换为 `safe_brew install`
   - `install_app_via_brew` 使用 `brew_install` 和 `brew_install_cask`
   - 移除旧的 `ensure_homebrew` 函数,使用新的版本

4. **install/terminal-macos/app-neovim-macos.sh**
   - `brew install` 替换为 `safe_brew install`

5. **bin/omakub-sub-macos/font.sh**
   - `brew install --cask` 替换为 `brew_install_cask`
   - `brew list` 替换为 `safe_brew list`

6. **bin/omakub-sub-macos/install-dev-editor.sh**
   - 所有编辑器安装使用 `brew_install_cask`

7. **install/terminal-macos/select-dev-language-macos.sh**
   - PHP 安装使用 `safe_brew install`

8. **install/desktop-macos/cleanup-dock-macos.sh**
   - dockutil 安装使用 `safe_brew install`

## 使用方法

### 自动集成

所有修复已集成到安装脚本中,用户无需额外操作:

```bash
# 正常运行安装即可
bash <(curl -s https://raw.githubusercontent.com/lsr00ter/omakub-macos/macos/boot-macos.sh)
```

### 手动修复现有问题

如果已经遇到 Rosetta 2 问题,可以手动执行:

```bash
# 1. 下载辅助函数
curl -fsSL https://raw.githubusercontent.com/lsr00ter/omakub-macos/macos/install/terminal-macos/brew-helpers.sh -o /tmp/brew-helpers.sh
source /tmp/brew-helpers.sh

# 2. 清理错误的 portable-ruby
cleanup_rosetta_ruby

# 3. 重新安装包
safe_brew install <package-name>
```

### 验证修复

检查 portable-ruby 架构:

```bash
file /opt/homebrew/Library/Homebrew/vendor/portable-ruby/current/bin/ruby
# 应该输出: Mach-O 64-bit executable arm64
```

检查 Rosetta 状态:

```bash
brew config | grep Rosetta
# 在 ARM64 shell 中应该输出: Rosetta 2: false
```

## 技术细节

### 架构检测逻辑

1. **系统架构**: `uname -m` 获取硬件架构
2. **Rosetta 检测**: `sysctl.proc_translated` 检测是否运行在 Rosetta 2 下
3. **Ruby 架构**: `file` 命令检测 portable-ruby 二进制文件架构

### 兼容性

- ✅ Apple Silicon (M1/M2/M3) - ARM64 原生
- ✅ Apple Silicon + Rosetta 2 - 自动强制 ARM64
- ✅ Intel Mac - x86_64 原生支持

### 性能影响

- 架构检测: 微秒级,几乎无性能损失
- Rosetta 检测: 仅在 ARM64 系统上执行一次
- 清理操作: 仅在检测到问题时执行

## 最佳实践

### 开发建议

1. **始终使用包装函数**: 使用 `safe_brew` 而非直接调用 `brew`
2. **源码导入**: 在脚本开头导入 `brew-helpers.sh`
3. **错误处理**: 检查函数返回值,提供友好错误提示

### 示例代码

```zsh
#!/bin/zsh

# 导入辅助函数
source ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh

# 确保 Homebrew 已安装并修复
ensure_homebrew

# 安装普通包
safe_brew install neovim

# 安装 cask
brew_install_cask visual-studio-code

# 或使用便捷函数
brew_install git curl wget
brew_install_cask docker
```

## 故障排查

### 问题 1: 仍然提示 Rosetta 2 错误

**解决方案**:
```bash
# 完全清理 portable-ruby
rm -rf /opt/homebrew/Library/Homebrew/vendor/portable-ruby

# 强制 ARM64 更新
arch -arm64 /opt/homebrew/bin/brew update
```

### 问题 2: brew-helpers.sh 未找到

**解决方案**:
```bash
# 确保仓库已克隆
git clone https://github.com/lsr00ter/omakub-macos.git ~/.local/share/omakub-macos

# 或直接下载
curl -fsSL https://raw.githubusercontent.com/lsr00ter/omakub-macos/macos/install/terminal-macos/brew-helpers.sh \
  -o ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh
```

### 问题 3: 权限错误

**解决方案**:
```bash
# 修复 Homebrew 目录权限
sudo chown -R $(whoami) /opt/homebrew/*

# 重新运行安装
ensure_homebrew
```

## 测试验证

### 测试场景

- [x] Apple Silicon 原生环境安装
- [x] Rosetta 2 环境下自动切换到 ARM64
- [x] 检测并清理错误的 portable-ruby
- [x] Intel Mac 正常运行
- [x] 混合环境(同时安装 ARM64 和 x86_64 Homebrew)

### 验证命令

```bash
# 检查当前架构
echo "System: $(uname -m)"
echo "Rosetta: $(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)"

# 检查 Homebrew 配置
brew config

# 检查 portable-ruby
file /opt/homebrew/Library/Homebrew/vendor/portable-ruby/current/bin/ruby
```

## 贡献者

修复基于 [Homebrew Discussion #2434](https://github.com/orgs/Homebrew/discussions/2434) 中 @carlocab 提供的解决方案。

## 许可证

与主项目保持一致。
