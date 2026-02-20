{
  vscode-server,
  ...
}: {
  imports = [
    vscode-server.nixosModules.default
  ];
}