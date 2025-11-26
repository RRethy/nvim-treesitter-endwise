<h1 align="center">
  <a href="https://github.com/RRethy/nvim-treesitter-endwise">nvim-treesitter-endwise</a>
</h1>

<h4 align="center">wisely add "end" in Ruby, Lua, Vimscript, etc.</h4>

https://user-images.githubusercontent.com/21000943/150613732-442589e2-6b08-4b14-b0a3-47effef0eb28.mov

# Quick Start

No configuration is required, just install the plugin and it'll work!

# About

This is a simple plugin that helps to end certain structures automatically. In Ruby, this means adding end after if, do, def, etc. This even works for languages nested inside other, such as Markdown with a Lua code block!

**Supported Languages**: *Ruby*, *Lua*, *Vimscript*, *Bash*, *Elixir*, *Fish*, *Julia*, *Crystal*

# Additional Language Support

Please open an issue for new languages, right now I'm open PRs but I won't be implementing other languages myself (except for maybe shell script). See https://github.com/RRethy/nvim-treesitter-endwise/issues/2#issuecomment-1019574925 for more information on adding support for a new language.

# Credit

This is just a rewrite of https://github.com/tpope/vim-endwise to leverage Treesitter so it can be more accurate and work without having to run Neovim's slow regex based highlighting along with nvim-treesitter highlighting.

Special thanks to
* [@jasonrhansen](https://www.github.com/jasonrhansen) who added support for injected languages and Vimscript.
* [@simonmandlik](https://www.github.com/simonmandlik) who added support for Julia.
* [@omarluq](https://github.com/omarluq) added crystal-lang
