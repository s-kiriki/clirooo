Clirooo.Status = Clirooo.Status || {}

do ->

	__getServiceStatusText = (status) ->
		if status == 1
			res = '<span class="tm-text-line-status-good">Good Service</span>'
		else
			res = '<span class="tm-text-line-status-delay">Delays</span>'
	
	Clirooo.Status.getResponse = (callback) ->
		$.getJSON(Clirooo.getApiBaseUrl() + "service_status.json", (json) ->
			response = ''
			for lineName, data of json.result
				response += "<span class=\"tm-text-#{lineName}\">#{Clirooo.Util.toUpperCaseOnlyFirstLetter(lineName)}</span> -- #{ __getServiceStatusText(data.status)}<br />"
			callback(response)
		)
