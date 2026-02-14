# TODO: use a secret for auth keys

{ config, pkgs, ... }:

{
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };

    extensions = with pkgs; [
      gh-markdown-preview
    ];
  };
}
