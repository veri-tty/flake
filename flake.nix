{
  description = "verity's flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };  
    # Used for specific stable packages
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # Convert Nix to Neovim config
    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    base16-nvim-src = {
      url = "github:RRethy/base16-nvim";
      flake = false;
    };
    nvim-lspconfig-src = {
      # https://github.com/neovim/nvim-lspconfig/tags
      url = "github:neovim/nvim-lspconfig/v0.1.8";
      flake = false;
    };
    cmp-nvim-lsp-src = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    baleia-nvim-src = {
      # https://github.com/m00qek/baleia.nvim/tags
      url = "github:m00qek/baleia.nvim";
      flake = false;
    };
    nvim-treesitter-src = {
      # https://github.com/nvim-treesitter/nvim-treesitter/tags
      url = "github:nvim-treesitter/nvim-treesitter/v0.9.2";
      flake = false;
    };
    telescope-nvim-src = {
      # https://github.com/nvim-telescope/telescope.nvim/releases
      url = "github:nvim-telescope/telescope.nvim/0.1.8";
      flake = false;
    };
    telescope-project-nvim-src = {
      url = "github:nvim-telescope/telescope-project.nvim";
      flake = false;
    };
    toggleterm-nvim-src = {
      # https://github.com/akinsho/toggleterm.nvim/tags
      url = "github:akinsho/toggleterm.nvim/v2.12.0";
      flake = false;
    };
    bufferline-nvim-src = {
      # https://github.com/akinsho/bufferline.nvim/releases
      url = "github:akinsho/bufferline.nvim/v4.6.1";
      flake = false;
    };
    nvim-tree-lua-src = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
    hmts-nvim-src = {
      url = "github:calops/hmts.nvim";
      flake = false;
    };
    fidget-nvim-src = {
      # https://github.com/j-hui/fidget.nvim/tags
      url = "github:j-hui/fidget.nvim/v1.4.5";
      flake = false;
    };
    nvim-lint-src = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };
    tiny-inline-diagnostic-nvim-src = {
      url = "github:rachartier/tiny-inline-diagnostic.nvim";
      flake = false;
    };
    snipe-nvim-src = {
      url = "github:leath-dub/snipe.nvim";
      flake = false;
    };

    # Tree-Sitter Grammars
    tree-sitter-bash = {
      url = "github:tree-sitter/tree-sitter-bash/master";
      flake = false;
    };
    tree-sitter-python = {
      url = "github:tree-sitter/tree-sitter-python/master";
      flake = false;
    };
    tree-sitter-lua = {
      url = "github:MunifTanjim/tree-sitter-lua/main";
      flake = false;
    };
    tree-sitter-ini = {
      url = "github:justinmk/tree-sitter-ini";
      flake = false;
    };
    tree-sitter-puppet = {
      url = "github:amaanq/tree-sitter-puppet";
      flake = false;
    };
    tree-sitter-rasi = {
      url = "github:Fymyte/tree-sitter-rasi";
      flake = false;
    };
    tree-sitter-vimdoc = {
      url = "github:neovim/tree-sitter-vimdoc";
      flake = false;
    };

    # MPV Scripts
    zenyd-mpv-scripts = {
      url = "github:zenyd/mpv-scripts";
      flake = false;
    };

    # Ren and rep - CLI find and replace
    rep = {
      url = "github:robenkleene/rep-grep";
      flake = false;
    };
    ren = {
      url = "github:robenkleene/ren-find";
      flake = false;
    };

    gh-collaborators = {
      url = "github:katiem0/gh-collaborators";
      flake = false;
    };
    
  };

  outputs = { nixpkgs, ... } @ inputs: 

     let
      # Global configuration for my systems
      globals =
        let
          baseName = "verity.rs";
        in
        rec {
          user = "malu";
          fullName = "malu";
          gitName = "veri-tty";
          gitEmail = "verity@cock.li";
          dotfilesRepo = "https://github.com/veri-tty/flake";
        };


      overlays = [
        inputs.nur.overlay
        inputs.nix2vim.overlay
        (import ./overlays/neovim-plugins.nix inputs)
        (import ./overlays/disko.nix inputs)
        (import ./overlays/tree-sitter.nix inputs)
        (import ./overlays/mpv-scripts.nix inputs)
        (import ./overlays/nextcloud-apps.nix inputs)
        (import ./overlays/betterlockscreen.nix)
        (import ./overlays/gh-collaborators.nix inputs)
        (import ./overlays/ren-rep.nix inputs)
      ];


      supportedSystems = [
        "x86_64-linux"
      ];
    
    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {

      # Contains my full system builds, including home-manager
      # nixos-rebuild switch --flake .#roamer
      nixosConfigurations = {
        roamer = import ./hosts/roamer { inherit inputs globals overlays; };
      };

      # For quickly applying home-manager settings with:
      # home-manager switch --flake .#tempest
      homeConfigurations = {
        roamer = nixosConfigurations.roamer.config.home-manager.users.${globals.user}.home;
      };


       packages =
        let
          staff =
            system:
            import ./hosts/staff {
              inherit
                inputs
                globals
                overlays
                system
                ;
            };
          neovim =
            system:
            let
              pkgs = import nixpkgs { inherit system overlays; };
            in
            import ./modules/common/neovim/package {
              inherit pkgs;
              colors = (import ./colorscheme/gruvbox-dark).dark;
            };
        in
        {
          x86_64-linux.staff = staff "x86_64-linux";
          x86_64-linux.arrow = inputs.nixos-generators.nixosGenerate rec {
            system = "x86_64-linux";
            format = "iso";
            specialArgs = {
              pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
              pkgs-caddy = import inputs.nixpkgs-caddy { inherit system; };
            };
            modules = import ./hosts/arrow/modules.nix { inherit inputs globals overlays; };
          };
          x86_64-linux.arrow-aws = inputs.nixos-generators.nixosGenerate rec {
            system = "x86_64-linux";
            format = "amazon";
            specialArgs = {
              pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
              pkgs-caddy = import inputs.nixpkgs-caddy { inherit system; };
            };
            modules = import ./hosts/arrow/modules.nix { inherit inputs globals overlays; } ++ [
              (
                { ... }:
                {
                  boot.kernelPackages = inputs.nixpkgs.legacyPackages.x86_64-linux.linuxKernel.packages.linux_6_6;
                  amazonImage.sizeMB = 16 * 1024;
                  permitRootLogin = "prohibit-password";
                  boot.loader.systemd-boot.enable = inputs.nixpkgs.lib.mkForce false;
                  boot.loader.efi.canTouchEfiVariables = inputs.nixpkgs.lib.mkForce false;
                  services.amazon-ssm-agent.enable = true;
                  users.users.ssm-user.extraGroups = [ "wheel" ];
                }
              )
            ];
          };

          # Package Neovim config into standalone package
          x86_64-linux.neovim = neovim "x86_64-linux";
        };

      # Programs that can be run by calling this flake
      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        import ./apps { inherit pkgs; }
      );

      # Development environments
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {

          # Used to run commands and edit files in this repo
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              stylua
              nixfmt-rfc-style
              shfmt
              shellcheck
            ];
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {
          neovim =
            pkgs.runCommand "neovim-check-health" { buildInputs = [ inputs.self.packages.${system}.neovim ]; }
              ''
                mkdir -p $out
                export HOME=$TMPDIR
                nvim -c "checkhealth" -c "write $out/health.log" -c "quitall"

                # Check for errors inside the health log
                if $(grep "ERROR" $out/health.log); then
                  cat $out/health.log
                  exit 1
                fi
              '';
        }
      );
      # Programs that can be run by calling this flake
      #apps = forAllSystems (
      #  system:
      #  let
      #    pkgs = import nixpkgs { inherit system overlays; };
      #  in
      #  import ./apps { inherit pkgs; }
      #);

      # Development environments
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {

          # Used to run commands and edit files in this repo
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              stylua
              nixfmt-rfc-style
              shfmt
              shellcheck
            ];
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {
          neovim =
            pkgs.runCommand "neovim-check-health" { buildInputs = [ inputs.self.packages.${system}.neovim ]; }
              ''
                mkdir -p $out
                export HOME=$TMPDIR
                nvim -c "checkhealth" -c "write $out/health.log" -c "quitall"

                # Check for errors inside the health log
                if $(grep "ERROR" $out/health.log); then
                  cat $out/health.log
                  exit 1
                fi
              '';
        }
      );

      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        pkgs.nixfmt-rfc-style
      );

  };
}
