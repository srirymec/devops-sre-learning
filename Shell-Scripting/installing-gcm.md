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
  srini@DESKTOP-7GERM11:~/git-repos/documents-copy$ gpg --list-secret-keys --keyid-format=long
  gpg: checking the trustdb
  gpg: marginals needed: 3  completes needed: 1  trust model: pgp
  gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
  /home/srini/.gnupg/pubring.kbx
  ------------------------------
  sec   rsa4096/2AB85A2E8ACD7E02 2025-08-17 [SC]
        19B3FB91C9776DB6806E0C522AB85A2E8ACD7E02
  uid                 [ultimate] Srinivas (bla bla) <srinivasabester@gmail.com>
  ssb   rsa4096/D1D8CB3502F4DD39 2025-08-17 [E]

  ```

  Here `2AB85A2E8ACD7E02` is your **GPS ID**
  
- Initialize the password store with your GPG key
  
  ```
  pass init 2AB85A2E8ACD7E02
  ```

  ```
  srini@DESKTOP-7GERM11:~/git-repos/documents-copy$ pass init 2AB85A2E8ACD7E02
  mkdir: created directory '/home/srini/.password-store/'
  Password store initialized for 2AB85A2E8ACD7E02
  ```

  This creates `~/.password-store/` encrypted with your GPG key.
  
- Tell Git to use the password store
  ```
  git config --global credential.credentialStore gpg
  ```

- When git push is run, the credentials will be stored,

  ![git-creds](https://github.com/srirymec/devops-sre-learning/blob/main/Shell-Scripting/images/gcm-configure.PNG)

