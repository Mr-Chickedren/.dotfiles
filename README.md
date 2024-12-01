## Install dotfiles
```bash
cd ~ &&
git clone https://github.com/Mr-Chickedren/.dotfiles &&
bash ./.dotfiles/bin/install.sh -y 
```

## What if the environment is under a proxy?
1. apt proxy settings
```bash
# /etc/apt/apt.conf

Acquire::http::Proxy "http://[server]:[port]";
Acquire::https::Proxy "https://[server]:[port]";
```

2. bash proxy settings(tentative)
```bash
# ~/.bashrc???

export HTTP_PROXY=????
```
