Clirooo.Timetable = Clirooo.Timetable || {}

do ->

	Clirooo.Timetable.getResponse = (shell, args, callback) ->
		
		if !localStorage
			return callback "Sorry you cannot execute this command because your browser is unsuportted Web Storage";
	
		station = args[0]
		cmdParams = args.slice(1)
		
		if !station
			return callback "clirooo timetable STATION <DIRECTION>"
			
		apiParams = {station: station}
			
		$.getJSON(Clirooo.getApiBaseUrl() + "timetable_board.json", apiParams, (json) ->
			timetableBoards = json.result;
			
			if timetableBoards.length == 0
				return callback "Sorry, we have no timetable of #{station} station"
				
			
			response = "<br />"
			response += "Select a timetable:<br />"
			response += "<br />"
			
			for timetableBoard, key in timetableBoards
				timetableBoard.inputNumber = key+1
				response += "#{timetableBoard.inputNumber}) <span class='tm-text-#{timetableBoard.line}'>#{Clirooo.Util.toUpperCaseOnlyFirstLetter(timetableBoard.line)}(for #{Clirooo.Util.toUpperCaseOnlyFirstLetter(timetableBoard.direction)})</span><br />"
			
			Clirooo.CmdHandler.enableInputWaitingMode(shell)
			# start input mode and attach input option
			_setTimetableOutputCmd = (ttb) ->
				shell.setCommandHandler(ttb.inputNumber, {
					exec : (cmd, args, callback) ->
						# quit input mode
						Clirooo.CmdHandler.enableCliroooCommandMode(shell)
						# reomove attached input options
						for inputOption in inputOptions
							shell.removeCommandHandler inputOption
						
						$.getJSON(Clirooo.getApiBaseUrl() + "timetable.json", {timetableBoardId: ttb.id}, (json) ->
							timetableSet = json.result.timetables;
							
							ttResponse = ""
							stopTypeArr = []
								
							for boardType, timetables of timetableSet
								hour = null
								
								ttResponse += "<br />"
								if boardType == 'weekday'
									ttResponse += "[ Weekdays ]"
								else if boardType == 'holiday'
									ttResponse += "[ Holidays ]"
								
								for key, timetable of timetables
									if hour != timetable.hour
										hour = timetable.hour
										ttResponse += "<br />"
										ttResponse += "#{timetable.hour}:&nbsp;"
									
									ttResponse += "<span class='tm-timetable-stop-type-#{timetable.stopType}'>#{timetable.min}</span>&nbsp;"
										
									if timetable.stopType not in stopTypeArr
										stopTypeArr.push timetable.stopType
										
								ttResponse += "<br />"

							ttResponse += "<br />Annotation:<br />"
							ttResponse += "Stop Type) "
							for stopType in stopTypeArr
								ttResponse += "<span class='tm-timetable-stop-type-#{stopType}'>#{stopType}</span>&nbsp;"
							
							ttResponse += "<br />"
							return callback ttResponse
						)
						.error( (jqXHR, textStatus, errorThrown) ->
							return callback JSON.parse(jqXHR.responseText)
						)
						return
				})
				
			inputOptions = []
			for key, timetableBoard of timetableBoards
				inputOptions.push timetableBoard.inputNumber
			
			for key, timetableBoard of timetableBoards
				_setTimetableOutputCmd(timetableBoard)			
			
			return callback response
		)
		.error( (jqXHR, textStatus, errorThrown) ->
			return callback JSON.parse(jqXHR.responseText)
		)		
		
		return
