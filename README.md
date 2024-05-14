## install neovim(latest ver)
```bash
sudo snap install nvim --classic
```
if you can't install, you should check to be enabled "systemd".
```bash
#/etc/wsl.conf

[boot]
systemd=true
```
## install dotfiles
```bash
cd ~ &&
git clone https://github.com/Mr-Chickedren/.dotfiles &&
bash ./.dotfiles/bin/install.sh -y 
```
