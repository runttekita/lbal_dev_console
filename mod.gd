extends Node2D

var modloader: Reference
var msg = ""
var console_opened = false
var label
var in_scene = false
var tree

func load(modloader: Reference, mod_info, tree: SceneTree):
    self.modloader = modloader
    self.tree = tree
    tree.get_root().add_child(self)
    label = Label.new()
    pause_mode = Node.PAUSE_MODE_PROCESS

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
            tree.paused = !tree.paused 
            msg = ""
            return
        if console_opened:
            if event.scancode == KEY_ENTER:
                msg = msg.to_lower()
                var times = 1
                var tokens = msg.split(" ")
                if tokens.size() == 3:
                    times = max(1, int(tokens[2]))
                print(times)
                if tokens[0] == "item":
                    for i in times:
                        modloader.add_item(tokens[1])
                if tokens[0] == "symbol":
                    for i in times:
                        modloader.add_symbol(tokens[1])
                msg = ""
                console_opened = false
                tree.paused = !tree.paused 
            if event.scancode == KEY_BACKSPACE:
                msg.erase(msg.length() - 1, 1)
            else:
                msg += key_typed
    label.text = msg