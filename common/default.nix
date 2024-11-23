{ nixpkgs, self, ... }@inputs:
let
  inherit
    (nixpkgs)
    self
    lib
    ;
    currentDir = builtins.toString ./.;
    rootPath = toString inputs.self;
    importList = ((imoprt (rootPath + "/common/functions/importDir.nix")) { inherit nixpkgs; dirToScan = currentDir;  }).importList;
{
  imports = importList;
}
