{
  config,
  lib,
  pkgs,
  ...
}: {
  ## Options related to this mail account
  options = {
    mail.private = {
      enable = lib.mkEnableOption "Enable private email account";

      address = lib.mkOption {
        type = lib.types.str;
        default = "verity@cock.li";
      };

      signature = lib.mkOption {
        type = lib.types.lines;
        description = "Default mailbox signature";
        default = ''
          Mit freundlichen Grüßen / Best regards
          ml
        '';
      };

      clients = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of clients to use for this account";
        default = [];
      };

      imap-host = lib.mkOption {
        type = lib.types.str;
        default = "imap.mailbox.org";
      };

      imap-port = lib.mkOption {
        type = lib.types.int;
        default = 993;
      };

      smtp-host = lib.mkOption {
        type = lib.types.str;
        default = "smtp.mailbox.org";
      };

      smtp-port = lib.mkOption {
        type = lib.types.int;
        default = 465;
      };
    };
  };

  ## General mail settings
  config = lib.mkIf config.mail.private.enable {
    ## Setting this account as primary system wide
    mail.address = lib.mkForce config.mail.private.address;
    mail.signature = lib.mkForce config.mail.private.signature;

    ## Enabling configurations for email clients if specified
    mail.clients.thunderbird.enable = lib.mkIf (builtins.elem "thunderbird" config.mail.private.clients) true;
    mail.clients.thunderbird.primary = lib.mkForce (lib.mkIf (builtins.elem "thunderbird" config.mail.private.clients) config.mail.private.address);

    home-manager.users.${config.user} = {
      accounts.email.accounts.private = {
        thunderbird.enable = lib.mkIf (builtins.elem "thunderbird" config.mail.private.clients) true;

        maildir.path = "accounts/${config.mail.private.address}";

        ## General settings for the mail account
        primary = true;
        address = config.mail.private.address;
        userName = config.mail.private.address;
        realName = config.fullName;
        imap.host = config.mail.private.imap-host;
        imap.port = config.mail.private.imap-port;

        ## We need to expose these vars so the mbsync service knows of them
        passwordCommand = toString (pkgs.writeShellScript "get-private-password" ''
          ## ~!shell!~
          export GNUPGHOME=${config.home-manager.users.${config.user}.programs.gpg.homedir}
          export PASSWORD_STORE_DIR=${config.const.passDir}
          ${pkgs.pass}/bin/pass show Mail/mailbox.org/db@minikn.xyz | ${pkgs.coreutils}/bin/head -n 1
        '');

        ## Enable features
        msmtp.enable = true;
        ## Sign emails by default
        gpg = {
          key = "${config.const.signingKey}";
          signByDefault = true;
        };

        ## IMAP folder mapping
        folders.inbox = "inbox";

        ## mbsync settings
        mbsync = {
          enable = true;
          groups.private.channels = {
            inbox = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "INBOX";
              nearPattern = "inbox";
            };
            sent = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "Sent";
              nearPattern = "sent";
            };
            drafts = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "Drafts";
              nearPattern = "drafts";
            };
            trash = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "Trash";
              nearPattern = "trash";
            };
            spam = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "Junk";
              nearPattern = "spam";
            };
            archive = {
              extraConfig = {
                Create = "both";
                Expunge = "both";
              };
              farPattern = "Archive";
              nearPattern = "archive";
            };
          };
        };

        ## Signature settings
        signature = {
          text = config.mail.private.signature;
          showSignature = "append";
        };

        ## smtp settings
        smtp = {
          host = config.mail.private.smtp-host;
          port = config.mail.private.smtp-port;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      };
    };
  };
}
