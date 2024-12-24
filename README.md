## Install dotfiles
```bash
cd ~ &&
git clone https://github.com/Mr-Chickedren/.dotfiles &&
bash ./.dotfiles/bin/install.sh -y 
```

## What if the environment is under a proxy?
1. apt proxy settings
```bash:/etc/apt/apt.conf
Acquire::http::Proxy "http://[server]:[port]";
Acquire::https::Proxy "https://[server]:[port]";
```

2. bash proxy settings
```bash:~/.proxy
export http_proxy="http://[server]:[port]"
export https_proxy="https://[server]:[port]"
```

## Let's use Alacritty!
Please place the configration file in the specified location.
```bash:%appdata%/alacritty/alacritty.toml
[terminal.shell]
program = '/Windows/System32/wsl.exe'

[general]
working_directory = '\\wsl.localhost\Ubuntu\home\<user_name>'

[font]
size = 13

[font.normal]
family = 'FiraMono Nerd Font Mono'
style = 'Regular'

[font.bold]
family = 'FiraMono Nerd Font Mono'
style = 'Bold'

[colors]
cursor = { text = "CellForeground", cursor = "#505060" }

[env]
TERM = 'alacritty'
```
