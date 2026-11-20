-- `:checkhealth config`: checks the Neovim version and the external tools this config uses
local M = {}

local health = vim.health

---@param name string
local function has(name) return vim.fn.executable(name) == 1 end

local function check_version()
  local version = tostring(vim.version())
  if vim.version.ge(vim.version(), '0.11') then
    health.ok('Neovim ' .. version)
  else
    health.error('Neovim ' .. version .. ' is too old', 'Install Neovim 0.11 or newer')
  end
end

local function check_required_tools()
  local tools = {
    { 'git', 'installing and updating plugins' },
    { 'make', 'building telescope-fzf-native' },
    { 'rg', 'Telescope live grep' },
    { 'tree-sitter', 'installing treesitter parsers' },
    { 'node', 'Node-based language servers and prettierd' },
    { 'npm', 'installing Node-based tools with Mason' },
  }
  for _, tool in ipairs(tools) do
    local name, purpose = tool[1], tool[2]
    if has(name) then
      health.ok(('%s found'):format(name))
    else
      health.error(('%s not found (needed for %s)'):format(name, purpose))
    end
  end

  local compilers = { 'cc', 'gcc', 'clang', 'zig' }
  for _, name in ipairs(compilers) do
    if has(name) then
      health.ok(('C compiler found: %s'):format(name))
      return
    end
  end
  health.error('No C compiler found (needed to compile treesitter parsers)', 'Install one of: ' .. table.concat(compilers, ', '))
end

local function check_optional_tools()
  if has 'cargo' then
    health.ok 'cargo found'
  else
    health.warn('cargo not found', 'Install the Rust toolchain (rustup) for rustfmt and clippy')
  end
end

function M.check()
  health.start 'Neovim version'
  check_version()

  health.start 'Required tools'
  check_required_tools()

  health.start 'Optional tools'
  check_optional_tools()
end

return M
