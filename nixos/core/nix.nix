_:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "15min";
    };

    optimise = {
      automatic = true;
      randomizedDelaySec = "15min";
    };
  };
}
