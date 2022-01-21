<h1 align="center">
  <a href="https://github.com/RRethy/nvim-treesitter-endwise">nvim-treesitter-endwise</a>
</h1>

<h4 align="center">wisely add "end" in ruby, endfunction/endif/more in vim script, etc</h4>

TODO mov video

# Quick Start

```lua
require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
}
```

This is a simple plugin that helps to end certain structures automatically. In Ruby, this means adding end after if, do, def, etc. Lua is also supported.

# Additional Language Support

Please open an issue for new languages, I'll provide the required context for you to write the queries.

# Credit

This is just a rewrite of https://github.com/tpope/vim-endwise to leverage Treesitter so it can be more accurate and work without having to run Neovim's slow regex based highlighting along with nvim-treesitter highlighting.
