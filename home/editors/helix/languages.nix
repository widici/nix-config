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
  ];
}
