Clirooo.Config = Clirooo.Config || {}

do ->

	Clirooo.Config.getCommandList = () ->
		return [
		        'list'
		        'set'
		        'delete'
		        'clear'
		        ]

	Clirooo.Config.getResponse = (shell, args, callback) ->
	
		command = args[0]
		
		if !command
			return callback "clirooo config [ list | set KEY=VALUE | delete KEY | clear ]"
		
		switch command
			when 'list' then (
				
				if !localStorage
					return callback "there are no configuration"
					
				result = ''
					
				if localStorage.getItem('clirooo.name')
					result += "name: #{localStorage.getItem('clirooo.name')}<br />"
				if localStorage.getItem('clirooo.bgc')
					result += "bgc: #{localStorage.getItem('clirooo.bgc')}<br />"
				
				return callback result
			)		
			when 'set' then (
					
				setting = args[1]
					
				if !setting
					return callback "no argument for configure setting"
				
				if match = /^name=(.+)$/.exec(setting)
					userName = match[1]
					$('#js-user-name').html(userName)	
					shell.onNewPrompt(
						(callback) ->
							callback "#{userName}$"
					)
					if localStorage
						localStorage.setItem('clirooo.name', userName)
			
					return callback "Hi, #{userName}! Having fun?"
			
				else if match = /^bgc=(.+)$/.exec(setting)
					bgc = match[1]
					$('#shell-panel').css('background-color', bgc)	
					
					if localStorage
						localStorage.setItem('clirooo.bgc', bgc)
			
					return callback "Changed background color to #{bgc}! Do you like it?"
					
				else					
					return callback "unrecognized argument: #{setting}"
				
			)
			when 'delete' then (
					
					key = args[1]
						
					if !key
						return callback "clirooo config delete KEY"
					
					switch key
						when 'name' then (
							$('#js-user-name').html('guest')
							shell.onNewPrompt(
								(callback) ->
									callback "$"
							)
							if localStorage
								localStorage.removeItem("clirooo.name")
						)
						when 'bgc' then (
							$('#shell-panel').css('background-color', '#000000')
							if localStorage
								localStorage.removeItem("clirooo.bgc")
						)
						else return callback "unknown key name: #{key}"
						
					return callback "Deleted your :#{key} configuration"
			)
			when 'clear' then (
					
				$('#js-user-name').html('guest')
				shell.onNewPrompt(
					(callback) ->
						callback "$"
				)
				
				$('#shell-panel').css('background-color', '#000000')
				
				if localStorage
					localStorage.removeItem("clirooo.name")
					localStorage.removeItem("clirooo.bgc")
						
				return callback "Cleared your configuration"
			)
			else return callback "unrecognized configure command \'#{command}\'"
		

