return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Inspired by https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
    local rgb_to_hex = require"util.rgb_to_hex"
    local hl = require"util.hl"
    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = {
            c = {
              fg = rgb_to_hex(hl("Normal").fg),
              bg = rgb_to_hex(hl("Normal").bg),
            },
          },
          inactive = {
            c = {
              fg = rgb_to_hex(hl("Normal").fg),
              bg = rgb_to_hex(hl("Normal").bg),
            },
          },
        },
      },
      sections = {
        lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, -- Remove defaults
        lualine_c = {}, lualine_x = {}, -- Extend these later
      },
      inactive_sections = {
        lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {},
      },
    }

    local function buffer_not_empty()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end

    local function ins_l(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_r(component)
      table.insert(config.sections.lualine_x, component)
    end

    local distro = require"util.get_distro"()

    ins_l {
      function()
        return "▊"
      end,
      padding = {
        left = 0,
        right = 0,
      },
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      },
    }

    ins_l {
      function()
        return distro.traits.icon
      end,
      color = {
        fg = distro.traits.color,
      },
    }

    ins_l {
      "filename",
      cond = buffer_not_empty,
      color = {
        fg = rgb_to_hex(hl("Operator").fg),
      }
    }

    ins_l {
      "filesize",
      cond = buffer_not_empty,
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      }
    }

    ins_l {
      "o:encoding",
      cond = buffer_not_empty,
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      }
    }

    ins_l {
      "fileformat",
      icons_enabled = false,
      cond = buffer_not_empty,
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      }
    }

    ins_r { "diagnostics" }
    ins_r { "diff" }

    ins_r {
      "branch",
      padding = {
        right = 0,
      },
      color = {
        fg = rgb_to_hex(hl("Constant").fg)
      }
    }

    ins_r {
      "location",
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      }
    }

    ins_r {
      "mode",
      fmt = string.lower,
      color = {
        fg = rgb_to_hex(hl("String").fg),
      }
    }

    ins_r {
      function()
        return "▊"
      end,
      padding = {
        left = 0,
        right = 0,
      },
      color = {
        fg = rgb_to_hex(hl("Comment").fg),
      }
    }

    require"lualine".setup(config)
  end
}

