let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell rec {
  name = "remix-aws-deploy";

  buildInputs = with pkgs; [
    nodejs-18_x
    terraform
    # Add your global packages here
  ];
}
