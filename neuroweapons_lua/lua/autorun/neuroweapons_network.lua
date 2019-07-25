local Flashbang = {}
Flashbang.Duration = 5 


if SERVER then 
	
	AddCSLuaFile()
	
	util.AddNetworkString( "NeuroWeapons_flashbang" )

	local pMeta = FindMetaTable("Player")

	function pMeta:SendFlashbangHit( delta )
		
		net.Start("NeuroWeapons_flashbang")
			net.WriteFloat( delta )
		net.Send( self )
		

	end 

end 

if CLIENT then 

	net.Receive( "NeuroWeapons_flashbang", function( p, len )
		local ply = LocalPlayer()
		ply.FlashbangInitiated = CurTime()
		ply.FlashbangDelta = net.ReadFloat()
		-- print("Received Flashbang Hit:", ply, ply.FlashbangDelta )
		
	end )
	
	hook.Add("DrawOverlay", "NeuroWeapons_flashbangDraw", function() 
		local p = LocalPlayer()
		if( !p.FlashbangInitiated ) then return end 
		local timePassed =  CurTime() - p.FlashbangInitiated
		local delta =  math.Clamp( p.FlashbangDelta, .1, 1 )
		local opacity = math.Clamp( 255 - ( ( 255 * timePassed ) / ( Flashbang.Duration * delta ) ), 0, 255 )
		if( timePassed < Flashbang.Duration * delta ) then 
			
			DrawMotionBlur( opacity/255, .55 * 2.5/timePassed , .1 ) 
			draw.RoundedBox( 0, 0,0, ScrW(), ScrH(), Color( 255,255,255, opacity ) )
		
		end 
	
	end ) 
	
end 
print("NeuroWeapons Net Functions loaded!")
