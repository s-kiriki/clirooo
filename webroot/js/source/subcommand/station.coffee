Clirooo.Station = Clirooo.Station || {}

do ->
	__stations = [
		"aoyama-itchome"
		"akasaka"
		"akasaka-mitsuke"
		"akabane-iwabuchi"
		"akihabara"
		"asakusa"
		"azabu-juban"
		"ayase"
		"awajicho"
		"iidabashi"
		"ikebukuro"
		"ichigaya"
		"inaricho"
		"iriya"
		"ueno"
		"ueno-hirokoji"
		"urayasu"
		"edogawabashi"
		"ebisu"
		"oji"
		"oji-kamiya"
		"otemachi"
		"ogikubo"
		"oshiage"
		"ochiai"
		"ochanomizu"
		"omote-sando"
		"gaiemmae"
		"kagurazaka"
		"kasai"
		"kasumigaseki"
		"kanamecho"
		"kamiyacho"
		"kayabacho"
		"kanda"
		"kita-ayase"
		"kita-sando"
		"kita-senju"
		"kiba"
		"gyotoku"
		"kyobashi"
		"kiyosumi-shirakawa"
		"ginza"
		"ginza-itchome"
		"kinshicho"
		"kudanshita"
		"kojimachi"
		"korakuen"
		"gokokuji"
		"kotake-mukaihara"
		"kokkai-gijidomae"
		"kodemmacho"
		"komagome"
		"sakuradamon"
		"shibuya"
		"shimo"
		"shirokanedai"
		"shirokane-takanawa"
		"shin-otsuka"
		"shin-ochanomizu"
		"shin-kiba"
		"shin-koenji"
		"shinjuku"
		"shinjuku-gyoemmae"
		"shinjuku-sanchome"
		"shintomicho"
		"shin-nakano"
		"shimbashi"
		"jimbocho"
		"suitengumae"
		"suehirocho"
		"sumiyoshi"
		"senkawa"
		"sendagi"
		"zoshigaya"
		"takadanobaba"
		"takebashi"
		"tatsumi"
		"tameike-sanno"
		"tawaramachi"
		"chikatetsu-akatsuka"
		"chikatetsu-narimasu"
		"tsukiji"
		"tsukishima"
		"tokyo"
		"todaimae"
		"toyocho"
		"toyosu"
		"toranomon"
		"naka-okachimachi"
		"nagatacho"
		"nakano"
		"nakano-sakaue"
		"nakano-shimbashi"
		"nakano-fujimicho"
		"naka-meguro"
		"nishi-kasai"
		"nishigahara"
		"nishi-shinjuku"
		"nishi-nippori"
		"nishi-funabashi"
		"nishi-waseda"
		"nijubashimae"
		"nihombashi"
		"ningyocho"
		"nezu"
		"nogizaka"
		"hatchobori"
		"baraki-nakayama"
		"hanzomon"
		"higashi-ikebukuro"
		"higashi-ginza"
		"higashi-koenji"
		"higashi-shinjuku"
		"hikawadai"
		"hibiya"
		"hiro-o"
		"heiwadai"
		"honancho"
		"hongo-sanchome"
		"hon-komagome"
		"machiya"
		"mitsukoshimae"
		"minami-asagaya"
		"minami-gyotoku"
		"minami-sunamachi"
		"minami-senju"
		"minowa"
		"myogadani"
		"myoden"
		"meiji-jingumae"
		"meguro"
		"monzen-nakacho"
		"yurakucho"
		"yushima"
		"yotsuya"
		"yotsuya-sanchome"
		"yoyogi-uehara"
		"yoyogi-koen"
		"roppongi"
		"roppongi-itchome"
		"wakoshi"
		"waseda"
	]
		
		
	Clirooo.Station.getList = ->
		__stations;
	
	Clirooo.Station.getResponse = ( args, callback ) ->

		station = args[0]
		cmdParams = args.slice(1)

		if !station
			callback "clirooo station STATION [options]"
			return

		apiParams = {
			"station": station,
		}

		$.getJSON(Clirooo.getApiBaseUrl() + "station.json", apiParams , (json) ->
			response = ''
			for lineName, data of json.result
				response += "<span class=\"tm-text-#{data.line}\">#{Clirooo.Util.toUpperCaseOnlyFirstLetter(data.line)}&nbsp</span>#{data.stationCode}<br />"

			callback response
		)
		.error( (jqXHR, textStatus, errorThrown) ->
			callback JSON.parse(jqXHR.responseText)
		)