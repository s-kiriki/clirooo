
Clirooo.Invite = Clirooo.Invite || {}

do ->
	
	Clirooo.Invite.getResponse = (args, callback) ->
		
		result = '';
		email = args[0]
		
		setTimeout(() ->
			callback "We have sent invitaion email to <span class='tm-text-ginza'>kirikisinya@gmail.com</span>. Thank you for sharing!"
		, 1000)
		
	
