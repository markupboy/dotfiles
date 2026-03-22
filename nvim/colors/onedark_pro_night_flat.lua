-- Name:       One Dark Pro Night Flat
-- Description: Converted from VS Code One Dark Pro (Night Flat variant)
-- License:     MIT
-- Website:     https://github.com/Binaryify/OneDark-Pro

local M = {}

-- ==========================================================================
-- Palette
-- ==========================================================================
M.palette = {
  bg0       = '#16191d',  -- editor background
  bg1       = '#1e2227',  -- popups, widgets
  bg2       = '#2c313c',  -- cursor line, inlay hints
  bg3       = '#3e4452',  -- focus border, visual
  bg4       = '#515a6b',  -- bracket match
  fg0       = '#abb2bf',  -- editor foreground
  fg1       = '#d7dae0',  -- active/bright foreground
  fg2       = '#9da5b4',  -- statusline fg
  fg3       = '#6b717d',  -- inactive fg
  gutter    = '#667187',  -- line numbers
  guide     = '#3b4048',  -- indent guides
  red       = '#e06c75',
  green     = '#98c379',
  yellow    = '#e5c07b',
  orange    = '#d19a66',
  blue      = '#61afef',
  purple    = '#c678dd',
  cyan      = '#56b6c2',
  comment   = '#7f848e',
  cursor    = '#528bff',
  err       = '#c24038',
  git_add   = '#109868',
  git_mod   = '#948b60',
  git_del   = '#9a353d',
}

-- Terminal colors
M.terminal = {
  '#3f4451', '#e05561', '#8cc265', '#d18f52',
  '#4aa5f0', '#c162de', '#42b3c2', '#d7dae0',
  '#4f5666', '#ff616e', '#a5e075', '#f0a45d',
  '#4dc4ff', '#de73ff', '#4cd1e0', '#e6e6e6',
}

function M.setup()
  vim.cmd('highlight clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  vim.o.background = 'dark'
  vim.g.colors_name = 'onedark_pro_night_flat'

  local c = M.palette
  local hl = vim.api.nvim_set_hl

  -- Terminal colors
  for i, color in ipairs(M.terminal) do
    vim.g['terminal_color_' .. (i - 1)] = color
  end

  -- ========================================================================
  -- Editor UI
  -- ========================================================================
  hl(0, 'Normal',        { fg = c.fg0, bg = c.bg0 })
  hl(0, 'NormalNC',      { fg = c.fg0, bg = c.bg0 })
  hl(0, 'NormalFloat',   { fg = c.fg0, bg = c.bg1 })
  hl(0, 'FloatBorder',   { fg = c.bg3, bg = c.bg1 })
  hl(0, 'FloatTitle',    { fg = c.blue, bg = c.bg1, bold = true })
  hl(0, 'Cursor',        { fg = '#ffffff', bg = c.cursor })
  hl(0, 'lCursor',       { fg = '#ffffff', bg = c.cursor })
  hl(0, 'CursorIM',      { fg = '#ffffff', bg = c.cursor })
  hl(0, 'CursorLine',    { bg = c.bg2 })
  hl(0, 'CursorColumn',  { bg = c.bg2 })
  hl(0, 'ColorColumn',   { bg = c.bg2 })
  hl(0, 'LineNr',        { fg = c.gutter })
  hl(0, 'CursorLineNr',  { fg = c.fg0, bg = c.bg2 })
  hl(0, 'SignColumn',     { bg = c.bg0 })
  hl(0, 'VertSplit',     { fg = '#181a1f', bg = c.bg0 })
  hl(0, 'WinSeparator',  { fg = '#181a1f', bg = c.bg0 })

  hl(0, 'StatusLine',    { fg = c.fg2, bg = c.bg0 })
  hl(0, 'StatusLineNC',  { fg = c.fg3, bg = c.bg0 })
  hl(0, 'TabLine',       { fg = c.fg0, bg = c.bg0 })
  hl(0, 'TabLineFill',   { bg = c.bg0 })
  hl(0, 'TabLineSel',    { fg = '#dcdcdc', bg = '#23272e' })

  hl(0, 'Pmenu',         { fg = c.fg0, bg = c.bg1 })
  hl(0, 'PmenuSel',      { fg = c.fg0, bg = '#2c313a' })
  hl(0, 'PmenuSbar',     { bg = c.bg1 })
  hl(0, 'PmenuThumb',    { bg = '#4e5666' })

  hl(0, 'Visual',        { bg = c.bg3 })
  hl(0, 'VisualNOS',     { bg = c.bg3 })
  hl(0, 'Search',        { bg = '#3d3028' })
  hl(0, 'IncSearch',     { fg = c.bg0, bg = c.orange })
  hl(0, 'CurSearch',     { fg = c.bg0, bg = c.yellow })
  hl(0, 'Substitute',    { fg = c.bg0, bg = c.orange })

  hl(0, 'MatchParen',    { bg = c.bg4, bold = true })
  hl(0, 'Folded',        { fg = c.comment, bg = c.bg2 })
  hl(0, 'FoldColumn',    { fg = c.gutter, bg = c.bg0 })
  hl(0, 'NonText',       { fg = c.guide })
  hl(0, 'SpecialKey',    { fg = c.guide })
  hl(0, 'Whitespace',    { fg = c.guide })
  hl(0, 'EndOfBuffer',   { fg = c.bg0 })

  hl(0, 'Directory',     { fg = c.blue })
  hl(0, 'Title',         { fg = c.blue, bold = true })
  hl(0, 'Question',      { fg = c.blue })
  hl(0, 'MoreMsg',       { fg = c.blue })
  hl(0, 'ModeMsg',       { fg = c.fg0, bold = true })
  hl(0, 'WarningMsg',    { fg = c.orange })
  hl(0, 'ErrorMsg',      { fg = c.red, bold = true })
  hl(0, 'WildMenu',      { fg = c.blue, bg = c.bg2 })
  hl(0, 'Conceal',       { fg = c.comment })
  hl(0, 'WinBar',        { fg = c.fg0, bg = c.bg0 })
  hl(0, 'WinBarNC',      { fg = c.fg3, bg = c.bg0 })

  -- ========================================================================
  -- Diff
  -- ========================================================================
  hl(0, 'DiffAdd',       { bg = '#162e25' })
  hl(0, 'DiffChange',    { bg = '#2c2a23' })
  hl(0, 'DiffDelete',    { fg = c.git_del, bg = '#2c1c1f' })
  hl(0, 'DiffText',      { bg = '#3f3b2a' })
  hl(0, 'diffAdded',     { fg = c.green })
  hl(0, 'diffRemoved',   { fg = c.red })
  hl(0, 'diffChanged',   { fg = c.yellow })
  hl(0, 'diffFile',      { fg = c.blue, bold = true })
  hl(0, 'diffLine',      { fg = c.comment })

  -- ========================================================================
  -- Diagnostics
  -- ========================================================================
  hl(0, 'DiagnosticError',          { fg = c.err })
  hl(0, 'DiagnosticWarn',           { fg = c.orange })
  hl(0, 'DiagnosticInfo',           { fg = c.blue })
  hl(0, 'DiagnosticHint',           { fg = c.cyan })
  hl(0, 'DiagnosticUnderlineError', { sp = c.err, undercurl = true })
  hl(0, 'DiagnosticUnderlineWarn',  { sp = c.orange, undercurl = true })
  hl(0, 'DiagnosticUnderlineInfo',  { sp = c.blue, undercurl = true })
  hl(0, 'DiagnosticUnderlineHint',  { sp = c.cyan, undercurl = true })
  hl(0, 'DiagnosticVirtualTextError', { fg = c.err, bg = '#1d1a1d' })
  hl(0, 'DiagnosticVirtualTextWarn',  { fg = c.orange, bg = '#1e1c1e' })
  hl(0, 'DiagnosticVirtualTextInfo',  { fg = c.blue, bg = '#1b1e24' })
  hl(0, 'DiagnosticVirtualTextHint',  { fg = c.cyan, bg = '#1a1e20' })

  -- ========================================================================
  -- Git signs (gutter)
  -- ========================================================================
  hl(0, 'GitSignsAdd',    { fg = c.git_add })
  hl(0, 'GitSignsChange', { fg = c.git_mod })
  hl(0, 'GitSignsDelete', { fg = c.git_del })
  hl(0, 'GitGutterAdd',    { fg = c.git_add })
  hl(0, 'GitGutterChange', { fg = c.git_mod })
  hl(0, 'GitGutterDelete', { fg = c.git_del })

  -- ========================================================================
  -- Syntax highlighting
  -- ========================================================================
  hl(0, 'Comment',        { fg = c.comment, italic = true })
  hl(0, 'Constant',       { fg = c.orange })
  hl(0, 'String',         { fg = c.green })
  hl(0, 'Character',      { fg = c.green })
  hl(0, 'Number',         { fg = c.orange })
  hl(0, 'Boolean',        { fg = c.orange })
  hl(0, 'Float',          { fg = c.orange })

  hl(0, 'Identifier',     { fg = c.red })
  hl(0, 'Function',       { fg = c.blue })

  hl(0, 'Statement',      { fg = c.purple })
  hl(0, 'Conditional',    { fg = c.purple })
  hl(0, 'Repeat',         { fg = c.purple })
  hl(0, 'Label',          { fg = c.red })
  hl(0, 'Operator',       { fg = c.cyan })
  hl(0, 'Keyword',        { fg = c.purple })
  hl(0, 'Exception',      { fg = c.purple })

  hl(0, 'PreProc',        { fg = c.purple })
  hl(0, 'Include',        { fg = c.purple })
  hl(0, 'Define',         { fg = c.purple })
  hl(0, 'Macro',          { fg = c.orange })
  hl(0, 'PreCondit',      { fg = c.purple })

  hl(0, 'Type',           { fg = c.yellow })
  hl(0, 'StorageClass',   { fg = c.purple })
  hl(0, 'Structure',      { fg = c.yellow })
  hl(0, 'Typedef',        { fg = c.yellow })

  hl(0, 'Special',        { fg = c.cyan })
  hl(0, 'SpecialChar',    { fg = c.cyan })
  hl(0, 'Tag',            { fg = c.red })
  hl(0, 'Delimiter',      { fg = c.fg0 })
  hl(0, 'SpecialComment', { fg = c.comment, italic = true })
  hl(0, 'Debug',          { fg = c.red })

  hl(0, 'Underlined',     { fg = c.blue, underline = true })
  hl(0, 'Error',          { fg = c.red, bold = true })
  hl(0, 'Todo',           { fg = c.purple, bg = c.bg0, bold = true })

  -- ========================================================================
  -- Treesitter
  -- ========================================================================
  hl(0, '@variable',              { fg = c.red })
  hl(0, '@variable.builtin',      { fg = c.yellow })
  hl(0, '@variable.parameter',    { fg = c.fg0 })
  hl(0, '@variable.member',       { fg = c.red })
  hl(0, '@constant',              { fg = c.orange })
  hl(0, '@constant.builtin',      { fg = c.orange })
  hl(0, '@constant.macro',        { fg = c.orange })
  hl(0, '@module',                { fg = c.yellow })
  hl(0, '@string',                { fg = c.green })
  hl(0, '@string.escape',         { fg = c.cyan })
  hl(0, '@string.regexp',         { fg = c.red })
  hl(0, '@character',             { fg = c.green })
  hl(0, '@number',                { fg = c.orange })
  hl(0, '@boolean',               { fg = c.orange })
  hl(0, '@float',                 { fg = c.orange })
  hl(0, '@function',              { fg = c.blue })
  hl(0, '@function.builtin',      { fg = c.cyan })
  hl(0, '@function.call',         { fg = c.blue })
  hl(0, '@function.macro',        { fg = c.orange })
  hl(0, '@function.method',       { fg = c.blue })
  hl(0, '@function.method.call',  { fg = c.blue })
  hl(0, '@constructor',           { fg = c.yellow })
  hl(0, '@operator',              { fg = c.cyan })
  hl(0, '@keyword',               { fg = c.purple })
  hl(0, '@keyword.function',      { fg = c.purple })
  hl(0, '@keyword.operator',      { fg = c.purple })
  hl(0, '@keyword.import',        { fg = c.purple })
  hl(0, '@keyword.return',        { fg = c.purple })
  hl(0, '@keyword.exception',     { fg = c.purple })
  hl(0, '@keyword.conditional',   { fg = c.purple })
  hl(0, '@keyword.repeat',        { fg = c.purple })
  hl(0, '@keyword.storage',       { fg = c.purple })
  hl(0, '@type',                  { fg = c.yellow })
  hl(0, '@type.builtin',          { fg = c.yellow })
  hl(0, '@type.qualifier',        { fg = c.purple })
  hl(0, '@type.definition',       { fg = c.yellow })
  hl(0, '@attribute',             { fg = c.orange })
  hl(0, '@property',              { fg = c.red })
  hl(0, '@comment',               { fg = c.comment, italic = true })
  hl(0, '@punctuation.bracket',   { fg = c.fg0 })
  hl(0, '@punctuation.delimiter', { fg = c.fg0 })
  hl(0, '@punctuation.special',   { fg = c.cyan })
  hl(0, '@tag',                   { fg = c.red })
  hl(0, '@tag.attribute',         { fg = c.orange })
  hl(0, '@tag.delimiter',         { fg = c.fg0 })
  hl(0, '@markup.heading',        { fg = c.red, bold = true })
  hl(0, '@markup.bold',           { fg = c.orange, bold = true })
  hl(0, '@markup.italic',         { fg = c.purple, italic = true })
  hl(0, '@markup.strikethrough',  { fg = c.comment, strikethrough = true })
  hl(0, '@markup.link',           { fg = c.purple })
  hl(0, '@markup.link.url',       { fg = c.cyan, underline = true })
  hl(0, '@markup.link.label',     { fg = c.blue })
  hl(0, '@markup.raw',            { fg = c.green })
  hl(0, '@markup.list',           { fg = c.yellow })

  -- ========================================================================
  -- LSP Semantic tokens
  -- ========================================================================
  hl(0, '@lsp.type.namespace',     { fg = c.yellow })
  hl(0, '@lsp.type.type',          { fg = c.yellow })
  hl(0, '@lsp.type.class',         { fg = c.yellow })
  hl(0, '@lsp.type.enum',          { fg = c.yellow })
  hl(0, '@lsp.type.interface',     { fg = c.yellow })
  hl(0, '@lsp.type.struct',        { fg = c.yellow })
  hl(0, '@lsp.type.parameter',     { fg = c.fg0 })
  hl(0, '@lsp.type.variable',      { fg = c.red })
  hl(0, '@lsp.type.property',      { fg = c.red })
  hl(0, '@lsp.type.enumMember',    { fg = c.cyan })
  hl(0, '@lsp.type.function',      { fg = c.blue })
  hl(0, '@lsp.type.method',        { fg = c.blue })
  hl(0, '@lsp.type.macro',         { fg = c.orange })
  hl(0, '@lsp.type.decorator',     { fg = c.orange })
  hl(0, '@lsp.mod.defaultLibrary', { fg = c.yellow })

  -- ========================================================================
  -- Plugin: Telescope
  -- ========================================================================
  hl(0, 'TelescopeNormal',       { fg = c.fg0, bg = c.bg1 })
  hl(0, 'TelescopeBorder',       { fg = c.bg3, bg = c.bg1 })
  hl(0, 'TelescopePromptNormal', { fg = c.fg0, bg = c.bg2 })
  hl(0, 'TelescopePromptBorder', { fg = c.bg2, bg = c.bg2 })
  hl(0, 'TelescopePromptTitle',  { fg = c.bg0, bg = c.blue, bold = true })
  hl(0, 'TelescopePreviewTitle', { fg = c.bg0, bg = c.green, bold = true })
  hl(0, 'TelescopeResultsTitle', { fg = c.bg1, bg = c.bg1 })
  hl(0, 'TelescopeSelection',    { fg = c.fg1, bg = '#2c313a' })
  hl(0, 'TelescopeMatching',     { fg = c.orange, bold = true })

  -- ========================================================================
  -- Plugin: nvim-cmp
  -- ========================================================================
  hl(0, 'CmpItemAbbrMatch',      { fg = c.blue, bold = true })
  hl(0, 'CmpItemAbbrMatchFuzzy', { fg = c.blue, bold = true })
  hl(0, 'CmpItemKindFunction',   { fg = c.blue })
  hl(0, 'CmpItemKindMethod',     { fg = c.blue })
  hl(0, 'CmpItemKindVariable',   { fg = c.red })
  hl(0, 'CmpItemKindKeyword',    { fg = c.purple })
  hl(0, 'CmpItemKindText',       { fg = c.fg0 })
  hl(0, 'CmpItemKindClass',      { fg = c.yellow })
  hl(0, 'CmpItemKindStruct',     { fg = c.yellow })
  hl(0, 'CmpItemKindInterface',  { fg = c.yellow })

  -- ========================================================================
  -- Plugin: indent-blankline
  -- ========================================================================
  hl(0, 'IndentBlanklineChar',        { fg = c.guide })
  hl(0, 'IndentBlanklineContextChar', { fg = c.purple })
  hl(0, 'IblIndent',                  { fg = c.guide })
  hl(0, 'IblScope',                   { fg = c.purple })

  -- ========================================================================
  -- Plugin: Lazy / Mason
  -- ========================================================================
  hl(0, 'LazyH1',          { fg = c.bg0, bg = c.blue, bold = true })
  hl(0, 'LazyButton',      { fg = c.fg0, bg = c.bg2 })
  hl(0, 'LazyButtonActive', { fg = c.bg0, bg = c.blue, bold = true })
  hl(0, 'MasonHeader',     { fg = c.bg0, bg = c.blue, bold = true })

  -- ========================================================================
  -- Plugin: nvim-notify
  -- ========================================================================
  hl(0, 'NotifyERRORBorder', { fg = c.err })
  hl(0, 'NotifyWARNBorder',  { fg = c.orange })
  hl(0, 'NotifyINFOBorder',  { fg = c.blue })
  hl(0, 'NotifyDEBUGBorder', { fg = c.comment })
  hl(0, 'NotifyTRACEBorder', { fg = c.purple })
  hl(0, 'NotifyERRORIcon',   { fg = c.err })
  hl(0, 'NotifyWARNIcon',    { fg = c.orange })
  hl(0, 'NotifyINFOIcon',    { fg = c.blue })
  hl(0, 'NotifyDEBUGIcon',   { fg = c.comment })
  hl(0, 'NotifyTRACEIcon',   { fg = c.purple })
  hl(0, 'NotifyERRORTitle',  { fg = c.err })
  hl(0, 'NotifyWARNTitle',   { fg = c.orange })
  hl(0, 'NotifyINFOTitle',   { fg = c.blue })
  hl(0, 'NotifyDEBUGTitle',  { fg = c.comment })
  hl(0, 'NotifyTRACETitle',  { fg = c.purple })

  -- ========================================================================
  -- Plugin: which-key
  -- ========================================================================
  hl(0, 'WhichKey',          { fg = c.purple })
  hl(0, 'WhichKeyGroup',     { fg = c.blue })
  hl(0, 'WhichKeySeparator', { fg = c.comment })
  hl(0, 'WhichKeyDesc',      { fg = c.fg0 })
  hl(0, 'WhichKeyFloat',     { bg = c.bg1 })
end

M.setup()

return M
