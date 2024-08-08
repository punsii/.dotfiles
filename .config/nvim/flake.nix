{
  description = "Dev Shell for my editor config xD";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        # Used to find the project root
        projectRootFile = "flake.nix";

        # Enable the formatters
        programs.stylua.enable = true;
        programs.nixfmt.enable = true;
        programs.prettier = {
          enable = true;
          excludes = [
            "data/*"
            "flake.lock"
            "lazy-lock.json"
          ];
        };
      };
    in
    {
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
      devShells.x86_64-linux.default =
        with pkgs;
        mkShell {
          buildInputs = [
            treefmtEval.config.build.wrapper
            lua-language-server
          ];
        };
    };
}
