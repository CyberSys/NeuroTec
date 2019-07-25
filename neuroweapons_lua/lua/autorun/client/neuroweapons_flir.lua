
local function drawIRstuff()
	
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if( IsValid( wep ) && wep.GetIronsights && wep:GetIronsights() && wep:GetClass() == "weapon_neurowep_javelin" && ply:FlashlightIsOn() ) then 
	-- if( !ply:GetNWBool("NeuroWeps_flIR" ) ) then return end 
		
		DrawMaterialOverlay( "effects/tvscreen_noise002a", 0.11 )	
		
		cam.Start3D( EyePos(), EyeAngles() )

			render.MaterialOverride( "models/debug/debugwhite" )
		
			for k,v in pairs( player.GetAll() ) do 
				
				if ( v:Alive() ) then
					local oldMat = v:GetMaterial()
					render.SuppressEngineLighting( true )
					render.SetBlend( 1 )
					render.SetColorModulation( .1,0,0 )
					v:SetMaterial( "models/debug/debugwhite" )
					v:DrawModel()
					v:SetMaterial( oldMat )
					render.SuppressEngineLighting(false)
				end
			
			end
			
			for k,v in pairs( ents.GetAll() ) do
			
				if( v:IsNPC()  ) then
					
					render.SuppressEngineLighting(true)
					render.SetColorModulation( 0,0,0 )
					render.SetBlend( 1 )
					-- v:SetMaterial( "models/debug/debugwhite" )
					v:DrawModel()
					render.SuppressEngineLighting(false)

				end
			
				if( v:IsVehicle() && !IsValid( v:GetParent() ) ) then
					
					render.SuppressEngineLighting(true)
					render.SetColorModulation( .15,0.15,0.15 )
					render.SetBlend( 1 )
					v:SetMaterial( "models/debug/debugwhite" )
					v:DrawModel()
					render.SuppressEngineLighting(false)
					-- render.SetBlend( 0 )
					
				end
				
			end
			
			-- render.Clear(1,1,1,1,1,true )
			render.MaterialOverride( nil )
		cam.End3D()
					
					
		local col = {}
		col[ "$pp_colour_addr" ] = 0
		col[ "$pp_colour_addg" ] = 0
		col[ "$pp_colour_addb" ] = 0
		col[ "$pp_colour_brightness" ] = .7
		col[ "$pp_colour_contrast" ] = 0.8
		col[ "$pp_colour_colour" ] = 0
		col[ "$pp_colour_mulr" ] = 0
		col[ "$pp_colour_mulg" ] = 0
		col[ "$pp_colour_mulb" ] = 0

		DrawColorModify( col )
		DrawSharpen( 0.5 + 2 / ( 1 + math.exp( math.sin( CurTime() * 1000 ) ) ) / 3, 1 )
		DrawMotionBlur( .1, .1,0.1 )
		-- DrawSobel( math.Rand(0,0.01), math.Rand(0.7,1.01) )
		DrawSharpen( math.Rand(.1,.25), 4200 )
		
		-- local dlight = DynamicLight( wep:EntIndex() )
		-- if ( dlight ) then
			-- dlight.pos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 100
			-- dlight.r = 255
			-- dlight.g = 255
			-- dlight.b = 255
			-- dlight.brightness = 1
			-- dlight.Decay = FrameTime()
			-- dlight.Size = 36000
			-- dlight.DieTime = CurTime() + 1
		-- end
	else
	
							
		-- local col = {}
		-- col[ "$pp_colour_addr" ] = 1
		-- col[ "$pp_colour_addg" ] = 1
		-- col[ "$pp_colour_addb" ] = 1
		-- col[ "$pp_colour_brightness" ] = 1
		-- col[ "$pp_colour_contrast" ] = 0
		-- col[ "$pp_colour_colour" ] = 0
		-- col[ "$pp_colour_mulr" ] = 1
		-- col[ "$pp_colour_mulg" ] = 1
		-- col[ "$pp_colour_mulb" ] = 1

		-- DrawColorModify( col )
	
	end 
	
end
hook.Add("RenderScreenspaceEffects", "NeuroWeapons_InfraRed", function()

	drawIRstuff()
	
end ) 