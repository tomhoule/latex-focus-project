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
      inherit (pkgs) lib stdenv watchexec xdg-utils;
    in
    {
      defaultPackage."${system}" = stdenv.mkDerivation {
        name = "buildLatexProject";
        src = builtins.path { path = ./.; name = "build-latex-project"; };
        preInstall = ./install.sh;
        buildInputs = [ texlive watchexec xdg-utils ];
      };

      mkLatexProject = ({ name, src }: stdenv.mkDerivation {
        inherit name src;
        buildInputs = [ self.defaultPackage."${system}" ];
        buildPhase = ''
          export TARGET_LATEX_FILE="$TMPDIR/assembled_file.tex"
          export TARGET_PDF="$TMPDIR/assembled_file.pdf"
          buildLatexProject
        '';
        installPhase = ''
          mkdir $out
          cp $TARGET_PDF $out/${name}.pdf
        '';
      });

      packages."${system}".texlive = texlive;
    };
}
