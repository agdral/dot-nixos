{pkgs, ...}: {
  environment.pathsToLink = ["/share/fish" "/share/zsh"];
  environment.systemPackages = with pkgs; [
    zsh
    fish
    nushell
    starship
    atuin
    zoxide
    sd
    fcp
    btop
    wget
    wev
    dust
    just
    bat
    git
  ];
}
