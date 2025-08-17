# Installing brew

- Open a terminal and install the necessary build tools and curl and git packages:

  ```
  sudo apt update
  sudo apt install build-essential curl git
  ```

- Execute the official Homebrew installation script using curl:

  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- After the installation completes, the script will provide instructions to add Homebrew to your shell's PATH.
  ```
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ```
- Run `brew doctor` to check for any potential issues and confirm that Homebrew is correctly installed and configured:
  ```
  brew doctor
  ```
- If `brew doctor` suggests installing `gcc`, you can install it using Homebrew:
  ```
  brew install gcc
  ```
- You can now use `brew` to install and manage packages on your Ubuntu system.
  ```
  brew install <package_name>
  ```
