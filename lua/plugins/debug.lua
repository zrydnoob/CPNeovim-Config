return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require 'configs.debug'
    end
  },
  {
      "igorlfs/nvim-dap-view",
      lazy=false,
      config = function ()
        require 'configs.debugui'
      end
  },
  {
      "mfussenegger/nvim-dap-python"
  }
  }
