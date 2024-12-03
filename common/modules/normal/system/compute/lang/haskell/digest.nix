{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  currPath = lib.strings.splitString "/" (toString ./.);
  findIndex = (lib.lists.findFirstIndex (x: x == "modules") null (currPath));
  cfgList = (lib.lists.drop (findIndex) currPath) ++ [ "${cfgName}" ];
  cfgGen = attrsets.setAttrByPath cfgList
    {
      enable = mkEnableOption "Enable ${cfgName}";
    };
in
{
  options = cfgGen;
  config = {
    environment.systemPackages = mkIf ( attrsets.getAttrFromPath (cfgList ++ ["enable"]) config ) [ pkgs.haskellPackages.digest ];
  };
}
