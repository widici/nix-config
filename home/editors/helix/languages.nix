_:

{
  programs.helix.languages.language = [
    {
      name = "nix";
      language-servers = [ "nixd" ];
      formatter = {
        command = "treefmt";
        args = [
          "-q"
          "--stdin"
          "file.nix"
        ];
      };
    }
  ];
}
