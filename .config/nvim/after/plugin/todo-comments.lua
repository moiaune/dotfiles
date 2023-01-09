require("todo-comments").setup{
    signs = false,
    keywords = {
        FIX = {
            color = "#fceda4",
            alt = { "FIXME", "FIXIT" },
        }
    },
    gui_style = {
        fg = "ITALIC",
        bg = "NONE",
    },
    merge_keywords = true,
    highlight = {
        before = "fg",
        keyword = "fg",
        after = "fg"
    }
}
