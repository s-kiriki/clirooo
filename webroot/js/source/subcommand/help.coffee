Clirooo.Help = Clirooo.Help || {}

do ->

	Clirooo.Help.getResponse = ->
		"""
		Usage: clirooo SUBCOMMAND (options)<br />
		&nbsp;<code>clirooo station STATION</code><br />
		&nbsp;<code>clirooo line [LINE]</code><br />
		&nbsp;<code>clirooo status [LINE]</code><br />
		&nbsp;<code>clirooo delay</code><br />
		&nbsp;<code>clirooo route STATION(from) STATION(to) [options]</code><br />
		&nbsp;<code>clirooo ascii [ASCII_NAME]</code><br />
		<br />
		<span>For further help:</span><br />
		&nbsp;<code>clirooo [SUBCOMMAND] --help</code>	
		"""

