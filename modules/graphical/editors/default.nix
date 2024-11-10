{
  lib,
  config,
  ...
}: {
  imports = [
    ./obsidian.nix
    ./vscode.nix
  ];
  options = {
    obsidian = {
      enable = lib.mkEnableOption {
        description = "Enable Obsidian Notes";
        default = false;
      };
    };
    vscode = {
      enable = lib.mkEnableOption {
        description = "Enable VSCode.";
        default = false;
      };
    };
  };
}
