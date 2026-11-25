{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.neovim;

  configFile = pkgs.writeText "neovim.lua" ''
    -- Basic settings
    vim.o.number = true -- Enable line numbers
    vim.o.relativenumber = true -- Enable relative line numbers
    vim.o.tabstop = 2 -- Number of spaces a tab represents
    vim.o.shiftwidth = 2 -- Number of spaces for each indentation
    vim.o.expandtab = true -- Convert tabs to spaces
    vim.o.smartindent = true -- Automatically indent new lines
    vim.o.wrap = false -- Disable line wrapping
    vim.o.cursorline = true -- Highlight the current line
    vim.o.termguicolors = true -- Enable 24-bit RGB colors

    -- Syntax highlighting and filetype plugins
    vim.cmd('syntax enable')
    vim.cmd('filetype plugin indent on')

    -- Keyboard shortcuts
    vim.keymap.set('n', '<M-e>', ':Explore<CR>')
    vim.keymap.set('n', '<M-q>', ':q<CR>')
    vim.keymap.set('n', '<M-w>', ':w<CR>')
    vim.keymap.set('n', '<M-r>', ':%s/')
    vim.keymap.set('n', '<M-f>', '/')
  '';
in
{
  options.neovim = {
    enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];
    stateless.impermanence = {
      ensures = [
        {
          path = "/etc/xdg/nvim";
          permissions = {
            mode = "0755";
            owner = "root";
            group = "root";
          };
        }
      ];
      links = [
        {
          source = "${configFile}";
          target = "/etc/xdg/nvim/init.lua";
        }
      ];
    };
  };
}
