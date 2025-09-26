let
  isDirectory = path: name: (builtins.readDir path).${name} == "directory";
  isRegularFile = path: name: (builtins.readDir path).${name} == "regular";
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  notInList = list: item: !(builtins.elem item list);
in {
  importFoldersExcept = path: excludedFolders:
    builtins.map (name: path + "/${name}")
    (builtins.filter (name:
      isDirectory path name && notInList excludedFolders name)
    (builtins.attrNames (builtins.readDir path)));

  importNixFiles = path: excludedFiles:
    builtins.map (name: path + "/${name}")
    (builtins.filter (name:
      isRegularFile path name
      && isNixFile name
      && notInList excludedFiles name)
    (builtins.attrNames (builtins.readDir path)));

  importNixList = path:
    builtins.foldl' (
      acc: file:
        acc ++ (import file)
    ) [] (
      builtins.map (name: path + "/${name}") (
        builtins.filter (
          name: let
            entry = (builtins.readDir path).${name};
          in
            entry == "regular" && builtins.match ".*\\.nix$" name != null
        ) (builtins.attrNames (builtins.readDir path))
      )
    );
}
