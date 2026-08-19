@tool
extends EditorPlugin

const path = "I-say.gd"

func _enter_tree() -> void:
	add_autoload_singleton("I", path)
func _exit_tree() -> void:
	remove_autoload_singleton("I")