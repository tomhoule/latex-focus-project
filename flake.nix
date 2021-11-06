{
  description = ''
    A LaTeX project shell. It takes care of all the configuration, setup
    directory structure problems, so users can focus on writing content.
  '';

  # inputs = {
  #   nixpkgs.url = "nixpkgs/nixos-unstable";
  # };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
      texlive = with pkgs.texlive; (combine {
        inherit scheme-basic microtype mathpazo babel babel-english amsmath palatino;
      });
    in
    {
      packages."${system}".buildLatexProject = derivation {
        name = "buildLatexProject";
        src = ./.;
        builder = "${pkgs.bash}/bin/bash";
        args = [ ./builder.sh ];

        coreutils = pkgs.coreutils;

        inherit system;
      };

      devShell.${system} = with pkgs; mkShell {
        packages = [ texlive watchexec self.packages.${system}.buildLatexProject ];
        shellHook = ''
          export BUILD_DIR=`mktemp -d`;
          export TARGET_LATEX_FILE="$BUILD_DIR/assembled_file.tex";
          export TARGET_PDF="$BUILD_DIR/assembled_file.pdf";

          function watch () {
            buildLatexProject;
            openPdf;
            watchexec --restart --clear --debounce 200 -- buildLatexProject
          }

          function openPdf () {
            zathura --fork $TARGET_PDF
          }
        '';
      };
    };
}
