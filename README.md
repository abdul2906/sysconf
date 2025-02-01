# caenix

<table>
  <tr>
    <td>
      About
    </td>
    <td>
      Screenshot
    </td>
  </tr>
  <tr>
    <td>
      This repository contains my personal NixOS configuration.
      Feel free to do whatever with it.
    </td>
    <td>
      <img src="assets/screenshot.png" alt="Screenshot of my desktop">
    </td>
  </tr>
</table>

## Layout
```
.
├── .gitattributes
├── .gitignore
├── README.md
├── assets                   ; Binary assets such as screenshots and wallpapers
│   └── ...
├── flake.lock
├── flake.nix
├── hosts                    ; Host configurations
│   ├── puter
│   │   ├── default.nix      ; Host specific configuration options
│   │   ├── disko.nix        ; Host specific partitioning layout
│   │   └── packages.nix     ; Host specific package set
│   └── ...
├── install.sh
├── lib                      ; Custom helper functions
│   └── ...
├── modules                  ; Configuration modules
│   ├── home                 ; Home-manager modules
│   │   └── caem             ; User home-manager modules
│   │       ├── default.nix  ; User specific configuration options
│   │       ├── packages.nix ; User specific package set
│   │       └── ...
│   └── nixos                ; NixOS modules
│       ├── user             ; User definition
│       │   └── caem.nix
│       └── ...
└── overlays                 ; Overlays
    └── ...
```

## Installation

### Setting up your secrets repository

This step is required to install the system as it is built around nix-sops
with encrypted files in a private repository in order to not expose even the
encrypted secrets to the public. You don't need to be in a NixOS livecd or
system in order to complete this step as long as you can install all
requirements from step 1.

#### 1. Ensure all required dependencies are present

```sh
nix-shell -p sops age git wl-clipboard
```

#### 2. Initialize your secrets repo

```sh
mkdir secrets
cd secrets
git init
```

#### 3. Create your gitignore

You want this to make sure that you do not accidentally push your private key.

```sh
echo "keys.txt" > .gitignore
```

#### 4. Generate your private key

```sh
age-keygen -o ./keys.txt
```

#### 5. Create your sops configuration file

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

#### 6. Create your secrets file

```sh
mkpasswd | wl-copy
sops upasswd.yaml
```

Then edit the file to look like this
```yaml
upasswd: [The pasted password from mkpasswd]
```

#### 7. Create the flake to expose the secrets

```sh
cat <<EOF > flake.nix
{
  outputs = { self, ... }: {
    paths = {
      upasswd = self + "/upasswd.yaml";
    };
  };
}
EOF
```

#### 8. Commit and push your changes

If your git forge supports creating the repository on push you can
simply run the commands below, if it does not, like GitHub, create a private
repository named "secrets" first before running the below commands.

```sh
git remote add origin git@git.example.net:username/secrets
git add .
git commit -m "batman"
git push --set-upstream origin master
```

#### 9. Back up your keys.txt

**THIS STEP IS VERY IMPORTANT**

Back up your keys.txt in a safe location where you can later transfer it on to the livecd.
Keep it safe afterwards as it is required to decrypt your secrets. Do not share this with
anyone else as it'd allow them to decrypt all your secrets.

You also need to have a copy of your ssh private key or (preferably) deployment key to the repository
ready to later clone your secrets repository.

### Installing the system

#### 0. Boot in to a livcd image

Any of the official NixOS livecds will work as long as you're able securely transfer files on to
it. Non-nixos livecds might work if you install the required tools manually but is out of scope
of this document.

#### 1. Clone this repository

```sh
git clone https://github.com/c4em/caenix.git
cd caenix
```

#### 2. Fetch your keys.txt and ssh key

Fetch your keys.txt from wherever you've stored them and **place them at the root of the configuration directory**.
If you place them anywhere else the installation will fail. Do not move them later either.

For your ssh key, place it in `~/.ssh` and create a symlink for the root user.
```sh
sudo ln -sf /home/nixos/.ssh /root/.ssh
```

And start a instance of ssh-agent.
```sh
eval $(ssh-agent -s)
ssh-add ~/.ssh/[your key]
```

#### 3. Update the flake input for your secret

In `flake.nix`, replace
```nix
  inputs = {
    secrets.url = "git+ssh://git@git.caem.dev/caem/secrets";
```
with your url.
```nix
  inputs = {
    secrets.url = "git+ssh://git@git.example.com/username/secrets";
```

#### 4. Update flake.lock (optional)
This is very useful and will also tell you if cloning your secrets work,
rather than only telling you after already having partitioned the drive.
```sh
nix --extra-experimental-features 'nix-command flakes' flake update
```

#### 5. Run the installation script
```sh
./install.sh --host [your host] --device [the device to install NixOS on]
```

