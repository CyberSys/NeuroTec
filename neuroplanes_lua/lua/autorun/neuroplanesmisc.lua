AddCSLuaFile( "NeuroPlanesMisc.lua" )
-- include( 'NeuroPlanesMisc.lua' ) -- DONT DO THIS


//createClientConVar("drone_X", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
//createClientConVar("drone_Y", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("drone_Z", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("drone_Yaw", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("drone_auto", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("target_X", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("target_Y", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("target_Z", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("target_Set", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )

CreateClientConVar("droneGPS_X", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("droneGPS_Y", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )
CreateClientConVar("droneGPS_Z", 0,  FCVAR_CLIENTCMD_CAN_EXECUTE )

//if CLIENT then return end

-- concommand.Add("drone_movement", function( ply, cmd, args ) 
	
	-- local drone = ply:GetNetworkedEntity( "Drone", NULL )
	-- if( IsValid( drone ) ) then
	
		-- drone:SetNetworkedVector( "PositionOrder", Vector(0,0,0) )

	-- end
	
-- end)
function DroneVars(ply,cmd,args) 
	-- for k,v in pairs(ents.FindByClass("sent_helidrone")) do
	
	local drone = ply:GetNetworkedEntity( "Drone", NULL )

	if( IsValid( drone ) ) then
			
	end
	
end	
concommand.Add("drone_vars",DroneVars)

function SendDroneOrders(ply,cmd,args) //move the drone instantly
	
	local x = args[1]
	local y = args[2]
	local z = args[3]
	local Yaw = args[4]
	local vec = Vector(x,y,z)

	local drone = ply:GetNetworkedEntity( "Drone", NULL )
	if( IsValid( drone ) ) then
		
		drone:SetNetworkedVector( "PositionOrder", vec )	
		drone:SetNetworkedVector( "TurnOrder", Vector(0,0,Yaw) )
		
	end

end
concommand.Add("drone_orders",SendDroneOrders)

function SendDronetToCoord(ply,cmd,args) //Send the drone to the coordinates in arguments.
	local x = args[1]
	local y = args[2]
	local z = args[3]
	local vec = Vector(x,y,z)
	local maxheight = 500
	
	local drone = ply:GetNetworkedEntity( "Drone", NULL )
	
	if( IsValid( drone ) ) then
		
		drone:SetNetworkedVector( "GPS_coords", vec )		
		
	end
-- //PrintTable(args)
end
concommand.Add("drone_sendto",SendDronetToCoord)

function StopDrone(ply,cmd,args) //Stop the drone.
	-- for k,v in pairs(ents.FindByClass("sent_helidrone")) do
	
	local drone = ply:GetNetworkedEntity( "Drone", NULL )
	
	if( IsValid( drone ) ) then
			
		local pos = drone:GetPos()
		drone:SetNetworkedVector( "GPS_coords", pos )	
		drone:SetNetworkedVector( "PositionOrder", Vector(0,0,0) )	
		drone:SetNetworkedVector( "TurnOrder", Vector(0,0,0) )
		
	end
	
end	
concommand.Add("drone_stop",StopDrone)

function DroneStream( pl, handler, id, encoded, decoded )
 
	-- print( "Received data on server" );
	-- print( "\n Player: " .. pl:Name() );
	-- print( "\n Handler: " .. handler );
	-- print( "\n ID: " .. id );
//	print( "\n GLON Encoded: " .. encoded );
//	print( "\n Original:" );
--	PrintTable( decoded );
	local pos = decoded[1]
	local ang = Vector(0,0,0)
	if (decoded[2] !=nil) then
	ang = decoded[2]
	end
	RunConsoleCommand( "drone_orders",pos.x,pos.y,pos.z,ang.z)
end
-- datastream.Hook( "SendDroneStream", DroneStream );

function TargetStream( pl, handler, id, encoded, decoded )
 
	-- print( "Received data on server" );
	-- print( " Player: " .. pl:Name() );
	-- print( " Handler: " .. handler );
	-- print( " ID: " .. id );
//	print( " GLON Encoded: " .. encoded );
//	print( " Original:" );
--	PrintTable( decoded );
	local pos = decoded[1]
	
	if IsValid(pl.RedDot) then
	pl.RedDot:Remove()
	end
	pl.RedDot = ents.Create( "env_sprite" )
	-- pl.RedDot:SetParent( self )	
	pl.RedDot:SetPos( pos  )
	-- pl.RedDot:SetAngles( self:GetAngles() )
	pl.RedDot:SetKeyValue( "spawnflags", 1 )
	pl.RedDot:SetKeyValue( "renderfx", 0 )
	pl.RedDot:SetKeyValue( "scale", 0.1 )
	pl.RedDot:SetKeyValue( "rendermode", 9 )
	pl.RedDot:SetKeyValue( "HDRColorScale", .75 )
	pl.RedDot:SetKeyValue( "GlowProxySize", 2 )
	pl.RedDot:SetKeyValue( "model", "sprites/redglow3.vmt" )
	pl.RedDot:SetKeyValue( "framerate", "10.0" )
	pl.RedDot:SetKeyValue( "rendercolor", " 255 0 0" )
	pl.RedDot:SetKeyValue( "renderamt", 255 )
	pl.RedDot:Spawn()

	local drone = pl:GetNetworkedEntity( "Drone", NULL )
	pl:SetNetworkedEntity( "Target",pl.RedDot )
end
-- datastream.Hook( "SendTargetStream", TargetStream );

print( "[NeuroPlanes] NeuroPlanesMisc.lua loaded!" )