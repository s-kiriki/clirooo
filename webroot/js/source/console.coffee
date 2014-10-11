
$ ->
	history = new Josh.History({
		key : 'josh.helloworld'
	})
	
	readline = new Josh.ReadLine({})
	
	readline.onCancel(
		() ->
			readline.setLine({text: "", cursor: 0})
	)
	
	shell = Josh.Shell({
		history : history,
		readline : readline
	})
	
	# comment command
	shell.setCommandHandler("#", {
		exec : (cmd, args, callback) ->
			callback ""
	})
	
	if localStorage and localStorage.getItem('clirooo.bgc')
		$('#shell-panel').css("background-color", localStorage.getItem('clirooo.bgc'))
	
	Clirooo.initialize(shell)
	shell.activate()
