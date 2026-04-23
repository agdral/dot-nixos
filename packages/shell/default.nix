{pkgs, ...}: {
  environment.pathsToLink = ["/share/fish" "/share/zsh"];
  environment.systemPackages = with pkgs; [
    btop
    wget
    wev
    dust
    just
    bat
    git
    pdftk
    gita
    rsync
    unar
    openssl
    inetutils
  ];
}
