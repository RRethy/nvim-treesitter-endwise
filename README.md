<h1 align="center">
  <a href="https://github.com/RRethy/nvim-treesitter-endwise">nvim-treesitter-endwise</a>
</h1>

<h4 align="center">wisely add "end" in ruby, Lua, Vimscript, etc.</h4>

https://user-images.githubusercontent.com/21000943/150613732-442589e2-6b08-4b14-b0a3-47effef0eb28.mov

# Quick Start

```lua
require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
}
```

This is a simple plugin that helps to end certain structures automatically. In Ruby, this means adding end after if, do, def, etc.

**Supported Languages**: *Ruby*, *Lua*, *Vimscript*

# Additional Language Support

Please open an issue for new languages, I'll provide the required context for you to write the queries.

# Credit

This is just a rewrite of https://github.com/tpope/vim-endwise to leverage Treesitter so it can be more accurate and work without having to run Neovim's slow regex based highlighting along with nvim-treesitter highlighting.
