local M = {}

function M.config()
  local log = require("conjure.log")
  local client = require("conjure.client")
  local server = require("conjure.client.clojure.nrepl.server")
  local action = require("conjure.client.clojure.nrepl.action")
  local auto_repl = require("conjure.client.clojure.nrepl.auto-repl")

  vim.g["conjure#client_on_load"] = false
  vim.g["conjure#completion#omnifunc"] = false
  vim.g["conjure#completion#fallback"] = false
  vim.g["conjure#client#clojure#nrepl#mapping#refresh_changed"] = "rm"

  local client_state = function(key)
    if key == nil or key == "" then
      return client["state-key"]()
    else
      return client["set-state-key!"](key)
    end
  end

  local is_connected = function()
    return server["connected?"]()
  end

  local connect = function(cb)
    if not is_connected() then
      return action["connect-port-file"]({ ["silent?"] = true, ["cb"] = cb })
    else
      if cb then
        cb()
      end
    end
  end

  local autorepl = function()
    if not is_connected() then
      return auto_repl["upsert-auto-repl-proc"]()
    end
  end

  local is_log_buf = function(path)
    return log["log-buf?"](path)
  end

  local clone_fresh_session = function()
    action["clone-fresh-session"]()
  end

  local shadow_select = function(build)
    action["shadow-select"](build)
  end

  local conjure_session_setup_group = vim.api.nvim_create_augroup("conjure_session_setup", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = conjure_session_setup_group,
    pattern = { "*.clj", "*.cljc" },
    callback = function()
      local path = vim.fn.expand("%:p")
      if is_log_buf(path) then
        return
      end

      client_state("clj")
      if not is_connected() then
        connect()
      end
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = conjure_session_setup_group,
    pattern = "*.cljs",
    callback = function()
      local cljs_setup = function()
        client_state("cljs")
        if not is_connected() then
          connect(function()
            vim.schedule(function()
              clone_fresh_session()
              vim.defer_fn(function()
                shadow_select("app")
              end, 150)
            end)
          end)
        end
      end

      client_state("clj")
      if not is_connected() then
        connect(function()
          vim.defer_fn(function()
            cljs_setup()
          end, 150)
        end)
      else
        cljs_setup()
      end
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = conjure_session_setup_group,
    pattern = "*.bb",
    callback = function()
      client_state("bb")
      if not is_connected() then
        vim.schedule(function()
          autorepl()
          vim.defer_fn(function()
            connect()
          end, 150)
        end)
      end
    end,
  })

  local conjure_log_group = vim.api.nvim_create_augroup("conjure_log", { clear = true })
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = conjure_log_group,
    pattern = "conjure-log-*",
    callback = function()
      local buffer = vim.api.nvim_get_current_buf()
      vim.diagnostic.enable(false, { bufnr = buffer })
    end,
  })
end

return M
