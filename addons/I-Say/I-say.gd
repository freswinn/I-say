extends Node
## The intended use of this script is as a singleton whose name is set to [code]I[/code].
## This makes it possible to call the [method say] and [method sayerr] methods via
## [code]I.say()[/code] or [code]I.sayerr()[/code].


## Controls whether or not [method say] and [method sayerr] actually print anything.
var say_verbose : bool = true
## Controls the amount of I.say() calls will print.
var say_verbosity_level : SAY_VERBOSITY_LEVEL = SAY_VERBOSITY_LEVEL.all

## Color of the header for [method say].
const say_color : String = "cyan"
## The break between the header and the information in [method say] and [method sayerr].
const say_break : String = "  ||  "



## This dictates what kinds of [method say] statements get printed in the debugger.[br]
## This does not affect [method sayerr] statements.
enum SAY_VERBOSITY_LEVEL {
	## All say() statements.
	all=0,
	## Only notable and serious say() statements.
	notable,
	## Only the most serious say() statements.
	serious }


## Used to print information to the console; uses [method @GlobalScope.print_rich]. See
## [member say_verbose] and [member say_verbosity_level] to set how much this method
## and [method sayerr] will chatter.
func say(info : String, verbose_level : int = 0):
	if !say_verbose or say_verbosity_level > verbose_level: return
	var script_filename = get_stack()[1]["source"].split("/")[-1]
	var method_name = get_stack()[1]["function"]
	var line_number = get_stack()[1]["line"]
	print_rich("[color=%s][b]%s[/b], %s @ %s %s[/color] %s" % [
		say_color, script_filename, method_name, line_number, say_break, info])


## Used to print information to the console; uses [method @GlobalScope.printerr]. See
## [member say_verbose] to set whether this method will chatter.
func sayerr(info : String):
	if !say_verbose: return
	var script_filename = get_stack()[1]["source"].split("/")[-1]
	var method_name = get_stack()[1]["function"]
	var line_number = get_stack()[1]["line"]
	printerr("%s, %s @ %s %s %s" % [
		script_filename, method_name, line_number, say_break, info])
