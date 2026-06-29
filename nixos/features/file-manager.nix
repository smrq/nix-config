{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kdePackages.ark
    kdePackages.dolphin
  ];
}
