let
  pkgs = import <nixpkgs> { };
  unstable = import <nixos-unstable> { };
in
pkgs.mkShell rec {
  name = "remix-aws-deploy";

  buildInputs = with pkgs; [
    nodejs-18_x
    unstable.terraform
    # Add your global packages here
  ];
}
