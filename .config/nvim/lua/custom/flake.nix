{
  description = "Dev Shell for my editor config xD";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs; mkShell {
        buildInputs = [
          nixpkgs-fmt
          stylua
          treefmt
        ];
      };
  };
}
