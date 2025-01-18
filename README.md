# dotnix

## Installation

### Prerequisites

You need to prepare a couple things before installation due to the way secrets are managed.

#### Prepare secrets repo

1. Ensure all required dependencies are present.
```sh
nix-shell -p sops age git
```

2. Initialize your secrets repo. You can do this anywhere on your system except this repository.
```sh
mkdir secrets
cd secrets
git init
```

3. Create your gitignore. You want this to make sure that you do not accidentally push your private key.
```sh
echo "keys.txt" > .gitignore
```

4. Generate your private key.
```sh
age-keygen -o ./keys.txt
```

5. Create your sops configuration file.
```sh
cat <<EOF > .sops.yaml
keys:
  - &master $(age-keygen -y ./keys.txt)
creation_rules:
  - path_regex: .*\.(yaml|json|env|ini)$
    key_groups:
    - age:
      - *master
EOF
```

6. Create a password file for your user.
```sh
mkpasswd | wl-copy # if you're on x11, replace `wl-copy` with `xclip -sel clipboard`
sops user_password.yaml
```

Then edit the file to look like this.
```yaml
user_password: <The pasted password from mkpasswd>
```

7. Commit and push your changes.
```sh
git remote add origin git@example.com:example/secrets
git add .
git commit -m "batman"
git push --set-upstream origin master
```

8. Back up your keys.txt
This step is very important as you'll need to copy this file to your new installation.
Make sure you'll be able to securely copy it to another machine, you should handle this
file with much care as anyone who has it will be able to decrypt your secrets if the have
the files.

### Selecting a livecd for the installation

The installation should work on all the NixOS livecd images, other livecds are not supported.
Just make sure you have a way to get both your ssh key for cloning your secrets repository and
keys.txt for decrypting your sops files.

### Installation

1. Clone this repository
```sh
git clone https://github.com/c4em/dotnix.git
cd dotnix
```

2. Enter a nix-shell with all required dependencies for the installation
```sh
nix-shell # This will automatically install all dependencies from `shell.nix`
```

3. Update the submodule to use your secrets repository.
```sh
git submodule set-url -- secrets <ssh uri to your repository>
```

3. Adjust the configuration to your needs.

Information about how the configuation is structured is available in the WIP section.

4. Run the installation script
```sh
./install.sh --host <your host> --device <the device to install NixOS on>
```

