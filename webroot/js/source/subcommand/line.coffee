
Clirooo.Line = Clirooo.Line || {}

do ->

	__lines = [
	          	'ginza'
	          	'marunouchi'
	          	'hibiya'
	          	'tozai'
	          	'chiyoda'
	          	'yurakucho'
	          	'hanzomon'
	          	'namboku'
	          	'fukutoshin'
	          ]
	
	Clirooo.Line.getList = ->
		result = []
		for lineName, key in __lines
			result.push lineName
		result
	
	Clirooo.Line.getResponse = (args, callback) ->
		result = '';
		line = args[0]
		cmdParams = args.slice(1)
		
		if line
			
			apiParams = {
					"line": line,
				}			
			$.getJSON(Clirooo.getApiBaseUrl() + "line.json", apiParams, (json) ->
				result = ''
				
				if '--reverse' in cmdParams
					json.result.stations.reverse()
					
				for station, key in json.result.stations
					result += "<span class=\"tm-text-#{line}\">#{station.lineStationSymbol}:#{station.name}</span>"
						
					if station.transferLines? && station.transferLines.length > 0
						result += "  ~ transfer "
						for transferLine, key_trans in station.transferLines
							result += "<span class=\"tm-text-#{transferLine.name}\">#{Clirooo.Util.toUpperCaseOnlyFirstLetter(transferLine.name)}</span>"
							if key_trans + 1 < station.transferLines.length
								result += "|"
					
					result += "<br />"
						
					if key + 1 < json.result.stations.length
						result += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br />"

				callback result
			)
			.error( (jqXHR, textStatus, errorThrown) ->
				callback JSON.parse(jqXHR.responseText)
			)
		
		
		
		else 
			for lineName, key in __lines
				result += "<span class=\"tm-text-#{lineName}\">#{Clirooo.Util.toUpperCaseOnlyFirstLetter(lineName)}</span><br />";
			callback result
		
	
