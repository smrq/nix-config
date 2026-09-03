{
  lib,
  pkgs,
  ...
}: let
  godot-mcp = let
    pname = "godot-mcp";
    version = "3.1.0";
  in pkgs.buildNpmPackage {
    inherit pname version;

    src = pkgs.fetchFromGitHub {
      owner = "tugcantopaloglu";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-cBsaH2/UmN7sVSjgN11W8IICmSgnB0+nR/G2goAKElU=";
    };

    npmDepsHash = "sha256-quREzgVwNmY+kZ4vqhTmerSIJvMqVVYfUQzQ42qZPrU=";
    npmInstallFlags = [ "--ignore-scripts" ];
    npmBuildFlags = [
      "run"
      "build"
    ];

    doCheck = false;

    meta = {
      description = "MCP server for interfacing with Godot game engine";
      longDescription = ''
        A Model Context Protocol (MCP) server for interacting with the Godot
        game engine. Enables AI assistants to launch the Godot editor, run
        projects, capture debug output, and control project execution.
      '';
      mainProgram = "godot-mcp";
      homepage = "https://github.com/tugcantopaloglu/godot-mcp";
      license = lib.licenses.mit;
      maintainers = [ ];
      platforms = lib.platforms.all;
    };
  };
in {
  environment.systemPackages = [
    pkgs.godot_4_7
    godot-mcp
  ];
}
