{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
  kmod
}:

stdenv.mkDerivation rec {
  pname = "xpad";
  version = "3.2";

  src = fetchFromGitHub {
    owner = "paroj";
    repo = "xpad";
    rev = "9caad15ba366c26337bfbcf3ee1144a6cc07d9ca";
    sha256 = "sha256-wl6bZzEzLLc1OTy4EjLwmguTQVaiQgjf6WquYHeUbLg=";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernelModuleMakeFlags ++ [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];

  buildFlags = [ "modules" ];

  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Updated Xpad Linux Kernel Driver";
    homepage = "https://github.com/paroj/xpad";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
