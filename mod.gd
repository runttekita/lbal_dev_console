extends Node2D

const RESOURCE_PATH = "res://yetanotherhalation/"
var modloader: Reference
var msg = ""
var console_opened = false
var label
var in_scene = false

func create_item(path):
    var script := load(path)
    var mod_item := script.new()
    mod_item.init(self)

func load(modloader: Reference, mod_info, tree: SceneTree):
    self.modloader = modloader
    tree.get_root().add_child(self)
    label = Label.new()

func _input(event):
    if not in_scene and event is InputEventKey and event.is_pressed() and not event.is_echo():
        $"/root/Main/Reels".add_child(label)
        in_scene = true
    item_console(event)

func item_console(event):
    if event is InputEventKey and event.is_pressed() and not event.is_echo():
        var typed_event = event as InputEventKey
        var key_typed = PoolByteArray([typed_event.unicode]).get_string_from_utf8()
        if event.scancode == KEY_QUOTELEFT:
            console_opened = !console_opened
            msg = ""
            return
        if console_opened:
            if event.scancode == KEY_ENTER:
                msg = msg.to_lower()
                var tokens = msg.split(" ")
                if tokens[0] == "item":
                    modloader.add_item(tokens[1])
                if tokens[0] == "symbol":
                    modloader.add_symbol(tokens[1])
                msg = ""
                console_opened = false
            if event.scancode == KEY_BACKSPACE:
                msg.erase(msg.length() - 1, 1)
            else:
                msg += key_typed
    label.text = msg