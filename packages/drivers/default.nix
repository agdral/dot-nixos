{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
    python3
    unar
    xdg-utils
    wl-clipboard
    trash-cli
    rsync
    wakeonlan
    gita
    sshpass
  ];
}
