# Configure the bash shell using Omakub defaults
[ -f "~/.bashrc" ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.config/omakub/configs/bashrc ~/.bashrc

# install bash-completion
brew install bash-completion
# Load the PATH for use later in the installers
source ~/.config/omakub/defaults/bash/shell

[ -f "~/.inputrc" ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Omakub defaults
cp ~/.config/omakub/configs/inputrc ~/.inputrc
