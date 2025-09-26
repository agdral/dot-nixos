{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ripgrep
    fd
    jq
    fzf
    ouch
    p7zip
    yazi
  ];
}
