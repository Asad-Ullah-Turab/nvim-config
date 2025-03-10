return {
  "lervag/vimtex",
  ft = "tex", -- Load only for TeX files
  config = function()
    vim.g.vimtex_view_method = "zathura" -- Use Zathura as PDF viewer (change if needed)
    vim.g.vimtex_compiler_method = "latexmk" -- Use latexmk for compilation
    vim.g.tex_flavor = "latex"
  end,
}
