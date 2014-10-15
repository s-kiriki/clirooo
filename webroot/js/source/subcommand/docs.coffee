Clirooo.Docs = Clirooo.Docs || {}

do ->

	Clirooo.Docs.getResponse = ->
		docsUrl = "http://clirooo.readme.io/"
			
		return "<a href=\"#{docsUrl}\" target=\"_blank\" class=\"tm-text-route-link\">#{docsUrl}</a>"

