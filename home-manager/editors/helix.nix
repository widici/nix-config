# TODO: add shell

{ ... }:

let
  # TODO: potentially rework this to use caps
  normalModeKey = {
    f.j = "normal_mode";
  };
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        bufferline = "multiple";
        true-color = true;
        auto-format = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        soft-wrap.enable = true;
      };

      keys = {
        select = normalModeKey;
        insert = normalModeKey;
      };
    };
  };
}
