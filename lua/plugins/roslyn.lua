return {
  {
    -- 'jmederosalvarado/roslyn.nvim',
    "seblj/roslyn.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "tris203/rzls.nvim",
        config = function()
          require("rzls").setup({
            on_attach = LazyVim.lsp.on_attach,
            capabilities = LazyVim.has("cmp-nvim-lsp") and require("cmp_nvim_lsp").default_capabilities() or nil,
          })
        end,
      },
    },
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          -- 'github:syndim/mason-registry',
          "github:crashdummyy/mason-registry",
        },
      })
      require("roslyn").setup({
        args = {
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--razorSourceGenerator=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "roslyn",
            "libexec",
            "Microsoft.CodeAnalysis.Razor.Compiler.dll"
          ),
          "--razorDesignTimePath=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "rzls",
            "libexec",
            "Targets",
            "Microsoft.NET.Sdk.Razor.DesignTime.targets"
          ),
        },
        config = {
          on_attach = LazyVim.lsp.on_attach,
          capabilities = LazyVim.has("cmp-nvim-lsp") and require("cmp_nvim_lsp").default_capabilities() or nil,
          handlers = require("rzls.roslyn_handlers"),
        },
      })
    end,
  },
}
