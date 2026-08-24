extends Node
## The intended use of this script is as a singleton whose name is set to [code]I[/code].
## This makes it possible to call the [method say] and [method sayerr] methods via
## [code]I.say()[/code] or [code]I.sayerr()[/code].


## Just the categorization of the settings.
const _prefix : String = "plugins/i_say/"


## Controls whether or not [method say] and [method sayerr] actually print anything.
var _say_active : bool = true

## Controls the amount of I.say() calls will print.
var _say_verbosity_level : LVL = LVL.all

## Color of the header for [method say]. Because [method say] is just using
## [method @GlobalScope.print_rich], you cannot just use hexadecimal codes or other such
## numerical representations; only color names compatible with print_rich.
var _say_color : String = "cyan"

## The break between the header and the information in [method say] and [method sayerr].
var _say_break : String = "  ||  "


## This dictates what kinds of [method say] statements get printed in the debugger.[br]
## This does not affect [method sayerr] statements.
enum LVL {
	## All say() statements.
	all=0,
	## Only notable and serious say() statements.
	notable,
	## Only the most serious say() statements.
	serious }



## Used to print information to the console; uses [method @GlobalScope.print_rich]. See
## [member _say_active] and [member _say_verbosity_level] to set how much this method
## and [method sayerr] will chatter.
func say(info : String, verbose_level : int = 0):
	_update_vars()
	if !_say_active or _say_verbosity_level > verbose_level: return
	var script_filename = get_stack()[1]["source"].split("/")[-1]
	var method_name = get_stack()[1]["function"]
	var line_number = get_stack()[1]["line"]
	print_rich("[color=%s][b]%s[/b], %s @ %s %s[/color] %s" % [
		_say_color, script_filename, method_name, line_number, _say_break, info])



## Used to print information to the console; uses [method @GlobalScope.printerr]. See
## [member _say_active] to set whether this method will chatter.
func sayerr(info : String):
	_update_vars()
	if !_say_active: return
	var script_filename = get_stack()[1]["source"].split("/")[-1]
	var method_name = get_stack()[1]["function"]
	var line_number = get_stack()[1]["line"]
	printerr("%s, %s @ %s %s %s" % [
		script_filename, method_name, line_number, _say_break, info])



func _update_vars() -> void:
	_say_verbosity_level = ProjectSettings.get_setting(_prefix + "verbosity_level")
	_say_color = ProjectSettings.get_setting(_prefix + "color")
	_say_break = ProjectSettings.get_setting(_prefix + "break")
	_say_active = ProjectSettings.get_setting(_prefix + "active")
