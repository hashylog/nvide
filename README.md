<div align="center">
  <div>
    <picture>
      <img alt="nvide" height="128" src="images/logo.png">
    </picture>
  </div>
</div>

<br>

NVide is a modern NeoVim configuration designed to deliver a smooth and intuitive development experience, especially for developers who appreciate the usability of GUI editors, but crave the performance and flexibility of terminal-based tools.

This configuration bridges that gap by providing a NeoVim setup that:
- Mimics common Visual Studio Code behaviors and shortcuts.
- Offers GUI-like UX elements via plugins.
- Runs entirely in the terminal, making it ultra-portable and resource-friendly

Whether you’re switching from Visual Studio Code, or you simply want a fast IDE-like setup in the terminal, NVide gives you the experience you're used to, with the performance you've always wanted.

#### About

NVide is heavily inspired by the **[Micro Editor](https://github.com/zyedidia/micro)**. Since Micro isn’t very popular and lacks a wide range of plugins, I decided to make NeoVim resemble it as closely as possible through NVide.

<br>

# Installation

#### 1- Download nvide.lua
Copy or download the nvide.lua file from this repository.

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
