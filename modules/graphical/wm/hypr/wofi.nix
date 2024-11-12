{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
  ];
  config = lib.mkIf config.wm.hyprland.enable {
    environment.systemPackages = with pkgs; [
      wofi
    ];
    home-manager.users.${config.user} = {
      programs.wofi.enable = true;
      programs.wofi.style = ''
              /* ::root{ */
        /*     --accent: #5291e2; */
        /*     --dark:   #383C4A; */
        /*     --light:  #7C818C; */
        /*     --ld:     #404552; */
        /*     --dl:     #4B5162 */
        /*     --white:  white; */
        /* } */

        *{
          font-family: monospace;
          font-size: 1.04em;
        }

        window{
          background-color: ${config.theme.colors.base00};
        }

        #input {
          margin: 5px;
          border-radius: 0px;
          border: none;
          border-bottom: 3px solid grey;
          background-color: ${config.theme.colors.base01};
          color: white;
          font-size: 2em;
        }

        /* Suchsymbol */
        #input:first-child > :nth-child(1) {
          min-height: 1.25em;
          min-width: 1.25em;
          background-image: -gtk-icontheme('open-menu-symbolic');
        }

        /* Löschsymbol */
        #input:first-child > :nth-child(4){
          min-height: 1.25em;
          min-width: 1.25em;
          background-image: -gtk-icontheme('window-close-symbolic');
        }

        #inner-box {
          background-color: ${config.theme.colors.base02};
        }

        #outer-box {

          margin: 2px;
          padding:0px;
          background-color: ${config.theme.colors.base01};
        }

        #text {
          padding: 5px;
          color: white;
        }

        #entry:selected {
          background-color: ${config.theme.colors.base04};
        }

        #text:selected {
        }

        #scroll {
        }
        #img {
        }
        /* Gerade Elemente einfärben */
        /* #entry:nth-child(even){ */
        /*     background-color: #404552; */
        /* } */
      '';
    };
  };
}
