Clirooo.Route = Clirooo.Route || {}

do ->

	Clirooo.Route.getResponse = (args, callback) ->
		
		fromStation = args[0]
		toStation = args[1]
		cmdParams = args.slice(2)
		
		if !fromStation or !toStation
			callback "clirooo route STATION(from) STATION(to) [options]"
			return
		
		apiParams = {
			"from": fromStation,
			"to": toStation
		}
		
		if cmdParams.length > 0
			for cmdParam, key in cmdParams
				if match = /^--type=(.+)$/.exec(cmdParam)
					apiParams.search = match[1]
				else if match = /^--time=(.+)$/.exec(cmdParam)
					apiParams.time = match[1]
				else if match = /^--date=(.+)$/.exec(cmdParam)
					apiParams.date = match[1]
				else if match = /^--via=(.+)$/.exec(cmdParam)
					apiParams.via = match[1]
				else					
					callback "unrecognized argument: #{cmdParam}"
					return
					
		
		$.getJSON(Clirooo.getApiBaseUrl() + "route.json", apiParams, (json) ->
			route_url = json.result.route_url;
			if '--open-link' in cmdParams
				win = window.open(route_url, '_blank')
	
			response = "<a href=\"#{route_url}\" target=\"_blank\" class=\"tm-text-route-link\">#{route_url}</a>"
			response += "&nbsp;(<- you can click and jump from here)"
				
			callback response
		)
		.error( (jqXHR, textStatus, errorThrown) ->
			callback JSON.parse(jqXHR.responseText)
		)
	
