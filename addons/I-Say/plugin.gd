@tool
extends EditorPlugin

const path : String = "I-say.gd"
const prefix : String = "plugins/i_say/"
const default_settings : Dictionary = {
	"active" : true,
	"verbosity_level" : 0,
	"color" : "cyan",
	"break" : "  ||  " }


func _enter_tree() -> void:
	_check_settings()
	add_autoload_singleton("I", path)

func _exit_tree() -> void:
	remove_autoload_singleton("I")


func _check_settings() -> void:
	for i in default_settings.keys():
		if !ProjectSettings.has_setting(prefix + i):
			ProjectSettings.set_setting(prefix + i, default_settings[i])
		ProjectSettings.set_as_basic(prefix + i, true)
	ProjectSettings.add_property_info(
		{"name" : prefix + "verbosity_level",
		"type" : 2,
		"hint" : "All,Notable,Serious"})
	ProjectSettings.save()
