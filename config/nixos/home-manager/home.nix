{
  homeUser,
  config,
  lib,
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{

  home.username = homeUser;
  home.homeDirectory = (
    if isLinux then "/home/${config.home.username}" else "/Users/${config.home.username}"
  );

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vif = "fzf --preview 'bat {}' | xargs -r nvim";
    ls = "eza -l --icons -s extension";
    cat = "bat";
    lg = "lazygit";
  };

  home.packages = with pkgs; [
    awscli2
    bat
    delta
    eza
    fd
    fzf
    gcc
    gh
    git
    jq
    k9s
    kubectl
    kubernetes-helm
    lazygit
    lf
    lua-language-server
    marksman
    neovim
    nerd-fonts.jetbrains-mono
    nixfmt-rfc-style
    podman
    stylua
    tmux
    unzip
  ];

  home.file = {
    ".config/sway".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/sway"
    );
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/nvim"
    );
    ".config/git".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/git"
    );
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/tmux"
    );
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/starship.toml"
    );
    ".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/lazygit"
    );
    ".config/bat".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/bat"
    );
    ".config/direnv".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/direnv"
    );
  };

  services.podman = lib.mkIf isLinux {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    autocd = false;
    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };

  programs.readline = {
    enable = true;
    variables = {
      expand-tilde = true;
      completion-ignore-case = true;
      show-all-if-ambiguous = true;
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    silent = true;
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--follow"
      "--glob=!{.git,node_modules,vendor}"
      "--glob=!*.{lock}"
      "--glob=!{package-lock.json}"
      "--max-columns=10000"
      "--smart-case"
      "--sort=path"
    ];
  };

  programs.keychain = {
    enable = true;
    keys = [
      "id_ed25519"
      "id_ed25519_finanssoreal"
    ];
  };

  programs.ssh = {
    enable = true;
    serverAliveInterval = 240;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "alan-oracle" = {
        hostname = "oracle.gepnir.ovh";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "alan-ovh" = {
        hostname = "gepnir.ovh";
        user = "debian";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "ftp" = {
        hostname = "ftp.finanssoreal.com";
        user = "ubuntu";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
      };
      "testing" = {
        hostname = "testing.finanssoreal.com";
        user = "debian";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
      };
      "prod" = {
        hostname = "control.finanssoreal.com";
        user = "debian";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
      };
      "redia" = {
        hostname = "redia.codes";
        user = "debian";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
      };
    };
  };
}
