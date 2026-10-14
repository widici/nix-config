_:

{
  programs.helix.languages.language = [
    {
      name = "nix";
      language-servers = [ "nixd" ];
      formatter = {
        command = "nix";
        args = [
          "fmt"
          "--"
          "-q"
          "--stdin"
          "file.nix"
        ];
      };
    }

    {
      name = "ruby";
      formatter = {
        command = "rubocop";
        args = [
          "--stdin"
          "foo.rb"
          "-a"
          "--stderr"
          "--fail-level"
          "fatal"
          "--server"
        ];
      };
    }
  ];
}
