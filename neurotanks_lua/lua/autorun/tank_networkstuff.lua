-- Example network usage for StarChick971 by Hoffo
if( SERVER ) then
	
	util.AddNetworkString( "NeuroTanks_mousePos" ) -- add the network string, needs to be on the server.

	local Meta = FindMetaTable("Player")

	function Meta:GetCursorWorldPos()
		-- update the pos for future use
		self:SendLua("SendMousePosToServer()")
		-- return last set value or 0 0 0
		return self.ClientVector or Vector(0,0,0)
	
	end

	function Meta:GetCursorClick()
		-- update the pos for future use
		self:SendLua("SendMouseClickToServer()")
		-- return last set value or 0 0 0
		if self.MouseClick == 1 then
			return true
		else
			return false
		end
	end	

end

-- Create the receive hook on the server. 
--This function will assign the ClientVector variable
net.Receive( "NeuroTanks_mousePos", function( len, pl )

	if ( IsValid( pl ) && pl:IsPlayer() ) then
		-- we create the variable ClientVector on 
		-- the player meta table so we can access it later.
		-- for example in ENT:TankTowerRotation() if we want to make the barrel
		-- aim at the vector we just sent to the server.
		local vec = net.ReadVector()
		-- local click = net.ReadBit()
		if( vec != Vector(0,0,0) ) then
		
			pl.ClientVector = vec
			
		else
		
			pl.ClientVector = nil
			
		end
		-- pl.MouseClick = click
		-- print( pl.MouseClick ) 
		
	end
end )
hook.Add("Think","NeuroTanksSmoothNWVars", function()
	
	-- for k,v in pairs( player.GetAll() ) do 
		
		-- if( v.ClientVector && v.LastVector ) then
		 
			-- v.ClientVector = LerpVector( 0.1, v.ClientVector, v.LastVector )
		
		-- end
		
	-- end
	
end ) 
-- Stop the server from initializing these functions.
if ( SERVER ) then return end

---- CLIENT CLIENT CLIENT CLIENT CLIENT ---
-- You send the mouse vector to the server by calling the function.
-- add this function somewhere in a file in autorun/client/
function SendMousePosToServer( pos ) 
	
	-- if( !pos ) then 
		
		-- pos = gui.ScreenToVector( gui.MouseX(), gui.MouseY() )
	-- local vector = gui.ScreenToVector( gui.MouseX( ), gui.MouseY( ) )
	-- local traceRes = util.QuickTrace( LocalPlayer():GetPos() + LocalPlayer():GetViewOffset(), vector * 36000 )
	
	-- end
	-- since this will be called from the person
	-- using the artillery camera we can just fetch
	-- the local player object.
	local ply = LocalPlayer()
	-- print( pos )
	-- Start the net message.
	net.Start( "NeuroTanks_mousePos" ) -- This must be the same as the NetworkString we add using util.AddNetworkString() on the server
		-- Use MouseX and MouseY and turn it to worldpos as example.
		net.WriteVector( pos ) 
		-- net.WriteBit( click )
	-- wrap it up.
	net.SendToServer()
	
end

print( "[NeuroTanks] tank_networkstuff.lua loaded!" )