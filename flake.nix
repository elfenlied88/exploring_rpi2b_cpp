{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      #   64-bit Raspberry Pi OS (Pi 3/4/5, Zero 2):  aarch64-multiplatform
      #   32-bit Raspberry Pi OS (Pi 2/3/4):          armv7l-hf-multiplatform
      cross = pkgs.pkgsCross.armv7l-hf-multiplatform;
    in
    {
      # `nix build` cross-compiles the program for the Pi
      packages.${system}.default = cross.stdenv.mkDerivation {
        pname = "exploring_rpi2b_cpp";
        version = "0.1";
        src = ./.;
        nativeBuildInputs = [
          pkgs.cmake
          pkgs.ninja
        ];
        # libraries for the Pi go here, e.g.:  buildInputs = [ cross.libgpiod ];
      };

      # `nix develop` gives tools for editing and debugging
      devShells.${system}.default =
        let
          cross = pkgs.pkgsCross.armv7l-hf-multiplatform;
        in
        cross.mkShell {
          nativeBuildInputs = with pkgs; [
            gnumake
            bear
            clang-tools
            qemu
          ];
          buildInputs = [ cross.libgpiod ];
        };
    };
}
