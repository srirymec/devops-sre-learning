# Installing Git Credentials Manager

- Download the latest debain package for gcm for this list - https://github.com/git-ecosystem/git-credential-manager/releases/tag/v2.6.1

  ```
  wget gcm-linux_amd64.2.6.1.deb
  ```

- Run the following
  ```
  sudo dpkg -i <path-to-package>
  git-credential-manager configure
  ```
- To uninstall
  ```
  git-credential-manager unconfigure
  sudo dpkg -r gcm
  ```

# Configure the git credentials store

Git to use the `gpg` credential store

- Make sure you have GPG installed
  ```
  gpg --version
  ```

  If not installed,
  
  ```
  sudo apt install gnupg pass   # Debian/Ubuntu
  sudo yum install gnupg2 pass  # RHEL/CentOS
  ```
  
- Create a GPG key (if you don’t already have one)
  Check if you already have keys:
  
  ```
  gpg --list-secret-keys --keyid-format=long
  ```

  If empty, generate one:

  ```
  gpg --full-generate-key
  ```

  - Choose key type: RSA and RSA
  - Key size: 4096
  - Expiry: choose as needed
  - Enter name, email, passphrase

  After creation, list keys again:

  ```
  gpg --list-secret-keys --keyid-format=long
  ```

  Example output:

  ```
  sec   rsa4096/ABC1234567890DEF 2025-08-17 [SC]
      Key fingerprint = XXXXX YYYYY ZZZZZ
  uid   [ultimate] Your Name <you@example.com>

  ```

  Here `ABC1234567890DEF` is your **GPS ID**
  
- Initialize the password store with your GPG key
  
  ```
  pass init ABC1234567890DEF
  ```

  This creates `~/.password-store/` encrypted with your GPG key.
  
- Tell Git to use the password store
  ```
  git config --global credential.credentialStore gpg
  ```

