{
  outputs = { self, nixpkgs }:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ self.overlay ];
    };
    mkApp = pkgs: pkgs.multiStdenv.mkDerivation {
      pname = "pop3-rev";
      version = "0.0.1";
      src = ./.;
      buildInputs = with pkgs; [
        #gcc_multi
        pkgsCross.mingw32.buildPackages.gcc
      ];
    };
  in {
    overlay = final: prev: {
      pop3-rev = mkApp final;
    };

    defaultPackage.x86_64-linux = pkgs.pop3-rev;
  };
}
