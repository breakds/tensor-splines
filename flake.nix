{
  description = "Tensor-based Spline Utilities";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";    
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs: flake-utils.lib.eachSystem [
    "x86_64-linux"
  ] (system: let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShell rec {
      name = "tensor-splines";
      packages = with pkgs; [
        poetry
      ];
      shellHook = ''
        export PS1="$(echo -e '\uf3e2') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        export PYTHONPATH="$(pwd):$PYTHONPATH"
      '';
    };
  });
}
