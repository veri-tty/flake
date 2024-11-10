{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.vscode.enable {
    environment.systemPackages = [
      pkgs.alejandra
    ];
    home-manager.users.${config.user}.programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = [
        pkgs.vscode-extensions.kamadorueda.alejandra
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.github.copilot-chat
        pkgs.vscode-extensions.brandonkirbyson.solarized-palenight
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";

        ## No auto-sync
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "workbench.colorTheme" = "Evans Dark Theme";
        "workbench.iconTheme" = "catppuccin-macchiato";

        ## Auto save
        "files.autoSave" = "onFocusChange";

        ## Indentation
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;

        ## Font
        "editor.fontFamily" = "'Victor'";
        "editor.fontSize" = config.font.size + 5;
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
