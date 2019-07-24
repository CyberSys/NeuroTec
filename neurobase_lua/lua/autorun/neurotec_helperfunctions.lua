-- First introducted 11/04/2015 by Smithy285

 
getmetatable("").__add = function( self, txt )
	return self..txt 
end 
--[[---------------------------------------------------------------------------
CollatzConjecture & Circle - math2.lua
-----------------------------------------------------------------------------]]

amath = {}

function amath.CollatzConjecture( n ) 
	local num, rem = math.modf( n / 2 ) 
	local r 

	if ( rem == 0 ) then
		r = n / 2
	else 
		r = 3 * n + 1
	end 
	
	return r 
end

function amath.Circle( Pos, Width )
	Pos.x = Pos.x + math.cos( CurTime() ) * Width
	Pos.y = Pos.y + math.sin( CurTime() ) * Width
	
	return Pos
end

local pi_over_2 = math.pi / 2.0

function EaseInSine( amt, _end )
	
	return -1.0 * math.cos( amt  * pi_over_2 ) + 1.0

end 

function Tween( amt, start, _end )
	
	return start * ( amt * ( _end - start ) )

end 


--[[---------------------------------------------------------------------------
funcDerivate - math_derivative.lua
-----------------------------------------------------------------------------]]
// This can be used to get the derivative from a value.
local LastT = CurTime()
local LastA = 0

function funcDerivate( value ) 
	local A = value
	local D
	local t = CurTime()
	local dT = t - LastT
	LastT = t
	local dA = A - LastA
	LastA = A

	if ( dT != 0 ) then
		D = math.Round( dA / dT )
	else
		D = 0
	end

	return D
end

--[[---------------------------------------------------------------------------
Explode_Shake - explode_shake.lua
-----------------------------------------------------------------------------]]
function Explode_Shake()
	for _, ply in pairs( player.GetAll() ) do
		found = false
		for k, v in pairs( ents.GetAll() ) do
			if v:GetClass() == "env_explosion" or v:GetClass() == "env_physexplosion" then
				found = true
			end
		end

		if not found then ply.ShakeTime = nil end

		for k, v in pairs( ents.GetAll() ) do
			if ( v:GetClass() == "env_explosion" or v:GetClass() == "env_physexplosion" ) and ply:Alive() then
				if ply.ShakeTime then
					if ply.ShakeTime < ( CurTime() - 1 ) then
						v:Remove()
					end
				else
					ply.ShakeTime = CurTime()
				end

				if ply:GetPos():Distance( v:GetPos() ) <= 250 then
					ply:ViewPunch( Angle( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -10, 10 ) ) )
				elseif ply:GetPos():Distance( v:GetPos() ) <= 500 then
					ply:ViewPunch( Angle( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) )
				elseif ply:GetPos():Distance( v:GetPos() ) <= 750 then
					ply:ViewPunch( Angle( math.random( -1, 1 ), math.random( -1, 1 ), math.random( -1, 1 ) ) )
				end
			end
		end
	end
end
// hook.Add( "Think", "Explode_Shake_Think", Explode_Shake )

--[[---------------------------------------------------------------------------
Revision - !revision.lua
-----------------------------------------------------------------------------]]
function Revision()
	--[[
	return " v1337 gary D: broke mah revision script" end

	local __Files, __addons = file.Find("addons/*", "GAME" )

	if( !__addons ) then return "... WAIT!! Why the fuck did you delete your addon folder??" end
	PrintTable( __addons )

	local NeuroplanesFolderName = nil

	for k,v in pairs( __addons ) do
		if( string.find( string.lower(v), "neurobase" ) || string.find( string.lower(v), "nbase") ) then
			NeuroplanesFolderName = v
			print( v )
			break 	
		end
	end

	print( "FOLDER -",NeuroplanesFolderName)

	if( NeuroplanesFolderName ) then
		local svnfile = file.Read("addons/"..string.lower(NeuroplanesFolderName).."/.svn/wc.db", "GAME" )
		print( svnfile )
		if( !svnfile ) then return "Revision not found" end
		
		local idx1,idx2 = string.find( svnfile, "/svn/neurobase/!svn/rvr/" )
		local a,b = string.find( svnfile, "http://svn")
		return string.Replace( string.Replace( string.sub( svnfile, idx2, a ), string.char(10),""), "h", "" )
	end
	--]]

	return "Revision not found"
end


--[[---------------------------------------------------------------------------
COS, SIN, TAN, DrawHUDEllipse, DrawHUDRect & DrawHUDOutlineRect - misc_Functions.lua
-----------------------------------------------------------------------------]]
local Meta = FindMetaTable( "Entity" )

function COS( ang )
	return math.cos( ang )
end

function SIN( ang )
	return math.sin( ang )
end

function TAN( ang )
	return math.tan( ang )
end

if CLIENT then 

function DrawHUDEllipse( center, scale, color ) 
	// Draw an ellipse whatever the size of the HUD
	// center: a vector with 0 on z axis (ex: Vector( ScrW()/2,ScrH()/2, 0 )
	// scale : same as center. You can get a circle if x and y axis are equal
	// color : use Color(red,green,blue,alpha) values between 0-255.

	local segmentdist = 360 / ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
	surface.SetDrawColor( color )
	for i = 0, 360 - segmentdist, segmentdist do
		surface.DrawLine( center.x + math.cos( math.rad( i ) ) * scale.x, center.y - math.sin( math.rad( i ) ) * scale.y, center.x + math.cos( math.rad( i + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( i + segmentdist ) ) * scale.y )
	end
end


function DrawHUDLine( startpos, endpos, color )
	surface.SetDrawColor( color )
	surface.DrawLine( startpos.x, startpos.y, endpos.x, endpos.y  )
end

function DrawHUDRect( startpos, width, height, color )
	surface.SetDrawColor( color )
	surface.DrawRect( startpos.x, startpos.y, width, height )
end

function DrawHUDOutlineRect( startpos, width, height, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( startpos.x, startpos.y, width, height )
end

-- startang and endang are in degrees, 
-- radius is the total radius of the outside edge to the center.
function surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness)
	local triarc = {}
	-- local deg2rad = math.pi / 180
	
	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness
	
	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius,
			v=(oy-cy)/radius,
		})
	end
	
	
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius,
			v=(oy-cy)/radius,
		})
	end
	
	
	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end
	
		table.insert(triarc, {p1,p2,p3})
	end
	
	-- Return a table of triangles to draw.
	return triarc
	
end

function surface.DrawArc(arc)
	for k,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end

function draw.Arc(cx,cy,radius,thickness,startang,endang,roughness,color)
	draw.NoTexture()
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness))
end

end 

	
if SERVER then
	-- Created by Smithy285 16-Aug-2015
	-- ply = Player to send the message to
	-- msg_type = Int to indicate colour of message
	-- msg_text = String to send the client
	AddCSLuaFile()
	util.AddNetworkString( "neurotec_message" )

	function NeuroMessage( ply, msg_type, msg_text )
		if not IsValid( ply ) then
			print("[NeuroMessage] Invalid player")

			return
		end

		if not msg_type or msg_type < 0 or msg_type > 3 then
			print("[NeuroMessage] Invalid message type, defaulting to generic")

			msg_type = 1
		end 

		if not msg_text then
			print("[NeuroMessage] No text to send!")

			return
		end

		local msg_length = string.len( msg_text )

		if msg_length > 1024 then
			print("[NeuroMessage] Text to send is greater than 1024 characters")

			return
		end

		local msg_colours = {
			[1] = Color( 65, 131, 215 ), -- Generic ( Blue )
			[2] = Color( 46, 204, 113 ), -- Success ( Green )
			[3] = Color( 217, 30, 24 ), -- Warning ( Red )
		}

		net.Start( "neurotec_message" )
			net.WriteColor( msg_colours[msg_type] )
			net.WriteString( msg_text )
		net.Send( ply )
	end


	-- Created by Smithy285 16-Aug-2015
	-- ply = Player to play the sound on
	-- sound_path = Path to the sound to play

	util.AddNetworkString( "neurotec_directsound" )

	function NeuroDirectSound( ply, sound_path )
		if not IsValid( ply ) then
			print("[NeuroDirectSound] Invalid player")

			return
		end

		if not sound_path then
			print("[NeuroDirectSound] Invalid sound path")

			return	
		end

		net.Start( "neurotec_directsound" )
			net.WriteString( sound_path )
		net.Send( ply )
	end

elseif CLIENT then
	net.Receive( "neurotec_directsound", function( length )
		if not IsValid( LocalPlayer() ) then return end

		local sound_path = net.ReadString()

		surface.PlaySound( sound_path )
	end )
end

print( "[NeuroBase] neurotec_helperFunctions.lua loaded!" )