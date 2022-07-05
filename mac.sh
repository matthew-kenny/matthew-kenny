# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# App Store Paid Apps
Magnet
Reeder

# Install Core apps
brew install --cask cheatsheet microsoft-edge the-unarchiver raycast powershell microsoft-office microsoft-teams termius neofetch microsoft-remote-desktop slack

# Install Programming apps
brew install --cask iterm2 visual-studio-code visual-studio intellij-idea docker vmware-fusion
brew install awscli azure-cli terraform git

# Order Launchpad apps
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
