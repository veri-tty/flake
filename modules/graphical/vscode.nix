{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.thunderbird {
    environment.systemPackages = [
      pkgs.alejandra
    ];
    home-manager.users.${config.user}.programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = [
        pkgs.vscode-extensions.kamadorueda.alejandra
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
        pkgs.vscode-extensions.catppuccin.catppuccin-vsc
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.github.copilot-chat
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";

        ## No auto-sync
        "git.confirmSync" = false;

        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";

        ## Auto save
        "files.autoSave" = "onFocusChange";

        ## Indentation
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;

        ## Font
        "editor.fontFamily" = "'${config.os.fonts.mono.regular}', 'monospace', monospace";
        "editor.fontSize" = config.os.fonts.size + 2;
        "editor.fontLigatures" = true;

        # Vim
        "vim.handleKeys" = {
          "<C-e>" = false;
          "<C-p>" = false;
        };
      };

      keybindings = [
        {
          key = "ctrl+shift+alt+p";
          command = "eslint.executeAutofix";
        }
        {
          key = "ctrl+alt+o";
          command = "editor.action.organizeImports";
          when = "textInputFocus && !editorReadonly && supportedCodeAction =~ /(\\s|^)source\\.organizeImports\\b/";
        }
      ];
    };
  };
}
