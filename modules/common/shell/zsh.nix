{ config, lib, pkgs, ... }:

{
  imports = [
    ../shell
  ];
  
  config = {
    ## Set shell
    #os.shell = "zsh";

    ## Enable ZSH system wide
    programs.zsh.enable = true;

    ## add zsh to `/etc/shells'
    environment.shells = with pkgs; [ zsh ];

    ## Needed for completion
    environment.pathsToLink = [ "/share/zsh" ];

    ## Enable zsh for current user
    users.users.${config.user}.shell = pkgs.zsh;

    # Add Zoxide
    home-manager.users.${config.user} = {
      programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    ## ZSH configuration
      programs.zsh = {
      enable = true;

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake /home/ml/projects/flake#";
      };

      ## Enable some QOL features
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      ## Setting config dir
      ## Path is relative to $HOME, so we can't use `xdg.configHome' here.
      dotDir = ".config/zsh";

      ## History
      history = {
        path = "${config.home-manager.users.${config.user}.xdg.cacheHome}/zsh/zsh_history";
      };

      ## Save completion dump into $XDG_CACHE_HOME
      completionInit = ''
        autoload -U compinit
        compinit -d "${config.home-manager.users.${config.user}.xdg.cacheHome}/.zcompdump"
      '';
	
      ## Setup prompt taken from RDE:
      ## https://github.com/abcdw/rde/blob/master/src/rde/features/zsh/zshrc
      initExtra = ''
	clear_fn() {
	  zle kill-buffer
	}

	prompt_rde_precmd() {
	  # Prevent killing prompt on ^C
	  trap 'clear_fn' SIGINT
	}

	prompt_rde_setup() {
	  if [[ $UID -eq 0 ]]; then
	    user_part='%1d %F{red}>%f'
	  else
	    user_part='%1d %F{green}>%f'
	  fi
	  exit_code_part='%(?..[%?])'

	  PS1="$user_part "
	  RPS1="$exit_code_part"
	}

	# Load promptinit and set rde theme
	autoload -Uz promptinit && promptinit
	prompt_themes+=( rde )
	prompt rde

	echo -en "\033[6 q" # Make a cursor to be a vertical bar
      ''; 
      };
    };
  };
}
