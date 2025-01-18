# dotnix

## Prerequisites

You need to prepare a couple things before installation due to the way secrets are managed.

### Prepare secrets repo

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
sops <username>.yaml
```
Where `<username>` is the user set to be used in `flake.nix`.

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

8. Update the submodule to use your secrets repository.
```sh
cd <Path to the configuration repo>
git submodule set-url -- secrets <ssh uri to your repository>
```

