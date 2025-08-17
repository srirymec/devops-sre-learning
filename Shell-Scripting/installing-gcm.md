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

