-- lua/plugins/cord.lua
return {
  "vyfor/cord.nvim",
  commit = "6a0c0387abd4a4d1e65d6e83a274452a91f9ccd2",
  opts = {
    display = {
      theme = "default",
      flavor = "dark",
    },
    lazy = {
      text = {
        workspace = function(opts)
          local hour = tonumber(os.date("%H"))
          local status =
            hour >= 22 and "🌙 Late night coding"
            or hour >= 18 and "🌆 Evening session"
            or hour >= 12 and "☀️ Afternoon coding"
            or hour >= 5 and "🌅 Morning productivity"
            or "🌙 Midnight hacking"

          return string.format("%s: %s", status, opts.filename)
        end,

        idle = {
          details = function(opts)
            return string.format("Taking a break from %s", opts.workspace)
          end,
        },
      },
      buttons = {
        {
          label = "View Repository",
          url = function(opts)
            if not opts.is_idle then
              return opts.repo_url
            end
          end,
        },
      },
    },
  },
}
