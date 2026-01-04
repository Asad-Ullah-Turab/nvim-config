return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- The key must be "injection", not "injector"
    injector = {
      ["cpp"] = {
        before = {
          "#include <bits/stdc++.h>",
          "using namespace std;",
        },
        after = {
          "int main() {",
          "    // local testing code here",
          "    return 0;",
          "}",
        },
      },
    },
  },
}
