return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
        require('copilot').setup(
            {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                },
                panel = {
                    enabled = true,
                    auto_refresh = true
                },
                filetypes = {
                    markdown = true,
                    help = true,
                },
            }
        )
    end,

}
