Clirooo.Delay = Clirooo.Delay || {}

do ->

	Clirooo.Delay.getResponse = (callback) ->
		$.getJSON(Clirooo.getApiBaseUrl() + "service_status.json", (json) ->
			_delayLines = [];
			for lineName, data of json.result
				
				if data.status != 1
					_delayLines.push lineName
			
			if _delayLines.length > 1
				response = ''
				for _delayLine, key in _delayLines
					response += "<span class=\"tm-text-#{_delayLine}\">#{Clirooo.Util.toUpperCaseOnlyFirstLetter(_delayLine)}</span> -- <span class='tm-text-line-status-delay'>Delays</span><br />"
				
				response += "<span class='tm-text-line-status-good'>Other lines are on Good Service.</span>"
				callback response
			else
				callback "<span class='tm-text-line-status-good'>All lines are on Good Service.</span>"
		)
