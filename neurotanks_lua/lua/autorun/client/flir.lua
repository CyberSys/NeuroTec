local mat = Material( "models/debug/debugwhite" )
local noisemat = Material( "effects/tvscreen_noise003a" )
-- doFLIR = false


function NeuroFLIR() 
	
	local ply = LocalPlayer()
	local tank = ply:GetScriptedVehicle()
	local cview = GetConVarNumber("jet_cockpitview")>0 
	if( !IsValid( tank ) ) then return end

	local atgm = tank:GetNetworkedEntity("ATGM_projectile",NULL)
	local guided = tank:GetNetworkedEntity("NeuroPlanes_LaserGuided", NULL )
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)

	local WeaponThermal = ( ( IsValid( atgm ) && IsValid( barrel ) ) || IsValid( guided ) )
		
	
	if( ( ply.doFLIR && tank.HasFLIR && cview ) || WeaponThermal ) then
		
		if( IsValid( atgm ) && IsValid( barrel ) && !inLOS( barrel, atgm ) ) then return end
		
		DrawMaterialOverlay( "effects/tvscreen_noise003a", 0.11 )	
		
		if( IsValid( atgm ) && !inLOS( tank, atgm ) ) then
			
			-- DrawMaterialOverlay( "effects/tvscreen_noise003a", 1 )	
			-- DrawMaterialOverlay( "effects/tvscreen_noise003a", 1 )	
			-- DrawMaterialOverlay( "effects/tvscreen_noise003a", 1 )	
			-- DrawMaterialOverlay( "effects/tvscreen_noise003a", 1 )	
			-- DrawMaterialOverlay( "effects/tvscreen_noise003a", 1 )	
		
		end
		
		cam.Start3D( EyePos(), EyeAngles() )

		render.MaterialOverride( mat )
		
		for k,v in pairs( ents.GetAll() ) do 
			
			if( v:IsOnFire() || v:GetClass() == "env_fire" ) then
			
				render.SuppressEngineLighting( true )
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				v:DrawModel()
				render.SuppressEngineLighting( true )
				
			end
			
			if ( v:IsPlayer() && v:Alive() && !IsValid( v:GetDrivingEntity() ) && !v.ColdBlooded ) then
				
				render.SuppressEngineLighting( true )
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				v:DrawModel()
				render.SuppressEngineLighting( false )
				
			end
			
			
			local parent = v:GetParent()
			local started = v:GetNetworkedBool("IsStarted",false)
			if(  ( IsValid( parent ) && v:GetParent().TankType && parent:GetNetworkedBool("IsStarted",false) ) || 
			( IsValid( parent ) && IsValid( parent:GetParent() ) && parent:GetParent().TankType && parent:GetParent():GetNetworkedBool("IsStarted",false) )
			|| v.TankType &&  started ) then
				

				render.SuppressEngineLighting( true )
				render.SetColorModulation( 1, .2141, .21 )
				render.SetBlend( 1 )
				v:DrawModel()
				render.SuppressEngineLighting( false )
				
			end
				
			
			if( v:IsNPC() ) then
				
				render.SuppressEngineLighting(true)
				render.SetColorModulation( .7, .7, .7 )
				render.SetBlend( 1 )
				v:DrawModel()
				render.SuppressEngineLighting(false)

			end
			
			if( v:IsVehicle() ) then
			
				render.SuppressEngineLighting(true)
				render.SetColorModulation( .15, .15, .15 )
				render.SetBlend( 1 )
				v:DrawModel()
				render.SuppressEngineLighting(false)
				
			end
			
		end
		
		render.MaterialOverride( nil )
		cam.End3D()
				
		local col = {}
		col[ "$pp_colour_addr" ] = 0
		col[ "$pp_colour_addg" ] = 0
		col[ "$pp_colour_addb" ] = 0
		col[ "$pp_colour_brightness" ] = 0
		col[ "$pp_colour_contrast" ] = 0.8
		col[ "$pp_colour_colour" ] = 0
		col[ "$pp_colour_mulr" ] = 0
		col[ "$pp_colour_mulg" ] = 0
		col[ "$pp_colour_mulb" ] = 0

		DrawColorModify( col )
		DrawMotionBlur( 0.59, 1, 0 )
		DrawSharpen( 0.5 + 2 / ( 1 + math.exp( math.sin( CurTime() * 1000 ) ) ) / 3, 1 )
		
	end
	
end 

hook.Add("RenderScreenspaceEffects", "NeuroTec_FLIR", NeuroFLIR  )

print( "[NeuroTanks] flir.lua loaded!" )