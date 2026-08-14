{
  config,
  inputs,
  pkgs,
  ...
}:
let
  launchScript = pkgs.writeShellScriptBin "launch-ffxiv" ''
    set -m

    if [ $# -lt 3 ]; then
      echo "Usage: $0 <username> <id> <xl-path>" >&2
      exit 1
    fi

    USERNAME=$1
    ID=$2
    XL_PATH=$3

    XL_PATH=$XL_PATH XIVLauncher.Core &
    PID=$!

    notify-send "XIVLauncher OTP" "Generating OTP for $USERNAME..."

    if [ -z "$BW_SESSION" ]; then
      echo "Unlocking Bitwarden vault..."
      BW_PASSWORD=$(sudo cat ${config.sops.secrets."vaultwarden/password".path})
      BW_SESSION="$(BW_PASSWORD=$BW_PASSWORD bw unlock --passwordenv BW_PASSWORD --raw)"
    fi
    echo "Bitwarden vault unlocked."

    # echo "Finding user credentials..."
    # ID=$(BW_SESSION=$BW_SESSION bw list items --search 'Square Enix' | jq -r --arg user "$USERNAME" '.[] | select(.login.username==$user) | .id')
    # if [ -z "$ID" ]; then
    #   echo "Error: Failed to find credentials for user $USERNAME."
    #   exit 1
    # fi
    # echo "User credentials found."

    echo "Waiting for OTP prompt..."
    while [ -z "$(ss -ltnp 'sport = :4646' | grep -oP 'pid=\K[0-9]+')" ]; do
      if ! kill -0 "$PID" 2>/dev/null; then
        echo "Error: XIVLauncher closed."
        exit 1
      fi
      sleep 1
    done

    echo "Generating OTP..."
    OTP=$(BW_SESSION=$BW_SESSION bw get totp $ID)
    URL="http://localhost:4646/ffxivlauncher/$OTP"
    echo "OTP generated."

    echo "Sending OTP to XIVLauncher..."
    curl -s -w "\nHTTP Status: %{http_code}\n" "$URL"
    echo "OTP sent."

    fg
  '';

  makeFfxivDesktopItem = { index, username, id, xlpath }: pkgs.makeDesktopItem {
    name = "xivlauncher-rb${index}";
    exec = ''sh -c "${launchScript}/bin/launch-ffxiv ${username} ${id} ${xlpath}"'';
    icon = "xivlauncher";
    desktopName = "XIVLauncher-RB ${index}";
    comment = "Custom launcher for FFXIV with additional patches";
    categories = [ "Game" ];
    startupWMClass = "XIVLauncher.Core";
  };
in {
  imports = [
    inputs.xivlauncher-rb.nixosModules.default
  ];

  environment.systemPackages = [
    ((pkgs.xivlauncher-rb.override {
      nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
    }).overrideAttrs(old: {
      desktopItems = [];
    }))
    (makeFfxivDesktopItem { index = "1"; xlpath = "~/.xlcore1"; username = "smrq"; id = "74a024ef-6cc5-4119-ae57-557fd0ed411b"; })
    (makeFfxivDesktopItem { index = "2"; xlpath = "~/.xlcore2"; username = "marianneaban"; id = "33d2de65-09b4-4b91-b255-d7b014a5f444"; })
    inputs.archon.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.archon-lite.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.sessionVariables = {
    DALAMUD_HOME = "~/.xlcore1/dalamud/Hooks/dev";
  };
}
