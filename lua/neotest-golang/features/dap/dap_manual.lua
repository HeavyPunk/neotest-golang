--- DAP (manual dap configuration) setup related functions.

local options = require("neotest-golang.options")
local logger = require("neotest-golang.logging")

local dap = require("dap")

local M = {}

---Dummy function to be corresponding to other dap configuration kinds
---@param cwd string
function M.setup_debugging(cwd)
  local dap_manual_opts = options.get().dap_manual_opts or {}
  if type(dap_manual_opts) == "function" then
    dap_manual_opts = dap_manual_opts()
  end

  local dap_config = dap.configurations[dap_manual_opts.type]
  dap_config.cwd = cwd
end

---@param test_path string
---@param test_name_regex string?
---@return table | nil
function M.get_dap_config(test_path, test_name_regex)
  local dap_manual_opts = options.get().dap_manual_opts or {}
  if type(dap_manual_opts) == "function" then
    dap_manual_opts = dap_manual_opts()
  end

  local dap_config = dap.configurations[dap_manual_opts.type]
  dap_config.program = test_path

  if test_name_regex ~= nil then
    dap_config.args = dap_config.args or {}
    table.insert(dap_config.args, "-test.run")
    table.insert(dap_config.args, test_name_regex)
  end
  return dap.configurations[dap_manual_opts.type]
end

function M.assert_dap_prerequisites()
  local dap_manual_opts = options.get().dap_manual_opts or {}
  if type(dap_manual_opts) == "function" then
    dap_manual_opts = dap_manual_opts()
  end

  local dap_adapter = dap_manual_opts.type

  if dap.configurations[dap_adapter] == nil then
    local msg = "You enabled manual dap configuration instead of using leoluz/nvim-dap-go but your dap config does not contains adapter: "
      .. dap_adapter
    logger.error(msg)
    error(msg)
  end
end

return M

