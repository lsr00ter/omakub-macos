#!/bin/zsh

# Install Ollama for macOS
echo "Installing Ollama..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

# Install Ollama CLI tool
install_app_via_brew "ollama"

echo " Ollama installed"
echo "> Ollama is your local large language model runner"
echo "   Run models locally on your Mac with privacy and speed"
echo ""
echo "=� Getting started:"
echo "   1. Start Ollama service: ollama serve"
echo "   2. Download a model: ollama pull llama2"
echo "   3. Chat with the model: ollama run llama2"
echo "   4. List available models: ollama list"
echo "   5. See all commands: ollama --help"
echo ""
echo "=� Popular models to try:"
echo "   - llama2 (7B): ollama pull llama2"
echo "   - codellama (7B): ollama pull codellama"
echo "   - mistral (7B): ollama pull mistral"
echo "   - neural-chat (7B): ollama pull neural-chat"
echo ""
echo "=� Visit https://ollama.ai/library for more models"
