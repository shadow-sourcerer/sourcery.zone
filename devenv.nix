{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  nodejs-packages = with pkgs.nodePackages; [
    vscode-langservers-extracted
    serverless
    postcss-cli
  ];
in {
  name = "Shotgun";
  # https://devenv.sh/basics/
  env.GREET = "Welcome to Shotgun! 🤠";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    hugo
  ] ++ nodejs-packages;

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.javascript = {
    enable = true;
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";
  processes.hugo-watch.exec = "hugo server -D";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    $GREET
  '';

  enterShell = ''
    hello
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;
  pre-commit.hooks = {
    nixfmt-rfc-style = {
      enable = true;
      excludes = [ ".devenv.flake.nix" ];
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
