extends Reference

var modloader: Reference

func load(modloader: Reference, mod_info, tree: SceneTree):
    self.modloader = modloader
    print(mod_info.name + " is loading!")