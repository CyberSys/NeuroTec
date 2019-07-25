if true then return end 
AddCSLuaFile( )
-- this is not a good solution.
local Nicknames = {
"goose",
"Aftokinito",
"StarChick971",
"garry :D",
"batman",
"acecool",
"josh",
"elim",
"black tea za robot",
"myg0t",
"Hoffa D:",
"broneh",
"mingebag",
"minge",
"dav0r",
"conna",
"jani",
"sara",
"Angelina hoelie",
"Hoffdozer",
"xX[MLG]Xxn0sc0pe - K1LL3R",
"-:[4C3]:- p1l0t",
"Icetank",
"Distilled Potatos",
"ZooK33ne",
"William of the Hill",
"MaxOfSTD",
"Robotboy655",
"Deadpool"
}

local botNames = {}

if( SERVER ) then
	
	util.AddNetworkString( "NeurotecBotNames" ) // the name of the net message must be networked before we can send it!

	function SentBotNameTable()      
		
		-- table.sort( botNames )
		net.Start( "NeurotecBotNames" )          --// start writing the net message
			net.WriteTable( botNames )
		net.Broadcast()                  		--// send the message to all connected players
	
	end
	   
end

local pMeta = FindMetaTable("Player")
if( !__nt_pl_oldNick ) then __nt_pl_oldNick = pMeta.Nick end -- god i hate this. Dont do this kids its bad mkay
-- rerouting default functions is like doing drugs.. It's bad unless its good drugs, then its alllright.

function pMeta:Nick()
	
	-- if( !LocalPlayer().ReceivedBotNames ) then return __nt_pl_oldNick( self ) end 
	
	if( self:IsBot() ) then
		
		if( !self.NickName ) then
			
			for k,v in pairs( botNames ) do
				
				if( string.lower(v[1]) == string.lower( __nt_pl_oldNick( self ) ) ) then
				
					self.NickName = v[2] -- 
					
					break
					
				end
				
			end
	
		end
		
		return self.NickName
		
	else 
		
		return __nt_pl_oldNick( self )
		
	end
	
end	
function pMeta:Name() return self:Nick() end 
function pMeta:GetName() return self:Nick() end 

if( CLIENT ) then

    net.Receive( "NeurotecBotNames", function( len )

		local ply = LocalPlayer()
		
		ply.ReceivedBotNames = true
       -- PrintTable( net.ReadTable() )   
	   botNames = net.ReadTable()
	   
	   
     
    end ) 
   

end
  

if( SERVER ) then

	hook.Add("PlayerInitialSpawn","SpawnBots", function( ply )
		
		-- if( !ply:IsBot() ) then
		
			-- local plys = player.GetAll()
			-- local bots = player.GetBots()
			
			-- if( #bots < 1 && #plys < 1 ) then
				
				-- for i=1,#math.random( 2,4 ) do
				
					-- game.ConsoleCommand("bot")
			
				-- end
				
			-- end
				
		-- else
			
			
			
		local index = math.random(1,#Nicknames)
		ply.NickName = Nicknames[index]
	
		table.insert( botNames, { __nt_pl_oldNick( ply ), ply.NickName  } )
		table.remove( Nicknames, index )
		
		SentBotNameTable()
		
		-- end

	end ) 
	
end

print( "NeuroTec bot extras loaded!")

print( "[NeuroTanks] botnames.lua loaded!" )