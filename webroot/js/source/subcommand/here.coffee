Clirooo.Here = Clirooo.Here || {}

do ->

	Clirooo.Here.getResponse = (callback) ->
		if navigator.geolocation
			navigator.geolocation.getCurrentPosition(
				(position) ->
					apiParams = {
						"lat": position.coords.latitude,
						"lon": position.coords.longitude
					}
						
					$.getJSON(Clirooo.getApiBaseUrl() + "here.json", apiParams, (json) ->
						response = ''
						for key, nearStation of json.result.nearStations
							console.log nearStation
							response += "<span>#{Clirooo.Util.toUpperCaseOnlyFirstLetter(nearStation.name)}</span> -- #{nearStation.distance}m<br />"
						callback(response)
					)
					.error( (jqXHR, textStatus, errorThrown) ->
						callback JSON.parse(jqXHR.responseText)
					)
					
					
				() -> 
					callback "Sorry, Failed to specify you location";
			)
		else
			callback "Sorry, your browser is unsuportted Geolocation API";
