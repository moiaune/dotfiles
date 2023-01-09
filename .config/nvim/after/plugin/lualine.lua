require('lualine').setup{
    options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "buffers" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {{
            "diagnostics",
              sources = { "nvim_diagnostic", "nvim_lsp" },
              sections = { "error", "warn" },
              diagnostics_color = {
                  -- Same values as the general color option can be used here.
                  error = 'DiagnosticError', -- Changes diagnostics' error color.
                  warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              },
              symbols = { error = "E", warn = "W" },
              colored = true,
              update_in_insert = false,
              always_visible = true,
        }},
    }
}
