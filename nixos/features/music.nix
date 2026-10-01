{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    audacious
    chromaprint # Required for AcoustID scanning/fingerprinting
    feishin
    picard
    rescrobbled
    spotify
  ];
}
