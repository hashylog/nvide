<div align="center">
  <div>
    <picture>
      <img alt="nvide" height="128" src="images/logo.png">
    </picture>
  </div>
</div>

<br>

NVide is a modern NeoVim configuration designed to deliver a smooth and intuitive development experience, especially for developers who appreciate the usability of GUI editors, but crave the performance and flexibility of terminal-based tools.

#### About

NVide is heavily inspired by the **[Micro Editor](https://github.com/zyedidia/micro)**. Since Micro isn’t very popular and lacks a wide range of plugins, I decided to make NeoVim resemble it as closely as possible through NVide.

<br>

# Installation

You can install NVide in two ways: automatically using the provided script, or manually following the steps below.

## Automated Installation

For a quick setup, download and run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/hashylog/nvide/main/install.sh | bash
```

Alternatively, clone the repository and run:

```bash
git clone https://github.com/hashylog/nvide.git
cd nvide
./install.sh
```

## Manual Installation

#### 1- Download nvide.lua
Copy or download the nvide.lua file from this repository.

You can also download it directly using curl:

```bash
curl -o ~/.config/nvim/lua/nvide.lua https://raw.githubusercontent.com/hashylog/nvide/main/nvide.lua
```

#### 2- Move the file
Place it inside your Neovim configuration folder:
<br>
`~/.config/nvim/lua/nvide.lua`

#### 3- Load the module
Edit your main init.lua and add the following line at the end:
```lua
require('nvide')
```

<br>

That’s it! Restart Neovim and your nvide configuration will be applied.
