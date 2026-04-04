{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
    python3
    xdg-utils
    wl-clipboard
    trash-cli
    wakeonlan
    zsh
    fish
    nushell
    starship
    atuin
    zoxide
  ];
}
