-- ============================================================================
-- Python helpers: project-aware execution in a floating terminal (uv)
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Ensure user-local binaries (e.g. uv) are visible to Neovim
-- ---------------------------------------------------------------------------
vim.env.PATH = vim.env.HOME .. "/.local/bin:" .. vim.env.PATH

-- ---------------------------------------------------------------------------
-- Project root detection
-- ---------------------------------------------------------------------------
local function project_root()
  local markers = { "pyproject.toml", ".git" }

  local found = vim.fs.find(markers, {
    upward = true,
    stop = vim.loop.os_homedir(),
  })[1]

  return found and vim.fs.dirname(found) or vim.fn.getcwd()
end

-- ---------------------------------------------------------------------------
-- Floating terminal runner
-- ---------------------------------------------------------------------------
local function run_python_float()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file to run", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("uv") ~= 1 then
    vim.notify("uv not found in PATH", vim.log.levels.ERROR)
    return
  end

  local root = project_root()

  -- Window sizing
  local width  = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row    = math.floor((vim.o.lines - height) / 2)
  local col    = math.floor((vim.o.columns - width) / 2)

  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    row = row,
    col = col,
  })

  -- Close with q or Esc
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, silent = true })

  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, silent = true })

  -- Ensure uv runs from project root
  vim.cmd("lcd " .. vim.fn.fnameescape(root))

  -- Start terminal job
  vim.fn.termopen({
    "uv",
    "run",
    "python",
    file,
  })

  vim.cmd("startinsert")
end

-- ---------------------------------------------------------------------------
-- User command
-- ---------------------------------------------------------------------------
vim.api.nvim_create_user_command("RunPython", run_python_float, {
  desc = "Run current Python file in floating terminal (uv)",
})

-- ---------------------------------------------------------------------------
-- Keymap
-- ---------------------------------------------------------------------------
vim.keymap.set(
  "n",
  "<F5>",
  run_python_float,
  { silent = true, desc = "Run Python (floating uv)" }
)

-- ---------------------------------------------------------------------------
-- Telescope: Python docs
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ph", function()
  require("telescope").extensions.python_docs.python_docs()
end, { silent = true, desc = "Python docs" })

vim.keymap.set("v", "<leader>ph", function()
  vim.cmd('normal! "zy')
  local text = vim.fn.getreg("z")

  require("telescope").extensions.python_docs.python_docs({
    search = text,
  })
end, { silent = true, desc = "Python docs (selection)" })

