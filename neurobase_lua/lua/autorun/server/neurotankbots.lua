CreateConVar("bot_drivetanks", 1, FCVAR_NOTIFY )
CreateConVar("bot_killshit", 1, FCVAR_NOTIFY )
CreateConVar("bot_randomdrive", 1, FCVAR_NOTIFY )
CreateConVar("bot_talk", 1, FCVAR_NOTIFY )
CreateConVar("bot_autospawn", 1, FCVAR_NOTIFY )
AddCSLuaFile("autorun/client/neurotankbots.lua")

resource.AddFile("sounds/bots/")

local Meta = FindMetaTable( "Player" )
local ipairs = ipairs
local pairs = pairs
local type = type
BOT_STATE_FOLLOW = 1
BOT_STATE_aTTACK = 2
BOT_STATE_WANDER = 3
local Pandora = "http://www.pandorabots.com/pandora/talk-xml?botid=f9cb0841be342ba7&input="--"http://sheepridge.pandorabots.com/pandora/talk?botid=b69b8d517e345aba&skin=custom_input"
local guns = { 
	"weapon_neurowep_Famas",
	"weapon_neurowep_ak47",
	"weapon_neurowep_galil",
	"weapon_neurowep_m4a1",
	"weapon_neurowep_m249",
	"weapon_neurowep_deagle",
	"weapon_neurowep_Fiveseven",
	"weapon_neurowep_glock18",
	"weapon_neurowep_mp5",
	"weapon_neurowep_mac10",
	"weapon_neurowep_longslide",
	"weapon_neurowep_winchester_1887",
	"weapon_neurowep_pkm",
	"weapon_neurowep_acr10",
	"weapon_neurowep_aug",
	"weapon_neurowep_m3",
	"weapon_neurowep_car101",
	"weapon_neurowep_g3sg1",
	"weapon_neurowep_ump45",
	"weapon_neurowep_usp",
	"weapon_neurowep_m24",
	"weapon_neurowep_p90",
	"weapon_neurowep_sg550",
	"weapon_neurowep_sg552",
	"weapon_neurowep_rorsch",
	"weapon_neurowep_p228",
	"weapon_neurowep_scout",
	"weapon_neurowep_tmp",
	"weapon_neurowep_xm1014",
	"weapon_neurowep_alienrifle",
	"weapon_neurowep_alienpistol",
	"weapon_neurowep_bow",
	"weapon_neurowep_combatshotty",
	"weapon_neurowep_flashbang",
	"weapon_neurowep_rpc",
	"weapon_neurowep_smokegrenade"
	}


local objects = {
"M-109 Paladin",
"abrams",
"hammer",
"crowbar",
"physgun",
"petrol propelled dildo",
"jackhammer",
"meatsword",
"dong",
"boomerang",
"taepodong",
"Nuclear dragon dildo",
"atomic sperm",
"Rocket Propelled gaylord"
}
local plurals = {
""
}
local swears = {
"anus",
"butt",
"pussy",
"whore",
"whopper",
"cracker",
"motherfucker",
"fatherfucker",
"sisterfucker",
"step-brother-fucker",
"chocolate factory",
"bunghole",
"ass",
"batcave",
"wankstain",
"deviantart user",
"Bumhole",
"Cock",
"tit",
"cockhead",
"banter lad",
"Titballs",
"Smeg Head"


}
local actions = {
"murder",
"shrek",
"rekking",
"wrecking",
"bitchslap",
"rape",
"slap",
"bash",
"frape",
"ruin",
"rek",
"destory"

};
local chaps = {
"Hoffa",
"Garry",
"Garebare",
"Afto",
"The Spainard",
"Killstreaks",
"Hofhof",
"AH-56 Model",
"Bob grates",
"Starchick",
"Huffa",
"Gary",
"aftokinto",
"Le espainol",
"Kollsteaks",
"Peacewalker models",
"Storedicks",
"Funky failing to model",
"Another LUA error",
"Garry's mod update",
"El Hoffo",
"El Hofforini",
"Pink Guy",
"The entire North Korean Army",
"Kim Jon un",
"Kim Jon Hard un",
"My Thermonuclear Dick"

};

local lenny = function() function s(b)return string.char(b)end local lennys={40,32,205,161,194,176,32,205,156,202,150,32,205,161,194,176,41} local lenny for i=1,#lennys do lenny=lenny..s(lennys[i])end return lenny end



local targetphrases = {
"%s you are dead D:",
"fucks sake.. BLOCKED!!11",
"haha %s is a <CUSS>, I'm gonna <ACTION> you",
"dun dun dun.. %s",
"I know where you live %s",
"i know where your mailbox lives %s",
"Prepare to die %s",
"%s will soon experience <ACTION>",
"eat ass %s",
"eat a bag of shit %s",
"Im gonna <ACTION> %s",
"time is up %s",
"this will be funneh",
"game over %s",
"this might be interesting",
"mohaha",
"Ahahahahaha",
"eat a bag of dicks %s",
"LOL",
"HAHA",
"I see you %s",
"I'm here to collect your soul %s",
"Autobots roll out",
"Garry doesn't care about gmod anymore :(",
"prepare your anus %s",
"%s will get stretched",
"Im gonna take my <OBJECT> and <ACTION> %s",
"<ACTION>",
"Oi, %s, I'm going to <ACTION> you so hard, your going to look like a <CUSS>!",
"Oh you little piece of shit you.",
"%s is a <CUSS>",
"Heheh.. You're Fucked with a capital F.",
"eat shit %s",
"%s, What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills.",
"wot the fok did ye just say 2 me m8? i dropped out of newcastle primary skool im the sickest bloke ull ever meet & ive nicked 300 chocolate globbernaughts frum tha corner shop.",
"Locked on to some faggot called %s",
"Gunner, Open fire on %s!",
"<CUSS> , %s can eat a bag of dicks!",
" I think %s is a pretty cool guy. eh plays neurotec and doesnt afraid of my giant ass tank.",
" All your base are belong to us",
" I bet %s is going to get us sued by wargaming",
"I will shit fury all over you and you will drown in it. You're fucking dead, %s.",
"%s is a bigger hof hof then hoffa himself.",
"%s, stand still you little pussy!",
"Incoming anal Fissures for %s",
"eat dick %s",
"Incoming ass fisting for %s",
"2. TARGET. THAT. %s. 200M BEARING 243. NORTH WEST.",
"2. TARGET. THAT. %s. 50M BEARING 154. SOUTH.",
"this will be interesting..",
"%s, What the fuck did you just fucking say about me, you little player? I'll have you know I graduated top of my class in the Mudling skool, and I've been involved in numerous secret raids on  the Afto-Spaniard, and I have over 300 confirmed modeling errors.",
"%s, What the fuck did you just fucking say about me, you little Console player? I'll have you know I graduated top of my class in the PC master race, and I've been involved in numerous secret raids on Xboners, and I have over 300 confirmed mods. You are nothing to me but another Console fag.",
"Maybe if I rek %s, Garry-Senpai will notice me ~Uguu",
"This artillery is rising higher then my morning wood, just to fuck you over %s!",
"%s8+%CD%A1%C2%B0+%CD%9C%CA%96+%CD%A1%C2%B0%s9",
"Maybe If I rek %s, Hoffa-Senpai Will notice me ~Kawaii",
"Error 404.  %snot found. Because He's dead. Haha... That was shit.",
"Maybe if I kill %s, <CHAPS> Will notice me",
"eat pussy %s",
"Hey %s, Want to come to Allah's Snackbar?",
"Allahu Ackbar, <CUSS>!",
"%s Is going to get more rekt then Brazil in the 2014 World Cup!",
"%sI would fucking rape you.. If i knew how to aim. <CUSS>.",
" The A-10 fart makes me horny.",
" Guys, Aim at %s's weak point for maximum damage!",
" You see how good this mod is %s! We steal everything! Even our way of gameplay, sounds, models, And me!",
lenny,
"%s have you met Necrophiliac Priest? Because I heard he liek fat boys",
"can someone please nuke %s ?",
"NeuroTec is awesome",
"THAT IS HARAM! %s",
"Im bored. Lets kill %s",
"%s your defence is worse than Poland 1939",
"www.redtube.com/174545 shit wrong paste",
"!report %s hacker! ban plis",
"!votekick %s rude cunt",
"I. AM. THE. LAW!",
"CODE RED II; HACKED BY CHINESE!!!",
"I wonder if %s likes 102MM up his ass.",
" Hello %s, Is it me you're looking for? I can see it in your eyes, I can see it in your smillle.",
" Okaaaaaay, Time to drive this thing. So using compass, oh wait math is haram, oops.",
"I'm not actually",
"You what mate? You having a giggle? I'll smack you in the gabber %s, I swear on me mum.",
"Locked and loaded, Lets kill %s!",
"Allah ackbar, %s.",
"<CHAPS> vs %s, Who would win?",
"%s YOU FUCKING <CUSS> ILL GOD DAMN <ACTION> YOUR LITTLE ASS.",
"Hah, %s reminds me of <CHAPS> They have one thing in common, they both died by me!",
"<CHAPS> will ruin %s.",
"By the power of <CHAPS>, I hearby kill %s!"
}
TARGET_PHRASE_INDEX = 1
local function incrementTalk()
	
	if( TARGET_PHRASE_INDEX < #targetphrases ) then
	
		TARGET_PHRASE_INDEX = TARGET_PHRASE_INDEX + 1
	
	else
		
		TARGET_PHRASE_INDEX = 1
		
	end
		
end
local playermdls = {
"models/player/arctic.mdl",
"models/player/gasmask.mdl",
"models/player/combine_super_soldier.mdl",
"models/player/leet.mdl",
"models/player/skeleton.mdl" }



local function inLOS( a, b )

	if( !IsValid( a ) || !IsValid( b ) ) then
		
		return false
	
	end
	
	if( a:GetPos():Distance( b:GetPos() ) > 15500 ) then return false end
	
	local trace = util.TraceLine( { start = a:GetPos() + a:GetUp() * 72, endpos = b:GetPos() + Vector(0,0,32), filter = a, mask = MASK_BLOCKLOS + MASK_WATER } )
	if  ( ( trace.Hit && trace.Entity == b ) || !trace.Hit ) then
		
		a.LastLOS = CurTime()
		
	end
	
	return ( ( trace.Hit && trace.Entity == b ) || !trace.Hit )
	
end

hook.Add("DoPlayerDeath", "NeuroBotsAntiSpawnkill", function( ply, atk, dmg ) 
	
	local we = ply:GetActiveWeapon()
	if( (  ply.LastHostileAction && ply.LastHostileAction+15 <= CurTime() ) && ply:IsPlayer() && atk:IsPlayer() && IsValid( atk ) && ( !IsValid( we ) || ( ( IsValid( we ) && we:GetClass() == "weapon_physgun" ) ) ) && ply != atk ) then
		
		-- print("yo?=")
		atk.LastSpawnKill = CurTime()
		atk.LastHostileAction = CurTime() 
		-- local bots = player.GetBots()
		-- print( dmg:GetDamage() )
		
		-- if( #bots > 0 && dmg:GetDamage() > 50 && ( ply:GetPos() - atk:GetPos() ):Length() > 10000 ) then
			
			-- local bot =  bots[math.random(1,#bots)]
			
			-- bot:SetPos( atk:GetPos() + atk:GetForward() * -40 )
			-- bot.Target = atk
		
		-- end
			
		-- print( atk.LastHostileAction+15 >= CurTime() )
		if( IsValid( ply ) && IsValid( atk ) && atk:IsPlayer() && !atk:IsBot() && atk.LastHostileAction && atk.LastHostileAction+15 >= CurTime() ) then
			-- print("yo?=")
			

			for k,v in ipairs( ents.FindByClass("info_player_start") ) do
				-- If we're in visible range of a spawn point and our victim is unarmed, attack the attacker.
				if( ( v:GetPos() - ply:GetPos() ):Length() < 3500 && inLOS( v, ply )  && #player.GetBots() > 0 ) then
					
					player.GetBots()[1]:Say( string.format( "%s just spawnkilled %s", atk:Nick(), ply:Nick() ) ) 
					if( !atk.SpawnKills ) then
					
						atk.SpawnKills = 0
						
					end
					
					atk.SpawnKills = atk.SpawnKills + 1
					-- print( atk.SpawnKills )
					if( atk.SpawnKills >= 10 ) then
					
						local numAdmins = 0
						
						for k,v in pairs( player.GetAll() ) do
						
							if( v:IsAdmin() || v:IsSuperAdmin() ) then
							
								numAdmins = numAdmins + 1
								
							end
							
						end
						
						if( numAdmins == 0 ) then
							
							atk:Kick( "Repeatedly spawn killing unarmed players.")
							
						end
						
						player.GetBots()[1]:Say(string.format( "!votekick %s %s+spawnkills", atk:Nick(), atk.SpawnKills ) )
					
					end
					
					for _,bot in ipairs( player.GetBots() ) do 	
						
						bot.Target = atk
					
					end
					
					-- AWOL rule breach found, no need to keep looping.
					break
					
				end
				
			end
		
		end
		
	
	end

end ) 

	
function Meta:NB_FindSpots( tbl )

	local tbl = tbl or {}

	tbl.pos			= tbl.pos			or self:WorldSpaceCenter()
	tbl.radius		= tbl.radius		or 1000
	tbl.stepdown	= tbl.stepdown		or 20
	tbl.stepup		= tbl.stepup		or 20
	tbl.type		= tbl.type			or 'hiding'

	-- Use a path to find the length
	local path = Path( "Follow" )

	-- Find a bunch of areas within this distance
	local areas = navmesh.Find( tbl.pos, tbl.radius, tbl.stepdown, tbl.stepup )

	local found = {}

	-- In each area
	for _, area in pairs( areas ) do

		-- get the spots
		local spots 

		if ( tbl.type == 'hiding' ) then spots = area:GetHidingSpots() end

		for k, vec in pairs( spots ) do

			-- Work out the length, and add them to a table
			path:Invalidate()

			path:Compute( self, vec, 1 ) -- TODO: This is bullshit - it's using 'self.pos' not tbl.pos

			table.insert( found, { vector = vec, distance = path:GetLength() } )

		end

	end

	return found

end

-- bot think
-- local pos = self:FindSpot( "random", { type = 'hiding', radius = 5000 } )
-- if( pos ) then 
--  self:NB_moveToVector( pos )
-- end

function Meta:NB_FindSpot( type,  options )

	local spots = self:NB_FindSpots( options )
	if ( !spots || #spots == 0 ) then return end

	if ( type == "near" ) then

		table.SortByMember( spots, "distance", true )
		return spots[1].vector

	end

	if ( type == "far" ) then

		table.SortByMember( spots, "distance", false )
		return spots[1].vector

	end

	-- random
	return spots[ math.random( 1, #spots ) ].vector

end

function Meta:NB_moveToVector( pos, options )

	local options = options or {}

	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, pos )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() ) do

		path:Update( self )

		-- Draw the path (only visible on listen servers or single player)
		if ( options.draw ) then
			path:Draw()
		end

		--
		-- If they set maxage on options then make sure the path is younger than it
		--
		if ( options.maxage ) then
			if ( path:GetAge() > options.maxage ) then return "timeout" end
		end

		--
		-- If they set repath then rebuild the path every x seconds
		--
		if ( options.repath ) then
			if ( path:GetAge() > options.repath ) then path:Compute( self, pos ) end
		end

		coroutine.yield()

	end

	return "ok"
	
end


botchatresponse = ""
function url_encode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w ])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
          str = string.gsub (str, "%s+", "%%s0")
        end
  return str
end
local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

function unescape(str)
  str = string.gsub( str, '&lt;', '<' )
  str = string.gsub( str, '&gt;', '>' )
  str = string.gsub( str, '&quot;', '"' )
  str = string.gsub( str, '&apos;', "'" )
  str = string.gsub( str, '&#(%d+);', function(n) return string.char(n) end )
  str = string.gsub( str, '&amp;', '&' ) -- Be sure to do this after all others
  str = string.gsub( str, '<br>', '' ) -- Be sure to do this after all others
  return str
end


local Chavish = {
{ "what", "wot" };
{ "hey", "oi" };
{ "hi", "yo" }
}

function BotSendChatMessage( ply, msg )
	
	local TheReturnedHTML = ""; -- Blankness
	local bots = player.GetBots()
	
	-- print( Pandora..url_encode( msg ) )
	
	http.Fetch( Pandora..url_encode( msg ) ,
		function( body, len, headers, code )
			-- The first argument is the HTML we asked for.
			TheReturnedHTML = unescape( body );
			if ( string.len( TheReturnedHTML ) < 2 ) then return end
			if( #bots == 0 ) then return end
			
			-- botchatresponse = body;
			-- local LastEntry = string.find( TheReturnedHTML, "<b>Conversation Log:</b>" )
			local ResponseStart = string.find( TheReturnedHTML, "<that>" )
			local ResponseEnd = string.find( TheReturnedHTML, "</that>" )
			if( !ResponseStart ) then return end 
			-- print( ResponseStart, ResponseEnd )
			-- PrintTable( headers )
			local Response = string.sub( TheReturnedHTML, ResponseStart+6, ResponseEnd-1 )
			math.randomseed(CurTime()/frameTime())
			
			local bot = bots[math.random(1,#bots)]
			local nothing = {"I'm speechless..", "I have nothing to say really", "no comment", "ehm..", "this is awkward..", "ahem", "mkay..", "err..", "hm?", "what?", "le fuq?", "dafuq?", "no u", "stfu", "fagit", "Look uh.. Well.. Um.. Huh. Really don't know what to say about that." }
			
				
			if( string.len( Response ) > 1 ) then
			
				bot:Say( Response )
			
			else
				
				bot:Say( nothing[math.random(1,#nothing)] )
			
			end
			-- print( "Alice Said: ->"..Response.."<-" )
			
			
		end,
		function( error )
			-- We failed. =( 
		        local errurs = {
                        "that did not feel right",
                        "muh internets",
                        "something didnt work",
                        "the fuck just happened?",
                        "nope.",
                        "NO U",
                        "dafuq?",
                        "I cant let you do that dave.",
                        "you have issues.",
                        "mr supar man no home",
                        "lemon pledge",
                        "error 404, shitty joke not found",
                        "error 404, something fucked up",
                        " you broke it",
                        "MADAY, MADAY, I'M GOING DOWN, WE'VE GOTTEN AN ERROR! MADAY!",
                        " Bododobdobodod, The system, is down.",
                        " Amazing. You broke this for a second.",
                        " Give me a second to rethink my thoughts.",
                        "Oh tits. Please say that again.",
                        "Oh dicks, Please say that again.",
                        "You <ACTION>ed me. I cant really think of what to say.",
                        "Ah tits.",
                        "Ah fuck.",
                        "no",
                        "uh no",
                        "if you ask me that again, I'll cancel Half-Life 3",
                        "404! Shit not found.",
                        "Nein!",
                        "how about NO",
						"Ripporni",
						"ERRINUSERFILE-BOT.EXE HAS STOPPED RESPONDING. PLEASE CONTACT YOUR SYSTEM ADMINISTRATOR FOR SUPPORT.",
						"Hofforni wouldn't like you breaking his AI..",
						"El Hoffo wouldn't really like you breaking me.",
						"El hoff hoff.. Really wouldn't like you breaking My AI.",
						
                        }
			
			if( #bots > 0 ) then
			
				local bot = player.GetBots()[math.random(1,#player.GetBots())]
				
				bot:Say( errurs[math.random(1,#errurs)], false )
				
			end
			
			print("Timeout" )
			
		end )
	
	-- print( botchatresponse )
	
end

local function FindPlayerByPartialName( ply, name )

	if( name == nil ) then return ply end
	if( string.len( name ) <= 0 ) then return ply end
	
	for k,v in pairs( player.GetAll() ) do
													
		if( string.find( string.lower( v:GetName() ), string.lower( name ) ) != nil ) then

			return v
			
		end
		
	end
	
	
	return ply
	
end
CreateConVar("bot_talkwithbots", 1, FCVAR_NOTIFY ) -- obsolete
CreateConVar("bot_antispawnkill", 1, FCVAR_NOTIFY )



CreateConVar("bot_maxpvpdamage", 8, FCVAR_NOTIFY ) -- max damage before bots react to spawn killing


hook.Add("EntityTakeDamage", "BotAttackAttacker", function( bot, dmg )
	

	local atk = dmg:GetAttacker()
	
	if( IsValid( atk ) ) then
	
		atk.LastHostileAction = CurTime()
		
		if( IsValid( bot ) && bot:IsPlayer() && bot:IsBot() && atk:IsNPC() ) then
			
			bot.Target = atk
			
			return
			
		end
		
	end
	
	if( bot:IsPlayer() && atk:IsPlayer() && dmg:GetDamage() > GetConVarNumber("bot_maxpvpdamage") ) then
		
		
		
		local we = bot:GetActiveWeapon()
		if( IsValid( atk ) && ( !IsValid( we ) || ( IsValid( we ) && (  we:GetClass() == "weapon_physgun" ) || we:GetClass() == "gmod_tool" ) ) ) then
	
			if( GetConVarNumber( "bot_antispawn") == 0 ) then return end
			
			atk.LastSpawnKill = CurTime()
			
			
	
			for k,v in ipairs( ents.FindByClass("info_player_start") ) do
				-- If we're in visible range of a spawn point and our victim is unarmed, attack the attacker.
				if( inLOS( v, bot )  ) then
					
					for _,bot in ipairs( player.GetBots() ) do 	
						
						bot.Target = atk
					
					end
					
					-- AWOL rule breach found, no need to keep looping.
					break
					
				end
				
			end
		
		end
	
	end
	
	if( bot != atk && IsValid( bot ) && bot:GetClass() == "player" && bot:IsBot() && bot:Alive() && atk:IsPlayer() && atk:Alive() && inLOS( bot, atk ) ) then
		
		bot.Target = atk
		
		-- if( !IsValid( bot:GetActiveWeapon() ) ) then
			
			-- bot:Give("weapon_neurowep_pkm")
	
		-- end
		
	end

end ) 

local MadePhrases = {
"Well, you did",
"You created me",
"Can't you remember? You did",
"lol, you did"
}

function SayDelay( bot, word )
		
		timer.Simple( 0.25, function() 
				
			local bot = player.GetBots()[math.random(1,#player.GetBots())]
			bot:Say( word )
			 
		end )

end 

hook.Add("PlayerSay", "NeuroChatBot", function( ply, txt, team ) 
	
	local inpt = string.lower(txt)
	local splode = string.Explode( " ", inpt )
	local bot = player.GetBots()[math.random(1,#player.GetBots())]
	local neth = ( ply:SteamID() == "STEAM_0:0:19766778" )
	if( neth ) then 
	
		SayDelay( bot, "fucks sake.. BLOCKED" )
		return 
		
	end 
	
	if( ( splode[1] == "bot" || splode[1] == "bots" ) && GetConVarNumber("bot_talk" ) > 0 && #player.GetBots() > 0 ) then
		
		local v1 = string.find( inpt, "bot " ) != nil || string.find( inpt, "bot0" ) != nil
		
		local v2 = table.HasValue( splode, "bot" )
		local bt = GetConVarNumber("bot_talkwithbots",0)>0
		-- print( bt )
		local hoffa = ( ply:SteamID() == "STEAM_0:0:5947985" )
		local follow = string.find( inpt, "bot follow me")  != nil && ( ply:IsAdmin() || hoffa )
		local killme = string.find( inpt, "bot kill me" ) != nil
		local shouldattacktarget = string.find( inpt, "bot attack " ) != nil 
		local cometome = ( string.find( inpt, "bot come to me" ) || string.find( inpt, "bots come to me" ) ) && ( ply:IsAdmin() || hoffa )
		local cleanthemap = string.find( inpt, "bot clean the map" ) && ply:IsAdmin()
		local nukethemap = ( inpt == "bot takbir!" || inpt == "bot takbir !" || inpt == "bot what do you say to infidels?" )
		local whomadeyou = ( string.find( inpt, "who made you?" ) != nil || string.find( inpt, "who created you?" ) != nil )
		local whoami = ( string.find( inpt, "who am i?" ) != nil )
		

		local attacktarget = FindPlayerByPartialName(  bot,  splode[3])
	
		-- bragging rights 
		if( whoami && hoffa ) then 

			SayDelay( bot, "You're the creator of NeuroTec" )
			return 
		end 
		if( whomadeyou && hoffa ) then 
			
			SayDelay( bot, MadePhrases[math.random(1,#MadePhrases)] )
			return 
		end 
		

		-- PrintTable( splode q)
		local dontsay = false
		
		if( cleanthemap ) then
				
			
			timer.Simple( 0, function() if( IsValid( bot ) ) then bot:Say("*magic*") end end )
			game.CleanUpMap()
			dontsay = true
			
		end
			
			
		
		
		if( nukethemap && ( ply:IsSuperAdmin() || hoffa ) ) then
			
			for k,v in ipairs( player.GetBots() ) do
				
				
				
				-- v:StripWeapons()
				
				if( IsValid( v:GetActiveWeapon() )  && type(v:GetActiveWeapon().SetWeaponHoldType) == "function" ) then
					
					v:GetActiveWeapon():SetWeaponHoldType( "melee" )
					
				end
				
				timer.Simple( k/2, 
				function()
						
					v:EmitSound( "bots/akbar"..math.random(1,7)..".mp3", 511, 100 )
					
					v:Say("ALLAHU AKBAR !!!")
			
					if( IsValid( v ) ) then
						
							timer.Simple( math.Rand( 1, 2 ), function() 
							
								if( IsValid( v ) ) then
						
									ParticleEffect("rt_impact", v:GetPos(), Angle(0,0,0), nil )
									v:EmitSound( "ambient/explosions/exp2.wav", 150, 100 )
									util.BlastDamage( v, v, v:GetPos()+Vector(0,0,74), 1512, math.random( 500, 2500 ))
									
								end 
						
							end )
						
						end
						
					end )
					
			
			end
			
			dontsay = true
	
			
		end
		if( cometome ) then
			
			for k,v in pairs( player.GetBots() ) do
			
				v:SetPos( ply:GetPos() + Vector( math.random(-250,250), math.random(-250,250), 16 ) )
				
			end
			
			dontsay = true
			
		end
		
		-- print( attacktarget, shouldattacktarget, inpt, splode[3] ) 
		if( shouldattacktarget && !attacktarget:IsBot() ) then
			
			if( ply:IsAdmin() || hoffa ) then
				
				for k,v in pairs( player.GetBots() ) do 
					
					if( inLOS( v, attacktarget ) ) then	
							
						v.Target = attacktarget
						attacktarget.LastSpawnKill = CurTime() + 60
						-- print("atatcking")
						dontsay = true
						
						local object = objects[math.random(1,#objects)]
						local action = actions[math.random(1,#actions)]
						local swear = swears[math.random(1,#swears)]
						local chap = chaps[math.random(1,#chaps)]
						if( !IsValid( attacktarget ) ) then return end
						
						incrementTalk()
						local sentence = string.format( targetphrases[TARGET_PHRASE_INDEX], attacktarget:Nick() )
						
						-- print( object, action, swear )
						sentence = string.Replace( sentence, "<OBJECT>", object )
						sentence = string.Replace( sentence, "<ACTION>", action )
						sentence = string.Replace( sentence, "<CUSS>", swear )
						sentence = string.Replace( sentence, "<CHAPS>", chap )
						
						v.LastChatter = NOW
						SayDelay(v, sentence )
						
						
					end
					
				end
				
			end
		
		
		end
		
		if( follow ) then
					
			for k,v in pairs( player.GetBots() ) do
				
				if( inLOS( v, ply ) ) then
				
						v.FollowTarget = ply
					
						dontsay = true
					
					
				end
			
			end
		
		end
		
		
		if( killme ) then
			
			if( !ply.LastKilledByBot ) then ply.LastKilledByBot = 0 end
			
			if( ply.LastKilledByBot + 30.0 <= CurTime() ) then
			
				ply.LastKilledByBot = CurTime()
				
				math.randomseed( FrameTime()*CurTime() )
				
				local Deaths = { "!rlaunch", "!burn", "!bolt", "!cockslap", "!train", "!launch" }
		
				timer.Simple( 0.5, function()
					if( IsValid( bot ) ) then
					
						-- if( math.random( 1, 2 ) == 2 ) then
			
							bot:Say(  Deaths[math.random(1,#Deaths)].." "..ply:Nick()  )
							dontsay = true
						-- else
						
							-- util.BlastDamage( bot, bot, ply:GetPos(),  32, 500000000 )
							-- bot:Say(  "Wish Granted"  )
							
						-- end
						
					end
					
				end )
			end
			
		end
		-- print("what")
		-- print( bt, ply:IsBot(), v1, v2 )
		
		if( ( ( !bt && !ply:IsBot() ) || ( bt && ply:IsBot() ) || ply:IsPlayer() ) && ( v1 || v2 ) ) then
			
			
			local msg = string.Replace( txt, "bot ", "" )
			if( !dontsay ) then
			
				BotSendChatMessage( ply, unescape( msg ) )
			
			end
			
		end		 
		 
	end

	return 
	
end )

-- hook.Add("PlayerSpawn", "NeuroTankBots_ChangeBotModel", function( ply ) 
	
	-- local mdls = { "models/player/skeleton.mdl" }
	
	-- if( ply:IsBot() ) then
		
		-- ply:SetModel( mdls[math.random(1,#mdls)] )
		-- ply:SetSkin( 1 )
		
	-- else
		
		
	-- end
	
-- end )


-- PrintTable( hook.GetTable().Think )
-- for k,v in pairs( hook.GetTable()["Think"] ) do
	
	-- print( v )

-- end

if( table.HasValue( hook.GetTable(), "NeuroTanksBotThink" ) ) then
	
	hook.Remove("Think","NeuroTanksBotThink" )
	
	print( "Removed Pre-Existing Bot Think Hook" )
	
end
--[[
function BotThinkNew()
	
	NOW = CurTime()
	
	-- if( botLastTick + 0.25 > CurTime() ) then return end
	
	-- botLastTick = CurTime()
	
	if( lastupdate + 3 <= NOW ) then
		
		lastupdate = NOW
		
		allEnts =  ents.GetAll() 
		allPlys = player.GetAll()
		dumbfucks = player.GetBots()
		botcount = #dumbfucks
		rides = {}

		for k,v in ipairs( allEnts ) do
			
			if( IsValid( v ) && v.TankType && v.Fuel && v.Fuel > 0 && (  v.Wheels || v.DriveWheels ) && !v.IsDriving && !IsValid( v.Pilot ) ) then
				
				if( !table.HasValue( rides, v ) ) then
				
					table.insert( rides,  v )
				
				end
				
			end
		
		end
		
	end
	
	for i=1,botcount do
		
		tankdist = 0
		closest = 9999999
		bot = dumbfucks[i]
		
		if( IsValid( bot ) && bot:Alive() ) then

			if( !IsValid( bot.Tank ) ) then
				
				if( IsValid( bot.Target ) && bot.Target:IsPlayer() && #rides > 0 ) then bot.Target = NULL end
				
				if( !IsValid( bot.Target ) ) then
					
					if( !bot.LastRideCheck ) then bot.LastRideCheck = NOW end
					
					if( bot.LastRideCheck + 1.0 <= NOW ) then
						
						bot.LastRideCheck = NOW
						
						for k,v in ipairs( rides ) do
							
							if( IsValid( v ) ) then
							
								if( IsValid( v.Pilot ) ) then table.remove( rides, k ) return end
								tankdist = ( bot:GetPos() - v:GetPos() ):Length()
								if( tankdist < closest ) then
									
									closest = tankdist
									bot.Target = v
									bot.LastAssignedTarget = NOW
									
									-- bottarget = v
									
								end
								
							else
								
								table.remove( rides, k )
							
							end
							
						end
						
					end
				
				else
					
					if( IsValid( bot.Target.Pilot ) ) then bot.Target = NULL return end 
					
					local a = ( bot.Target:GetPos() -  bot:GetShootPos() ):Angle()
					a.p = math.NormalizeAngle( a.p )
					a.y = math.NormalizeAngle( a.y )
					a.r = math.NormalizeAngle( a.r )
					bot:SetEyeAngles( a )
					local le = ( bot:GetPos() - bot.Target:GetPos() ):Length()
					if( bot:OnGround() && le > 200 ) then
					
						bot:SetVelocity( bot:GetForward() * 64 )
					
					end
					
					if(  le < 220 && bot.Target.TankType != nil ) then
						
						bot.Tank = bot.Target
						bot.Target:Use( bot, bot, 0, 0 )
						bot.Target = NULL
						closest = 999999
						
						return
						
					end
					
				end
				
				
			else
					
				if( bot.Tank:IsPlayer() ) then bot.Tank = NULL return end
				
				bot.Tank.Fuel = bot.Tank.MaxFuel -- hax
			
				if( GetConVarNumber("bot_talk", 0 ) > 0 ) then
						
					math.randomseed(NOW/frameTime()/100)
					if( !bot.LastChatter ) then bot.LastChatter = 0 bot.ChatDelay = math.random(35,65) end
				
					if( IsValid( bot.Target ) && bot.LastChatter + bot.ChatDelay <= NOW ) then
						
						local object = objects[math.random(1,#objects)]
						local action = actions[math.random(1,#actions)]
						local swear = swears[math.random(1,#swears)]
						local sentence = string.format( targetphrases[math.random(1,#targetphrases)], bot.Target:Nick() )
						
						-- print( object, action, swear )
						sentence = string.Replace( sentence, "<OBJECT>", object )
						sentence = string.Replace( sentence, "<ACTION>", action )
						sentence = string.Replace( sentence, "<CUSS>", swear )
						
						bot.LastChatter = NOW
						bot:Say( sentence, false )
						
					end	
					
				end
				
				if( IsValid( bot.Target ) ) then
					
					-- print( bot.Target )
					-- if( !IsValid( bot.Target ) ) then bot.Target = NULL return end
					if( IsValid( bot.Target ) && bot.Target:IsPlayer() && !bot.Target:Alive() ) then bot.Target = NULL return end
					if( !inLOS( bot, bot.Target ) ) then bot.Target = NULL return end
					
					-- if( IsValid( bot.Tank ) && bot.Tank.Fuel && bot.Tank.Fuel <= 0 ) then bot.Tank:TankExitVehicle() return end
					
					tankdist = ( bot:GetPos() - bot.Target:GetPos() ):Length()
					
					local a = ( bot:GetShootPos() - bot.Target:GetPos() ):Angle()
					a.p = math.NormalizeAngle( a.p )
					a.y = math.NormalizeAngle( a.y )
					a.r = math.NormalizeAngle( a.r )
					
					bot:SetEyeAngles( a )
					bot.ClientVector = bot.Target:GetPos()
					bot.Tank.SCUDTransportMode = true
				
					if( inLOS( bot, bot.Target ) ) then
						
						if( tankdist < 700 && IsValid( bot.Target:GetScriptedVehicle() ) ) then
							
							bot.Tank:TankDriveBackward()
							
						elseif( tankdist < 700 && IsValid( bot.Target ) && !IsValid( bot.Target:GetScriptedVehicle() ) ) then
							
							
							bot.Tank:TankDriveForward()
							
							
						end
						
						if( IsValid( bot.Tank.MGun ) && tankdist < 1000 ) then
						
							bot.Tank:TankSecondaryAttack( bot )
						
						end
						
						if( tankdist > 2000 ) then
							
							bot.Tank:TankDriveForward()
							
						elseif( tankdist > 200 && tankdist < 4000  ) then
							
							local theta = 0
							
							if( IsValid( bot.Tank.Barrel  ) ) then
								
								theta = bot.Tank.Barrel:GetNetworkedInt("BarrelTheta", 0 )
								
							end
							
							if( bot.Tank.ShellDelay && bot.Tank.ShellDelay <= NOW && ( bot.Tank.Barrel:GetAngles().p - theta < .2 ) ) then
								
								bot.Tank.ShellDelay = NOW + bot.Tank.PrimaryDelay
								
								LastAction = NOW
								
								bot.Tank:TankPrimaryAttack()
						
							end
						
						end
						
					end
	
				else
					
					if( !bot.LastPlayerCheck ) then bot.LastPlayerCheck = NOW end
					
					if( bot.LastPlayerCheck + 1.0 <= NOW ) then
						
						bot.LastPlayerCheck = NOW
						
						for k,v in ipairs( allPlys ) do
							
							if( IsValid( v ) && v != bot && v:Alive() && inLOS( bot, v ) ) then
								
								-- local tankdist = ( bot:GetPos() - v:GetPos() ):Length()
								if( tankdist < closest ) then
									
									closest = tankdist
									bot.Target = v
									
								end
								
							
							end
						
						end
						
					end
					
				end
				
				-- print( bot.Target, bot.Tank )	
			end
			
			if( !IsValid( bot.Target ) && !IsValid( bot.Tank ) && #rides == 0 ) then
				
				if( bot.LastRideCheck && bot.LastRideCheck + 2.0 <= CurTime() ) then
					
					LastRideCheck = NOW
					
					for k,v in ipairs( allEnts ) do
							
						if( inLOS( v, bot ) && ( (  v.VehicleType != nil && IsValid( v.Pilot ) ) || v:IsNPC() ) ) then
							
							bot.Target = v
							
							break
		
						end
					
					end
					
				end
				
			end	
			
			if( IsValid( bot.Target ) && !IsValid( bot.Tank ) ) then
					
				if( !inLOS( bot, bot.Target ) ) then
					
					bot.Target = NULL
				
					return
				
				else
				
					local a = ( bot.Target:GetPos() - bot:GetShootPos() ):Angle()
					
					if( bot.Target:IsPlayer() ) then
						
						a = ( bot.Target:GetShootPos() - bot:GetShootPos() ):Angle()
						
					end
					-- print("walla")
					a.p = math.NormalizeAngle( a.p )
					a.y = math.NormalizeAngle( a.y )
					a.r = math.NormalizeAngle( a.r )
					
					bot:SetEyeAngles( a )
				
					local tr,trace ={},{}
					tr.start = bot:GetShootPos()
					tr.endpos = tr.start + bot:GetAimVector() * 250000 + VectorRand() * 5
					tr.filter = { bot }
					tr.mask = MASK_SOLID
					trace=util.TraceLine( tr )
					
					if( !bot.LastAttackAttempt ) then bot.LastAttackAttempt = NOW end
					
					local wep = bot:GetActiveWeapon()
					local attackdelay = 2
					if( wep && wep.Primary && wep.Primary.Delay ) then
						
						attackdelay = wep.Primary.Delay 
						
					end
					
					if( bot.LastAttackAttempt + attackdelay <= NOW && IsValid( wep ) && wep.PrimaryAttack != nil && trace.Hit && trace.Entity == bot.Target && inLOS( bot, bot.Target ) ) then
						
						-- print( "shoot", attackdelay )
						
						bot.LastAttackAttempt = NOW
						wep:PrimaryAttack()
						
					end
					
				
				end
					
			end
			
		end
		
	end
	
end
]]--

local allEnts = {}
local allPlys = {}
local bots = {}

local LastTick = CurTime()
local LastAction = CurTime()
local pos
local mp

local lastupdate = 0
local botcount = 0
local tankdist=0
local closest = 999999999

local dumbfucks = {}
local rides = {}
local bot = NULL
local bottarget = NULL

local botLastTick = 0
local NOW = 0 --CurTime()
function Meta:BotThink()
	
	if( lastupdate + 2 <= NOW ) then
		
		
		lastupdate = NOW
		
		allEnts =  ents.GetAll() 
		allPlys = player.GetAll()
		dumbfucks = player.GetBots()
		botcount = #dumbfucks
		rides = {}

		for k,v in ipairs( allEnts ) do
			
			if( IsValid( v ) && ( ( v.IsMadMaxVehicle || v.IsMicroCruiser ) || ( v.TankType && v.Fuel && v.Fuel > 0 && (  v.Wheels || v.DriveWheels ) && !v.IsDriving ) ) && !IsValid( v.Pilot ) ) then
				
				if( !table.HasValue( rides, v ) ) then
				
					table.insert( rides,  v )
				
				end
				
			end
		
		end
		
	end
	
	NOW = CurTime()
	-- if( !self:Alive() ) then return end
	local bot = self
	bot.Tank = bot.Tank or bot:GetScriptedVehicle()
	tankdist = 0
	closest = 9999999
	-- bot = dumbfucks[i]
	-- bot:SetEyeAngles( (  bot:GetPos() - player.GetAll()[1]:GetPos() ):Angle() )
	
	if( IsValid( bot ) && bot:Alive() ) then

		if( !IsValid( bot.Tank ) ) then
			
			--if( IsValid( bot.Target ) && bot.Target:IsPlayer() && #rides > 0 ) then bot.Target = NULL end
			
			if( !IsValid( bot.Target ) ) then
				
				if( IsValid( bot:GetActiveWeapon() ) && bot:GetActiveWeapon():GetClass() == "weapon_neurowep_chainsaw" ) then 
					
					while( !IsValid( bot.Target ) || bot.Target == bot ) do 
						
						bot.Target = player.GetAll()[math.random(1,#player.GetAll())]
					
					end 
					
					
				end 
				
				if( bot.LastRideCheck == nil ) then bot.LastRideCheck = NOW end
				-- print(  bot.LastRideCheck == nil )
				-- if true then return end
				
				if( bot.LastRideCheck + 1.0 <= NOW ) then
					
					bot.LastRideCheck = NOW
					
					for k,v in ipairs( rides ) do
						
						if( IsValid( v ) ) then
						
							if( IsValid( v.Pilot ) ) then table.remove( rides, k ) return end
							tankdist = ( bot:GetPos() - v:GetPos() ):Length()
							if( tankdist < closest ) then
								
								closest = tankdist
								bot.Target = v
								bot.LastAssignedTarget = NOW
								
								-- bottarget = v
								
							end
							
						else
							
							table.remove( rides, k )
						
						end
						
					end
					
				end
			
			else
				
				if( IsValid( bot.Target.Pilot ) ) then bot.Target = NULL return end 
				
				local le = ( bot:GetPos() - bot.Target:GetPos()+Vector(0,0,50) ):Length()
				local mdist = 500
				if( bot.Target.TankType != nil ) then
					
					mdist = 50 
					
				end
				if( IsValid( bot:GetActiveWeapon() ) && bot:GetActiveWeapon():GetClass() == "weapon_neurowep_chainsaw" ) then 
					
					mdist = 0 
					-- le = 9 
					
				end 
				
				if( bot:OnGround() && le > mdist+math.sin(CurTime())*400 ) then
				
					bot:SetVelocity( bot:GetForward() * 100 )
					
					if( le < 44+math.sin(bot.ScatterDir*bot:EntIndex()*CurTime()*FrameTime())*500 && !bot.Target.TankType ) then
					
						bot:SetVelocity( LerpVector( 0.77, bot:GetVelocity()*FrameTime(), bot:GetRight() * math.cos(CurTime())*55*bot.ScatterDir) )
					
					end
				
				else
					
					
					if(  bot:OnGround() &&  math.sin(CurTime()/10) > 0 ) then
					
						bot:SetVelocity( LerpVector( 0.7, bot:GetVelocity()*FrameTime(), bot:GetForward() * -65 + bot:GetRight() * math.cos(CurTime())*50*bot.ScatterDir ) )
					
					end
					
				end
					
				if( !bot.Target:IsPlayer() ) then 
				
					local a = ( bot.Target:GetPos() -  bot:GetShootPos() ):Angle()
					if( bot.Target:IsNPC() ) then
						
							local BoneIndx = bot.Target:LookupBone("ValveBiped.Bip01_Head1")
							if( BoneIndx ) then
							
								local BonePos , BoneAng = bot.Target:GetBonePosition( BoneIndx )
								a = ( BonePos - bot:GetShootPos() ):Angle()
							end
							
					end
					
					a.p = math.NormalizeAngle( a.p )
					a.y = math.NormalizeAngle( a.y )
					a.r = math.NormalizeAngle( a.r )
					bot:SetEyeAngles( LerpAngle( 0.01, bot:EyeAngles(), a ) )
				
					
					if( le < 220 && ( bot.Target.TankType != nil || bot.Target.IsMicroCruiser || bot.Target.IsMadMaxVehicle ) ) then
						
						bot.Tank = bot.Target
						bot.Target:Use( bot, bot, 0, 0 )
						bot.Target = NULL
						closest = 999999
						
						return
						
					end
				
				end
				
			end
			
			
		else
				
			if( bot.Tank:IsPlayer() ) then bot.Tank = NULL return end
			
			bot.Tank.Fuel = bot.Tank.MaxFuel -- hax
		
			if( GetConVarNumber("bot_talk", 0 ) > 0 ) then
					
				math.randomseed(NOW/frameTime()/100)
				if( !bot.LastChatter ) then bot.LastChatter = 0 bot.ChatDelay = math.random(35,65) end
					
					-- print( bot.Target )
				if( IsValid( bot.Target ) && bot.LastChatter + bot.ChatDelay <= NOW && bot.Target:IsPlayer() ) then
					
					local object = objects[math.random(1,#objects)]
					local action = actions[math.random(1,#actions)]
					local swear = swears[math.random(1,#swears)]
					
					incrementTalk()
					local sentence = string.format( targetphrases[TARGET_PHRASE_INDEX], bot.Target:Nick() )
					
					-- print( object, action, swear )
					sentence = string.Replace( sentence, "<OBJECT>", object )
					sentence = string.Replace( sentence, "<ACTION>", action )
					sentence = string.Replace( sentence, "<CUSS>", swear )
					
					bot.LastChatter = NOW
					bot:Say( sentence, false )
					
				end	
				
			end
			
			if( IsValid( bot.Target ) ) then
				
				-- print( bot.Target )
				-- if( !IsValid( bot.Target ) ) then bot.Target = NULL return end
				if( IsValid( bot.Target ) && bot.Target:IsPlayer() && !bot.Target:Alive() ) then bot.Target = NULL return end
				if( !inLOS( bot, bot.Target ) ) then bot.Target = NULL return end
				
				-- if( IsValid( bot.Tank ) && bot.Tank.Fuel && bot.Tank.Fuel <= 0 ) then bot.Tank:TankExitVehicle() return end
				
				tankdist = ( bot:GetPos() - bot.Target:GetPos() ):Length()
				
				local a = ( bot:GetShootPos() - bot.Target:GetPos() ):Angle()
				
				if( bot.Target:IsPlayer() ) then
					
					local BoneIndx = bot.Target:LookupBone("ValveBiped.Bip01_Head1")
					local BonePos , BoneAng = bot.Target:GetBonePosition( BoneIndx )
					a = ( BonePos - bot:GetShootPos() ):Angle()
			
				end
				
				a.p = math.NormalizeAngle( a.p )
				a.y = math.NormalizeAngle( a.y )
				a.r = math.NormalizeAngle( a.r )
				
				bot:SetEyeAngles( LerpAngle( 0.65, bot:EyeAngles(), a ) )
				bot.ClientVector = bot.Target:GetPos()
				bot.Tank.SCUDTransportMode = true
				
				if( inLOS( bot, bot.Target ) ) then
					
					if( bot.Target:IsPlayer() && IsValid( bot.Target:GetScriptedVehicle() ) ) then
					
						if( tankdist < 700 ) then
							
							bot.Tank:TankDriveBackward()
							
						elseif( tankdist < 700 ) then
							
							
							bot.Tank:TankDriveForward()
							
						end
						
					else
						
						-- if( !bot.Target:IsPlayer() ) then
						
							if( tankdist < 700 ) then
								
								bot.Tank:TankDriveForward()
							
							end
						
						-- end
						
					end
					
					if( IsValid( bot.Tank.MGun ) && tankdist < 1000 ) then
						
						bot.Tank.MGun:SetAngles( ( bot.Target:GetPos()  -  bot.Tank.MGun:GetPos() ):Angle() )
						bot.Tank:TankSecondaryAttack( bot )
					
					end
					
					if( tankdist > 2000 ) then
						
						bot.Tank:TankDriveForward()
						
					elseif( tankdist > 200 && tankdist < 4000  ) then
						
						local theta = 0
						
						if( IsValid( bot.Tank.Barrel  ) ) then
							
							theta = bot.Tank.Barrel:GetNetworkedInt("BarrelTheta", 0 )
							
						end
						
					
						if( bot.Tank.ShellDelay && bot.Tank.ShellDelay <= NOW && ( bot.Tank.Barrel:GetAngles().p - theta < .2 ) ) then
							
							if( bot.Tank.SCUDAngle && bot.Tank.SCUDAngle < 87 ) then return end
							if( bot.Tank.SCUDAngle && tankdist < 5000 ) then return end 
							bot.Tank.ShellDelay = NOW + bot.Tank.PrimaryDelay
							
							LastAction = NOW
							
							
							bot.Tank:TankPrimaryAttack()
					
						end
					
					end
					
				end

			else
				
				if( !bot.LastPlayerCheck ) then bot.LastPlayerCheck = NOW end
				
				if( bot.LastPlayerCheck + 1.0 <= NOW ) then
					
					bot.LastPlayerCheck = NOW
					
					for k,v in ipairs( allEnts ) do
						
						if( inLOS( bot, v ) && bot != v ) then
								
							if( v:IsPlayer() && v:Frags()/v:Deaths() > 7 ) then
								
								bot.Target = v
								
								break
								
							end
							
							if( IsValid( v ) && v != bot && ( v:IsNPC() || ( v:IsPlayer() && v:Alive() ) ) ) then
								
								if( v.LastSpawnKill && v.LastSpawnKill + 300 >= CurTime() ) then
								
									bot.Target = v
									v.LastSpawnKill = 0
									
									break
									
								end
						
								-- local tankdist = ( bot:GetPos() - v:GetPos() ):Length()
								if( tankdist < closest ) then
									
									closest = tankdist
									bot.Target = v
									
								end
							
							end
							
							
						end
					
					end
					
				end
				
			end
			
			-- print( bot.Target, bot.Tank )	
		end
		
		if( !IsValid( bot.Target ) && !IsValid( bot.Tank ) && #rides == 0 ) then
			
			if( bot.LastBoredTargetCheck && bot.LastBoredTargetCheck + math.Clamp( #ents.FindByClass("npc_*")/2, 2, 7 ) < NOW ) then
				
				if( IsValid( bot.FollowTarget ) && !inLOS( bot, bot.FollowTarget ) ) then bot.FollowTarget = NULL end
				
				bot.LastBoredTargetCheck = NOW
				closest = 99999990
				if( !IsValid( self.FollowTarget ) ) then
				
				for k,v in ipairs( allPlys ) do
					
					if( IsValid( v ) ) then
					
						if( inLOS( bot, v ) ) then
									
							if( v:IsPlayer() && v:Frags() > 10 && v:Frags()/v:Deaths() > 5 || ( !v:IsBot() && v.SpawnKills && v.SpawnKills >= 3  ) ) then
								
								if( tankdist < closest ) then
									
									closest = tankdist
									bot.Target = v
								
								end
								
								break
								
							end
								
								if( v != bot && ( v:IsNPC() || ( v:IsPlayer() && v:Alive() && !v:IsBot() ) ) ) then
									
						
									if( v.LastSpawnKill && v.LastSpawnKill + 5 >= CurTime() ) then
									
										bot.Target = v
										--//v.LastSpawnKill = 0
									
										break
									
									end	
									-- local tankdist = ( bot:GetPos() - v:GetPos() ):Length()
									if( tankdist < closest ) then
									
										closest = tankdist
										bot.FollowTarget = v
										
									end
								
								end
								
							end
							
						end
						
					end
				
				end
				
			else
			-- print( bot.LastRideCheck )
				-- print("yo ?") 
				if( !bot.LastBoredTargetCheck ) then
					
					bot.LastBoredTargetCheck = NOW
					
				end
				
				
			end
			
		end	
		
		if( IsValid( bot.Target ) && !IsValid( bot.Tank ) ) then
				
			inLOS( bot, bot.Target )
			
			if( bot.Target:IsPlayer() && !bot.Target:Alive() ) then bot.Target = NULL return end
			
			local extra = bot.Target.SpawnKills or 0
			
			-- repeating spawn kill offence makes the bots remember you longer.
			if( bot.LastLOS && bot.LastLOS + 5+(extra^3) < CurTime() ) then
				
				bot.FollowTarget = bot.Target
				bot.Target = NULL
			
				return
			
			else
			
				local a = ( bot.Target:GetPos()+Vector(0,0,72) - bot:GetShootPos() ):Angle()
				if( bot.Target:IsPlayer() ) then
					
					local BoneIndx = bot.Target:LookupBone("ValveBiped.Bip01_Head1") or 2
					local BonePos , BoneAng = bot.Target:GetBonePosition( BoneIndx )
					a = ( BonePos - bot:GetShootPos() ):Angle()
			
					if( bot:GetPos():Distance( bot.Target:GetPos() ) > 3500 ) then
				
					end
					
				end
				
					
				a.p = math.NormalizeAngle( a.p )
				a.y = math.NormalizeAngle( a.y )
				a.r = math.NormalizeAngle( a.r )
				
				bot:SetEyeAngles( LerpAngle( 0.1051, bot:EyeAngles(), a ) )
				-- bot:SetAngles( LerpAngle( 1, bot:EyeAngles(), a ) )
			
				local tr,trace ={},{}
				tr.start = bot:GetShootPos()
				tr.endpos = tr.start + bot:GetAimVector() * 36000
				tr.filter = { bot }
				tr.mask = MASK_SOLID
				trace=util.TraceLine( tr )
				-- bot:DrawLaserTracer( tr.start, trace.HitPos )
				-- bot:DrawLaserTracer( tr.start, trace.HitPos )
				
				if( !bot.LastAttackAttempt ) then bot.LastAttackAttempt = NOW end
				
				local wep = bot:GetActiveWeapon()
				
				if( IsValid( wep ) && wep.Primary && bot:GetAmmoCount( wep.Primary.Ammo ) <= 0 && wep:Clip1() <= 0 ) then
					
					bot:StripWeapon( bot:GetActiveWeapon():GetClass() )
					
				end
				
				// not holding a scripted weapon, replace it
				if( ( IsValid( wep ) && !wep.PrimaryAttack ) || !IsValid( wep ) && !IsValid( bot:GetScriptedVehicle()  ) ) then
					
					bot:StripWeapons()
					bot:Give(guns[math.random(1,#guns)])
					-- bot:Give("item_ammo_smg1")
			
				end
				
				
				local adel = 2.0
				
				if( IsValid( wep ) && wep.Primary ) then
					
					if( wep.Primary.Delay ) then	
						
						adel = wep.Primary.Delay
						
					end
					
					if( wep.Primary.RPM ) then -- M9k shit
						
						adel = 60 / wep.Primary.RPM
						
					end
				
				end
				
				-- print( wep:Clip1() <= 0, bot:GetAmmoCount( wep.Primary.Ammo ) > 0)
				
				if( wep && wep.Clip1 != nil && wep:Clip1() <= 0 ) then
					
					bot:StripWeapons()
					bot:Give(guns[math.random(1,#guns)])
					
					-- if( wep.DryFire ) then
						-- wep:DryFire( wep.SetNextPrimaryFire )
						
					-- end
					-- print( wep:Clip1(), bot:GetAmmoCount( wep.Primary.Ammo ) )
					-- print("reloading")
					-- adel = 2.5
						
					-- return
				
					-- print("reloading")
				end
				
				
				if( bot.LastAttackAttempt + adel <= NOW && IsValid( wep ) && !trace.Entity.IsMadMaxVehicle && !trace.Entity.IsMicroCruiser && wep.PrimaryAttack != nil && trace.Hit && ( trace.Entity == bot.Target || ( bot.Target:IsPlayer() && IsValid( bot.Target:GetScriptedVehicle() ) ) ) ) then
					
					local we = NULL
					
					if( IsValid( bot.Target ) && bot.Target:IsPlayer() ) then 
					
						we = bot.Target:GetActiveWeapon()
					
					end
					
					if( bot.Target.TankType && !IsValid( bot.Target.Pilot ) ) then return end
					
					local lasthostile = bot.Target.LastHostileAction or 0
					
					if( lasthostile + 25 <= CurTime() && ( bot.Target:IsPlayer() && ( !IsValid( we ) || ( IsValid( we ) && ( we:GetClass() == "weapon_physgun") ) ) ) ) then bot.Target = NULL return end
					
					bot.LastAttackAttempt = NOW
					wep:PrimaryAttack( wep.Primary.Sound or "" )
					
					bot:SetEyeAngles( bot:EyeAngles() )
					
				end
				
			end
			
		else
		
			if( bot:OnGround()  && !IsValid( bot.Target ) && IsValid( bot.FollowTarget ) && inLOS( bot, bot.FollowTarget ) && bot:OnGround() ) then
				
				-- for k,v in ipairs( allPlys ) do
					
					-- if(  ( v:GetPos() - bot:GetPos() ):Length() < 200 ) then
						
						-- bot:SetVelocity( LerpVector( 0.01, bot:GetVelocity() * FrameTime(),  ( ( v:GetPos()+bot.RandomPos )  - bot:GetPos() ):GetNormalized() * -500  )  )
						
					-- end
					
				-- end
				local maxdist = 255 
				local chainsaw = false 
				if( IsValid( bot:GetActiveWeapon() ) && bot:GetActiveWeapon():GetClass() == "weapon_neurowep_chainsaw" ) then 
					
					maxdist = 10
					chainsaw = true 
					
				end 
				local dist = ( bot:GetPos() - bot.FollowTarget:GetPos() ):Length()
				if( dist > maxdist  ) then
				
					bot:SetVelocity( LerpVector( 0.9, bot:GetVelocity()*FrameTime(), ( bot.FollowTarget:GetPos() - bot:GetPos()  ):GetNormalized() * 65 ) )
					
				
				else
					
					-- bot:SetVelocity(  ( bot:GetPos() - bot.FollowTarget:GetPos() ):GetNormalized() * -65 ) 
	
				end
				
				if( dist > 150 || chainsaw ) then
				
					bot:SetEyeAngles( LerpAngle( 0.075, bot:EyeAngles(), (  bot.FollowTarget:GetPos()+bot.RandomPos*(1*bot.ScatterDir)  - bot:GetPos() ):Angle() ) )
				
				else
				
					-- bot:SetVelocity( bot:GetRight() * 30 ) 
				
					bot:SetEyeAngles( LerpAngle( 0.051, bot:EyeAngles(), ( bot:GetPos() - ( bot.FollowTarget:GetPos() + bot.FollowTarget:GetRight() * math.sin(CurTime()/bot:EntIndex())*550 ) ):Angle() ) )
					
				end
				
			end
				
			
		end
		
	end

end
local BotNames = {
"[NeuroTec]Steven Seagal",
"[NeuroTec]j0ko",
"HeatoN^",
"[NeuroTec]Hoffa",
"[NeuroTec]StarChick971",
"[NeuroTec]Sillirion",
"[NeuroTec]Aftokinito",

}
local botcount = 0

hook.Add("PlayerInitialSpawn","BotSpawnHook", function( ply )
	
	-- if( !ply:IsBot() )then
		
		-- if( GetConVarNumber("bot_autospawn") > 0 ) then
			
			-- if ( #player.GetBots() < 4 ) then
				-- botcount = botcount + 1 
				
				-- player.CreateNextBot(BotNames[botcount])
				
			-- end
		
		-- end
	
	-- end
	
	if( ply:IsBot() ) then
		
		local hookName = "neurotec_"..ply:Name().."_"..ply:EntIndex()
		-- print( "Created Think Hook", hookName, ply )
		local scattr = {-1,1}
		ply.ScatterDir = scattr[math.random(1,2)]
		ply.RandomPos = VectorRand() * 256
		ply.RandomPos.z = 0
		
		hook.Add("Think", hookName, 
		function() 	
			if( GetConVarNumber( "bot_drivetanks", 0 ) < 1 ) then return end
			if(IsValid( ply ) ) then 
				
				-- ply.LastRideCheck = CurTime()
				ply:BotThink() 
			
			else
				
				hook.Remove("Think",hookName )
				print("Removed bot think", hookName )
				
				return
				
			end 
			
		end )
		
	end
	
end )


hook.Add("PlayerSpawn", "EquipBotsWithDanger", function( ply )
	
	ply.SpawnTime = CurTime()
	if( ply.SpawnKills && ply.SpawnKills < 5 ) then
		
		ply.LastHostileAction = 0
	
	end
	
	if( ply:IsBot() && GetConVarNumber("bot_drivetanks",0) > 0 ) then
		
		
		ply:SetArmor( 200 )
		ply:Give(guns[math.random(1,#guns)])
		-- ply:GiveAmmo( 9999, "XBowBolt", true )
		-- ply:GiveAmmo( 9999, "RPG_Round", true )
		
		-- local hoomans = player.GetHumans()
		-- local hooman = hoomans[math.random(1,#hoomans)]
		
		-- if ( IsValid( hooman )&& hooman:OnGround() && !IsValid( hooman:GetVehicle() ) ) then
		
			-- local tr,trace = {},{}
			-- tr.start = hooman:GetPos()
			-- tr.endpos = tr.start + Vector( 0,0,200 )
			-- tr.filter = { hooman, ply }
			-- tr.mask = MASK_SOLID
			-- trace = util.TraceLine( tr ) 
			
			-- if( !trace.Hit ) then
			
				-- ply:SetPos( hooman:GetPos() + Vector( 0,0,100 ) )
			
			-- end
			
		-- end
		
		
	end

end )

function BotThink()
	
	for k,v in pairs( player.GetBots() ) do	
	
		if( !IsValid( v:GetScriptedVehicle() ) && IsValid( v.Target ) ) then v.Target = NULL end
		
		if( !IsValid( v:GetScriptedVehicle() ) ) then
			
			for _,j in pairs( ents.FindInSphere( v:GetPos(), 9000 ) ) do
				
				if( IsValid( j ) && j.VehicleType && j.VehicleType == VEHICLE_TANK && !IsValid( j.Pilot ) && j.LastAmmoSwap ) then
					
					local pos = j:GetPos()
					local mp = v:GetPos()
					local a = ( pos - mp ):Angle()
					if( a.p > 180 ) then a.p = a.p - 360 end
					if( a.y < -180 ) then a.y = a.y + 360 end
					
					v:SetEyeAngles( a )
				
					if( v:OnGround() ) then
						
					
						v:SetVelocity( v:GetForward() * 185 )
							
						
					end
					
					if( mp:Distance( pos ) < 300 ) then
						
						j:Use( v, v, 1, 1 )
						
						break
						
					end
					
					break
						
				else
					
					if( v:IsPlayer() && v:Alive() && inLOS( v, j ) && v:GetPos():Distance( j:GetPos() ) > 200  ) then
						
						local pos = j:GetPos()
						local mp = v:GetShootPos()
						local a = ( pos - mp ):Angle()
						v:SetEyeAngles( LerpAngle( 0.2, bot:EyeAngles(), a )  )
						
						if( v:OnGround() ) then
					
							v:SetVelocity( v:GetForward() * 95 )
						
						end
						
					end
					
					
					
				end
			
			end

		else
								
			local tank = v:GetScriptedVehicle()
			local dist = 999999
			local shortest = NULL
			
			if( !IsValid( v.Target ) ) then
			
				for _, ply in pairs( ents.GetAll() ) do 
					
					if( ( ply:IsPlayer() || v:IsNPC() ) && ply != v && inLOS( v, ply ) &&  ply:GetPos():Distance( v:GetPos() ) < dist ) then
						
						if( ply:IsPlayer() && ply.SpawnTime && ply.SpawnTime + 10 <= NOW ) then
							
							dist = ply:GetPos():Distance( v:GetPos() )
							shortest = ply
						
						end
						-- else
							
							-- dist = ply:GetPos():Distance( v:GetPos() )
							-- shortest = ply
							
						-- end
						
					end
		
				end
				
				
				v.Target = shortest
				
				-- print( "found target" , shortest:Nick() )
				
		
				
				if( !IsValid( v.Target ) ) then

					local ft = util.TraceEntity( { start = tank:LocalToWorld( Vector( 250, 0, 50 ) ), endpos = tank:LocalToWorld( Vector( 300, 0, 70 ) ), filter = { v, tank, tank.Barrel, tank.Tower } , mask = MASK_SOLID }, tank )
					local lt = util.TraceEntity( { start = tank:LocalToWorld( Vector( 0, 100, 50 ) ), endpos = tank:LocalToWorld( Vector( 200, 250, 50 ) ), filter = { v, tank, tank.Barrel, tank.Tower } , mask = MASK_SOLID }, tank )
					local rt = util.TraceEntity( { start = tank:LocalToWorld( Vector( 0, -100, 50 ) ), endpos = tank:LocalToWorld( Vector( 200, -250, 50 ) ), filter = { v, tank, tank.Barrel, tank.Tower } , mask = MASK_SOLID}, tank  )
														
					if( lt.Hit ) then
					
						tank.Yaw = -0.45
						
						-- return
						
					elseif( rt.Hit ) then
						
						tank.Yaw = 0.45
						
						-- return
						
					elseif( !lt.Hit && !rt.Hit ) then
						
						tank.Yaw = 0
					
					end
					
					-- if( LastAction + 0.75 <= CurTime ) then return end 
					if( ft.Hit ) then
					
						LastAction = CurTime()
						-- tank.Speed = -20 * 14.58421379738968  * 15
						tank:TankDriveBackward()
							-- print( "WALLA" )
					elseif( !ft.Hit ) then
						
						-- print( "WALLA" )
						if( LastAction + 0.5 <= CurTime() ) then
						
							-- tank.Speed = 35 * 14.58421379738968 * 15
							tank:TankDriveForward()
						end
						
					end
	
						
				end
				
			else
				
				if( !inLOS( v, v.Target ) ) then v.Target = NULL return end
				if( !IsValid( v.Target ) ) then return end	
				if( !IsValid( tank ) ) then return end
				if( v.Target:IsPlayer() ) then
				
					local tartank = v.Target:GetScriptedVehicle()
					
				end
				
				local ply = v.Target
				local distance = tank:GetPos():Distance( ply:GetPos() )
				local MyAngle = tank:GetAngles()
				local DesiredAngle = ( ( v:GetPos() ) -  ply:GetPos() ):Angle()
				if( distance > 5000 ) then
					
					 DesiredAngle = ( ( ply:GetPos() + Vector( 0,0,distance / 55) ) -  v:GetPos() ):Angle()
					 
				end
				
				-- print( v.Target:GetClass() )
				local AngleDiff = tank:VecAngD( MyAngle.y, DesiredAngle.y )
				local IsBehind = AngleDiff < -145 || AngleDiff > 145
				local IsRight = AngleDiff > -145 && AngleDiff < -22
				local IsInFront = AngleDiff < 22 && AngleDiff > -22
				local IsLeft = AngleDiff < 145 && AngleDiff > 22

				
				local Tower = tank.Tower
				if( type( tank.Tower ) == "table" ) then 
					
					Tower = tank.Tower[1]
					
				end
				
				local Barrel = tank.Barrel
				if( type(Barrel) == "table" ) then
					
					Barrel = tank.Barrel[1]
					
				end
				
				v:SetEyeAngles( DesiredAngle + Angle( 0, -90, 0 ) )
				-- v:SetAngles( DesiredAngle )
				-- v:DrawLaserTracer( v:GetShootPos(), v:GetAimVector() * 2500 )
				
				
				
				local ta = ( tank:GetPos() - ply:GetPos() ):Angle()
				if( !IsValid( Tower ) ) then return end
				
				local t = Tower:GetAngles()
				local ma = tank:GetAngles()
				local TowerDiff = tank:VecAngD( t.y, DesiredAngle.y )
				
				ma:RotateAroundAxis( tank:GetUp(), tank:VecAngD( ta.y, ma.y ) - 180 )
				
				if( TowerDiff > 10 || TowerDiff < -10 ) then
				
					Tower:SetAngles( LerpAngle( 0.168, t, ma ) )
					
				else
				
					Tower:SetAngles( LerpAngle( 0.131, t, ma ) )
				
				end
				
				local maxang =DesiredAngle.p -- math.Clamp( DesiredAngle.p, t.p - 50, t.p + 10 )
				t = Tower:GetAngles()
				Barrel:SetAngles( LerpAngle( 0.45, Barrel:GetAngles(), Angle( maxang, t.y, t.r  ) ) )
			
				local TargetGotSmallTank = ( IsValid( tartank ) && tartank.VehicleType == VEHICLE_TANK && tartank.TankType <= tank.TankType )
				local TargetGotBigTank = ( IsValid( tartank ) && tartank.VehicleType == VEHICLE_TANK && tartank.TankType > tank.TankType )
				
				
				-- print( math.floor( TowerDiff ) )
				if( TowerDiff > -5 && TowerDiff < 5 && inLOS( tank, ply ) ) then
					
					if( distance > 500 && tank.BulletDelay + tank.PrimaryDelay <= CurTime() ) then
						
							tank.BulletDelay = CurTime() + tank.PrimaryDelay
							tank:TankPrimaryAttack()
							
					
					else

						if( !TargetGotSmallTank ) then
						
							if( IsValid( tank.MGun )  || IsValid( tank.BMGun ) ) then
							
								tank:TankSecondaryAttack( v )
							
							end
							
						end
						
					end
					
				end
				
				if( type(tank.AmmoTypes) == "table" && tank.LastAmmoSwap + 0.25 <= CurTime() ) then
					
					tank.LastAmmoSwap = CurTime()
					tank.AmmoIndex = tank.AmmoIndex + 1		
					
					if( tank.AmmoIndex > #tank.AmmoTypes || tank.AmmoIndex < 1 ) then
						
						tank.AmmoIndex = 1
						
					end
					
				end
				
				local maxdist = 100
				
				-- If our target is driving a smaller or equally sized tank then ram them.
				
				if( TargetGotSmallTank ) then
			
					maxdist = 12
					
				end
			
				if( distance > maxdist && distance < 15000 ) then
							
					if( IsInFront || IsBehind ) then

							if( IsInFront ) then
								
								tank.Yaw = 0
								if( distance < 700 ) then
									
									if( TargetGotSmallTank ) then
										
										-- tank.Speed = 5000 
										tank:TankDriveForward()
									else
										
										-- tank.Speed = -5000
										tank:TankDriveBackward()
									end
									
								else
								
									-- tank.Speed = 5000
									tank:TankDriveForward()
									
								end
								
							else
							
								-- tank.Speed = 400
								-- tank.Yaw = 1
								
							end
				
						-- print( tank.Speed )
						
					elseif( IsRight ) then
						
						tank.Yaw = math.Approach( tank.Yaw, 0.44, 0.092 )
						
					elseif( IsLeft ) then
						
						
						tank.Yaw = math.Approach( tank.Yaw, -0.44, 0.092 )
						
					end
					
				
				end
				
				tank:GetPhysicsObject():Wake()		
				
			end
			-- local p = player.GetAll()[1]
			-- local p1 = v:GetPos()
			
			-- v:SetEyeAngles( ( p:GetPos() - p1 ):Normalize():Angle() )
			
		end
		
		
	end
	
	-- print(" LEL ?" )
end

-- hook.Add("Think", "NeuroTankBotRecreateThink", function()
	
	-- if( !table.HasValue( hook.GetTable().Think, "NeuroTanksBotThink" ) ) then
		
		-- print( 
		-- hook.Add("Think","NeuroTanksBotThink",function()
				
			-- if( LastTick <= CurTime() ) then

				
				
				-- print("re-hooked bots")
				-- BotThinkNew()	
				-- LastTick = CurTime()+0.01
				

			-- end 
			
			
		-- end )

		-- end )
		-- print( "re-hooked think")
		
		-- return
		
	-- end

-- end )

print( "[NeuroTanks] neurotankbots.lua loaded!" )