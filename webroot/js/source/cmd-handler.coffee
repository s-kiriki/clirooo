Clirooo.CmdHandler = Clirooo.CmdHandler || {}

do ->

	__subCommands = [
	         		'line'
	         		'station'
	         		'status'
	         		'route'
	         		'delay'
	         		'help'
	         		'here'
	         		'config'
	         		'timetable'
	         		'docs'
	         	]
	
	Clirooo.CmdHandler.enableCliroooCommandMode = (shell) ->
	
		shell.onNewPrompt(
			(callback) ->
				if localStorage and localStorage.getItem('clirooo.name')
					userName = localStorage.getItem('clirooo.name')
					$('#js-user-name').html(userName)	
					callback "#{userName}$"
				else
					callback "$"
		)
	
		shell.setCommandHandler("clirooo", {
			exec : (cmd, args, callback) ->
				subCommand = args[0] || ''
				
				switch subCommand
					when 'line' then (
						param = args.slice(1)
						Clirooo.Line.getResponse( param, (res) -> callback res )
					)
					when 'station' then (
						station = args.slice(1)
						Clirooo.Station.getResponse( station, (res) -> callback res )
					)
					when 'status' then Clirooo.Status.getResponse( (res) -> callback res )
					when 'delay' then Clirooo.Delay.getResponse( (res) -> callback res )
					when 'timetable' then ( 
						param = args.slice(1)
						Clirooo.Timetable.getResponse( shell, param, (res) -> callback res )
					)
					when 'route' then ( 
						param = args.slice(1)
						Clirooo.Route.getResponse( param, (res) -> callback res )
					)				
					when 'here' then Clirooo.Here.getResponse( (res) -> callback res )
					when 'config' then ( 
						param = args.slice(1)
						Clirooo.Config.getResponse( shell, param, (res) -> callback res )
					)
					when 'docs' then callback Clirooo.Docs.getResponse()
					else callback Clirooo.Help.getResponse()
				
			
			completion : (cmd, arg, line, callback) ->
					
				if line.text.match(/clirooo line/i)
					callback shell.bestMatch(arg, Clirooo.Line.getList())
				else if line.text.match(/clirooo station/i)
					callback shell.bestMatch(arg, Clirooo.Station.getList())
				else if line.text.match(/clirooo route/i)
					callback shell.bestMatch(arg, Clirooo.Station.getList())
				else if line.text.match(/clirooo timetable/i)
					callback shell.bestMatch(arg, Clirooo.Station.getList())					
				else if line.text.match(/clirooo config/i)
					callback shell.bestMatch(arg, Clirooo.Config.getCommandList())
				else
					callback shell.bestMatch(arg, __subCommands)
		
		})
	
	Clirooo.CmdHandler.enableInputWaitingMode = (shell) ->
		
		shell.removeCommandHandler 'clirooo'
		shell.onNewPrompt(
			(callback) ->
				callback "Select number:"
		)
		
	
	

