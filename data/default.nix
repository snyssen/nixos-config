{myLib, ...}:
let
  dataModules = myLib.filesIn ./modules;
in
{
  imports = [] ++ dataModules;
}