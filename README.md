# about

This is my neovim config for C/C++ development.

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)


![screencapture.png](screencapture.png)

# instructions

## dependencies

You'll probably have to install some tools...
```
sudo apt install clang clangd npm unzip fzf ripgrep fd-find
```

See also `get-lazyvim.sh` for installing [lazygit](https://github.com/jesseduffield/lazygit) (on Debian/Ubuntu).

## neovim from source

You will need neovim 0.10, or at least 0.9 for some of these plugins.
I found building it from source pretty easy on Debian/Ubuntu.

```
sudo apt install libgettextpo-dev gettext
git clone https://github.com/neovim/neovim
cd neovim
mkdir -p ~/usr
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/usr/neovim
make install
```

Note that I installed things in `~/usr/neovim`, which means it needs to go in the PATH.
Alternatively you can make aliases for them in your `~/.bashrc` (or whatever shell you use).
```
alias vim=~/usr/neovim/nvim
alias vi=~/usr/neovim/nvim
alias vimdiff='~/usr/neovim/nvim -d'
```

## installing these configs

Move the old config out of the way, if you have one...
```
mv ~/.config/nvim ~/.config/nvim.old
```

Then copy over the files under `config/nvim`...

```
mkdir -p ~/.config/nvim/
cp -r config/nvim/* ~/.config/nvim/
```

Start things up...
```
nvim
```
It will take a while to install all the dependencies the first time.
Be patient...

## checking installed plugins

At this point you can run
* `:Lazy` to check on the nvim packages being installed (`q` to close)
* `:Mason` to check on diagnostic tools being installed (`q` to close)

## checking keyboard shortcuts

You can use `:WhichKey` to browse through the keyboard shortcuts interactively.

You can also use the `,fk` shortcut to bring up Telescope keymap browser.


# issues

## debugpy

Each time you start, you may see an error `[mason-nvim-dap] installing debugpy`.

After checking the status of this package with `:Mason` you'll find the following error
```
  Failed
    ✗ debugpy
      ▼ Displaying full log
        Creating virtual environment…
        The virtual environment was not created successfully because ensurepip is not
        available.  On Debian/Ubuntu systems, you need to install the python3-venv
        package using the following command.

            apt install python3.11-venv

        You may need to use sudo with that command.  After installing the python3-venv
        package, recreate your virtual environment.

        Failing command: /home/bart/.local/share/nvim/mason/packages/debugpy/venv/bin/python3

        spawn: python3 failed with exit code 1 and signal 0. 
```

The fix is to...

```sh
$ apt install python3.11-venv
```

... and the next time, `debugpy` will install successfully.


# shoutouts

based on this video series:
* https://www.youtube.com/watch?v=zHTeCSVAFNY by `typecraft` (thank you)
