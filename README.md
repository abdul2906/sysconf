# dotnix

## Prerequisites

You need to prepare a couple things before installation due to the way secrets are managed.

### Prepare secrets repo

1. Ensure all required dependencies are present
```sh
# If you're already using Nix you can simply run this
nix-shell -p sops age
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

5. Create your sops configuration file 
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

?. Update the submodule to use your repo
```sh
git submodule set-url -- secrets <ssh uri to your repository>
```

