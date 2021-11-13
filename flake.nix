{
  description = ''
    A LaTeX project shell. It takes care of all the configuration, setup
    directory structure problems, so users can focus on writing content.
  '';

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      texlive = with pkgs.texlive; (combine {
        inherit scheme-basic microtype mathpazo babel babel-english amsmath palatino;
      });
      inherit (pkgs) lib stdenv mkShell watchexec xdg-utils;
    in
    {
      defaultPackage."${system}" = stdenv.mkDerivation {
        name = "buildLatexProject";
        src = builtins.path { path = ./.; name = "build-latex-project"; };
        installPhase = "bash ${./install.sh}";
        xdg_utils = xdg-utils;
        inherit texlive watchexec;
      };
    };
}
