if SERVER then
	CreateConVar( "neuro_parachute", 1, false, false )

	local function Falling( ply )
		local tr, trace = {}, {}
		tr.start = ply:GetPos()
		tr.endpos = tr.start + Vector( 0, 0, -10 )
		tr.filter = ply
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
		
		return trace.Hit
	end

	hook.Add( "Think", "NeuroTec_parachutethink", function()
		if ( GetConVarNumber( "neuro_parachute" ) == 0 ) then return end

		for k, v in ipairs( player.GetAll() ) do

			if ( v:Alive() ) then

				if ( !Falling( v ) ) then

					if( !v.FreeFallTimer ) then
						v.FreeFallTimer = 0
					end
					
					v.FreeFallTimer = v.FreeFallTimer + 1

				else

					v.FreeFallTimer = 0

				end

				if ( IsValid( v.ChuteObj ) ) then
					
					local tr, trace = {}, {}
					tr.start = v.ChuteObj:GetPos()
					tr.endpos = tr.start + Vector( 0, 0, -155 )
					tr.filter = { v, v.ChuteObj }
					tr.mask = MASK_SOLID
					trace = util.TraceLine( tr )

					local pos = v.ChuteObj:GetPos()
					
					if ( !v.ChuteObj.Destroyed and ( trace.Hit or v:WaterLevel() > 0 or IsValid( v:GetVehicle() ) or IsValid( v:GetScriptedVehicle() ) or v:GetMoveType() == MOVETYPE_NOCLIP ) ) then
						v.ChuteObj.Destroyed = true
						v.ChuteObj:SetParent()
						v.ChuteObj:SetSolid( SOLID_VPHYSICS )
						v.ChuteObj:GetPhysicsObject():EnableGravity( false )
						v.ChuteObj:SetGravity( -1 )
						v.HasChute = false
						v.ChuteObj:SetNetworkedBool( "drop", true )
						v:SetGravity( 1 )

						timer.Simple( 0, function()
							if ( IsValid( v ) ) then
								v:SetGravity( 1 )
							end
						end )

						v.ChuteObj:GetPhysicsObject():ApplyForceCenter( Vector( 0, 0, 101500 ) + VectorRand() * 500 )
						v.ChuteObj:SetPos( pos )
						v.ChuteObj:Fire( "kill", "", 5 )
						v.ChuteObj:EmitSound( "doors/door_chainlink_close1.wav", 511, 155 )

					else
						
						if ( v.ChuteObj.Destroyed ) then
							
							v:SetGravity( 0 )
							
						else

							v:GetPhysicsObject():ApplyForceCenter( VectorRand() * 500 )
							v:SetGravity( 0.122 )

							if ( v:GetVelocity():Length() > 300 ) then
								
								v:SetVelocity( v:GetVelocity() * -0.01 )
							end
						end
					end
				else
					if ( v:WaterLevel() == 0 and v:GetVelocity():Length() > 200 and !IsValid( v:GetVehicle() ) and !IsValid( v:GetScriptedVehicle() ) and v:GetVelocity().z <= 0 and v.FreeFallTimer > 100 and v:KeyDown( IN_JUMP ) and v:GetMoveType() != MOVETYPE_NOCLIP ) then

						v.ChuteObj = ents.Create( "sent_neuro_parachute" )
						--v.ChuteObj:SetAngles( v:GetAngles() )
						v.ChuteObj:SetPos( v:LocalToWorld( Vector( 0, 0, 80 ) ) )
						v.ChuteObj:SetParent( v, 4 )
						v.ChuteObj:SetMoveType( MOVETYPE_NONE )
						v.ChuteObj:SetOwner( v )
						v.ChuteObj.Owner = v
						v.ChuteObj:Spawn()
						v.ChuteObj:SetNetworkedEntity( "Idiot", v )
						v.HasChute = true
						v:SetVelocity( v:GetVelocity() * -0.15 + Vector( 0, 0, 150 ) )
						v:EmitSound( "ambient/wind/wind_hit1.wav", 511, math.random( 100, 110 ) )
						v.ChuteObj:EmitSound( "ambient/wind/windgust.wav", 50, math.random( 90, 100 ) )
					end
				end
			else
				v.FreeFallTimer = 0
			end
		end
	end )
end

print( "[NeuroBase] neurotec_parachute.lua loaded!" )