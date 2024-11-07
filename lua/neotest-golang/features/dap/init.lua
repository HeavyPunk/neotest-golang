--- DAP setup related functions.

local options = require("neotest-golang.options")

local M = {}

local dap_manual_enabled = options.get().dap_manual_enabled
if type(dap_manual_enabled) == "function" then
  dap_manual_enabled = dap_manual_enabled()
end

if dap_manual_enabled then
  M = require("neotest-golang.features.dap.dap_manual")
else
  M = require("neotest-golang.features.dap.dap_go")
end

return M
