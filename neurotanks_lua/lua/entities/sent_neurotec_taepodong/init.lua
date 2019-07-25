
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 150
ENT.Destroyed = false
-- CreateConVar("tank_lesslag", 0, FCVAR_NOTIFY  )
-- CreateConVar("nuke_max_particles", 25, FCVAR_NOTIFY  )

function ENT:SpawnFunction( ply, tr)
	
	if( !ply:IsAdmin() ) then
		
		return NULL
		
	end
	
	if( !IsValid( ply.NeuroNuke ) ) then
	
		local SpawnPos = tr.HitPos + tr.HitNormal * 40
		local vec = ply:GetAimVector():Angle()
		local newAng = Angle(0,vec.y,0)
		local ent = ents.Create( "sent_neurotec_taepodong" )  
		ent:SetPos( SpawnPos )
		ent:SetAngles( newAng )
		ent:Spawn()
		ent:Activate()
		ent:GetPhysicsObject():Wake()
		ent.Owner = ply
		
		ply.NeuroNuke = ent
		
		return ent
		
	else
		
		ply:PrintMessage( HUD_PRINTCENTER, "Only a mingebag need two nukes." )
	
	end
	
	return NULL

end

function ENT:Initialize()
	
			
	self:SetModel( "models/military2/missile/missile_taepodong.mdl"  )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.Nuked = false
	self:SetUseType( SIMPLE_USE )
	self.Speed = 0
	
	
	local prop = ents.Create("prop_physics")
	prop:SetPos( self:LocalToWorld( Vector( -493, 0, 0  ) ) )
	prop:SetAngles( self:GetAngles() )
	prop:SetModel( "models/gibs/HGIBS.mdl" )
	prop:Spawn()
	prop:SetParent( self )
	ParticleEffectAttach( "propellant_smoke_blast", PATTAch_aBSORIGIN, prop, 0 )
	ParticleEffectAttach( "propellant_large_main", PATTAch_aBSORIGIN, prop, 0 )
	-- nitro_main
	-- ParticleEffect("propellant_large_main", self:GetPos() + self:GetUp() * 1, Angle(0,0,0), nil )
	if( self.NeuroAdminOnly ) then
		
		if( IsValid( self.Owner ) && !self.Owner:IsAdmin() ) then
			
				
			self.Owner:PrintMessage( HUD_PRINTCENTER, "You are not allowed to spawn this." )
			self:Remove()
			
		end
	
	
	end
	
end

local function DelayedSound( _time, ent, _sound )
	
	timer.Simple( _time, function() 
		if( IsValid( ent ) ) then
			
			ent:EmitSound( _sound, 511, 100 )
			
		end
		
	end )
	
end

function ENT:Use( ply, ent )
	
	if( !self.Started ) then
		
		self.Owner = ply
		self.Started = true
		self:SetNetworkedBool("Launched",true )
	
		self:EmitSound( "buttons/button2.wav", 511, 100 )
		DelayedSound( 1, self, "doors/doormove2.wav" )
		-- DelayedSound( 11, self, "doors/doormove2.wav" )
		DelayedSound( 13, self, "doors/doormove2.wav" )
		DelayedSound( 13.5, self, "doors/doormove2.wav" )
		DelayedSound( 14, self, "doors/doormove2.wav" )
		DelayedSound( 14.5, self, "doors/doormove2.wav" )
		timer.Simple( 15, function() if( IsValid( self ) ) then self:DoExplosion() end end )
		
		self.ESound = CreateSound( self, "weapons/missileengine.mp3" )
		self.ESound:Play()
		
	end
	

end

function ENT:OnRemove()

	if( self.ESound ) then

		self.ESound:Stop()
		
	end

end

function ENT:Think()
	
	if( self.Started ) then
		
		self.ESound:ChangePitch( 0.1, 100 )
		
		local tr,trace = {},{}
		tr.start = self:LocalToWorld( Vector( -176, 0, 10 ) )
		tr.endpos = tr.start + self:GetForward() * -128
		tr.filter = self 
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
		
		if( trace.Hit && IsValid( trace.Entity ) ) then
			
			util.BlastDamage( self, self.Owner, trace.HitPos, 0.25, 16 )
			trace.Entity:Ignite( 5, 35 )
			
		end
		
		debugoverlay.Line( tr.start, tr.endpos, 0.1, Color( 255, 0, 0, 0 ), true )
		
		self.Speed = self.Speed + 27000
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed )
	
	end
	
	if( self.Nuked ) then
		
		util.BlastDamage( self, self.Owner, self:GetPos() + Vector( math.random(-512,512), math.random(-512,512), 5500 ), 7500, math.random( 10, 100 ))
	
	end
	
end

local charcoal = { "models/humans/charple01.mdl", "models/humans/charple02.mdl", "models/humans/charple03.mdl", "models/humans/charple04.mdl" }

function ENT:DealNuclearDamage( Damage, Pos, Radius, DoEffect, Effect, Attacker )

	local info = DamageInfo( )  
		info:SetDamageType( DMG_RADIATION )  
		info:SetDamagePosition( Pos )  
		info:SetMaxDamage( Damage * 1.5 )  
		info:SetDamage( Damage )  
		info:SetAttacker( Attacker )  
		info:SetInflictor( self )  
	
	if( DoEffect ) then
	
		local e = EffectData()
			e:SetOrigin( Pos ) 
			e:SetScale( 0.1 )
		util.Effect( Effect, e )
		
	end
	
	local propcount = 0
	local maxeffects = GetConVarNumber("nuke_max_particles", 0 ) 
	
	for k, v in ipairs( ents.GetAll( ) ) do  
		
		local logic1 = ( string.find(v:GetClass(), "prop" ) || v:IsVehicle() || v.HealthVal )
		
		if ( v && IsValid( v ) && ( v:IsNPC() || v:IsPlayer() || logic1 ) ) then  
			
			-- print( v:GetClass() )
			
			local p = v:GetPos( ) 
			
			if ( p:Distance( Pos ) <= Radius ) then  
			
				constraint.RemoveAll( v )
				
				local vphys = v:GetPhysicsObject()
				
				if( IsValid( vphys ) ) then
					
					vphys:EnableMotion( true )
					vphys:EnableGravity( true )
					vphys:Wake()
					
				end
					
				propcount = propcount + 1
				
				-- print( v, "wihtin range ", Radius )
				
				local t,tr = {},{}
				t.start = Pos
				t.endpos = p
				t.mask = MASK_SOLID
				t.filter = { self, self.Owner }
				tr = util.TraceLine( t )
				
				if ( tr.Hit && tr.Entity ) then
					
				
					
					v:Ignite( math.random(5,10), 128 )
					local Amount =  Damage * ( 1 - p:Distance( Pos ) / Radius )
					
					info:SetDamage( Amount )  
					info:SetDamageForce( ( p - Pos ):GetNormalized( ) * 10 )  
					v:TakeDamageInfo( info )  
					
					-- print( Amount, v:Health() )
					if( Amount > 1000 && !v.NukeDust ) then
							
						v.NukeDust = true
						
						if( v:IsNPC() || v:IsPlayer() ) then
							
							-- local vpos = v:GetPos()
							-- local vang = v:GetAngles()
												
							-- if( v:IsPlayer() && v:Alive() ) then
								
								
								-- local rag = v:GetRagdollEntity()
								
								-- if( IsValid( rag ) ) then
									
									-- rag:Remove()
									
								-- end
								
							-- elseif( v:IsNPC() ) then
								
								-- v:Remove()
							
							-- end
							
							-- local charple = ents.Create("prop_ragdoll")
							-- charple:SetPos( vpos )
							-- charple:SetModel( charcoal[math.random(1,#charcoal)] )
							-- charple:SetAngles( vang )
							-- charple:Spawn()
							-- charple:Fire("kill","",10)
								
							ParticleEffect( "nuke_player_vaporize", v:GetPos(), ( self:GetPos() - v:GetPos() ):Angle(), nil )
							
						elseif( logic1 ) then
							
							if( propcount < maxeffects ) then
							
								ParticleEffect( "nuke_prop_impact", v:GetPos(), ( self:GetPos() - v:GetPos() ):Angle(), nil )
								-- ParticleEffect( "nuke_prop_vaporize", v:GetPos(), ( self:GetPos() - v:GetPos() ):Angle(), nil )
								
							end
							
							v:SetColor( Color( math.random(45,55),math.random(45,55),math.random(45,55),255 ) )
							-- v:Fire("kill","",1)
					
							
						end
						
					end
					
				end
				
			end 
			
		end  

	end  
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( self.Nuked ) then return end
	if( data.DeltaTime < 0.2 ) then return end
	if( data.Speed < 500 ) then return end
	
	if ( !self.Owner || !IsValid( self.Owner ) ) then		
		self.Owner = self		
	end
	
	self:DoExplosion()
		
end

function ENT:DoExplosion()
	
	if( self.Nuked ) then return end
	
	if( !IsValid( self.Owner ) ) then self.Owner = self end

	self:EmitSound( "ambient/explosions/exp2.wav", 512, 100 )
	util.BlastDamage( self, self.Owner, self:GetPos(), 3512, math.random( 155000, 525000 ))
	self:DealNuclearDamage( math.random( 122000, 165000 ), self:GetPos(), 4500, false, "", self.Owner )
	
	local shake = ents.Create( "env_shake" )
	shake:SetPos( self:GetPos() )
	shake:SetOwner( self )
	shake:SetKeyValue( "amplitude", "10" )
	shake:SetKeyValue( "radius", "25000" )
	shake:SetKeyValue( "duration", "6" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", "", 10 )
	
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode(RENDERMODE_TRANSALPHA) 
	self:SetMoveType( MOVETYPE_NONE )
	
	local fx = "lowyield_nuke_ground_main"
	
	local hitcount = 0
	for j=1,20 do
		
		local tr,trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = tr.start + Vector( math.random( -1028, 1028 ), math.random( -1028, 1028 ), math.random(-512,512) )
		tr.filter = { self, self.Owner }
		tr.mask = MASK_WORLD
		trace = util.TraceLine( tr ) 
		
		if( trace.Hit && !trace.HitSky ) then
		
			hitcount = hitcount + 1 
		
		end
		
		-- print( hitcount ) 

	end
	
	-- local extra = 0
	
	if( hitcount < 2 ) then
		
		fx = "lowyield_nuke_air_main"

		
	end

	ParticleEffect( fx, self:GetPos(), Angle( 0,0,0 ), nil )
		
	local tr2,trace2 = {},{}
	tr2.start = self:GetPos() + Vector( 0,0,-10 )
	tr2.endpos = self:GetPos() + Vector( 0,0,-15500 )
	tr2.filter = { self, self.Owner }
	trace2 = util.TraceLine( tr2 )
	
	if( trace2.Hit ) then
		
		timer.Simple( 1.0 - trace2.Fraction, 
		-- extra = 1
		function() 
		
			if(IsValid( self ) ) then
	
				ParticleEffect( "bignuke_groundwave", trace2.HitPos, Angle( 0,0,0 ), nil )
				
			end
			
		end )
		
	end
	

	self.Nuked = true
		
	local fallout = ents.Create( "sent_nuke_fallout" )
	fallout:SetPos( self:GetPos() )
	fallout:SetAngles( self:GetAngles() )
	fallout:Spawn()
	fallout.Owner = self.Owner
	fallout:Fire("kill","",30)
	local pos = self:GetPos()
	
	for k,v in pairs( player.GetAll() ) do
	
		v:EmitSound( "ambient/atmosphere/thunder"..math.random(1,2)..".wav", 511, 100 )
		v.Ambience = CreateSound( v, "ambient/atmosphere/cave_outdoor1.wav" )
		v.Ambience:Play()
		timer.Simple( 15, function() if( IsValid( v ) ) then v.Ambience:FadeOut(15) end end ) -- when the rumble stops the fallout clears  
		
	end
	

	for i=1,25 do
		
		timer.Simple( i/6, function() 
			
			if( IsValid( self ) ) then
				
				self:DealNuclearDamage( math.random( 1122000, 1165000 ) - ( ( 26 - i ) * 2000 ), self:GetPos() + Vector( 0, 0, i*256), i*1400, false, "", self.Owner )
				util.BlastDamage( self, self.Owner, pos+Vector(0,0,i*200), i*1400, math.random( 25000, 52500 ))
				
				if( GetConVarNumber("tank_lesslag", 0 ) == 0 ) then
				
					local physExplo = ents.Create( "env_physexplosion" )
					physExplo:SetOwner( self.Owner )
					physExplo:SetPos( self:GetPos() )
					physExplo:SetKeyValue( "Magnitude", "25000000" )	-- Power of the Physicsexplosion
					physExplo:SetKeyValue( "radius", tostring( i * 1012 ) )	-- Radius of the explosion
					physExplo:SetKeyValue( "spawnflags", "19" )
					physExplo:Spawn()
					physExplo:Fire( "Explode", "", 0.01 )
					
				end
				
				if( i == 25 ) then
				
					self:Fire("kill","",2)
					
					local physExplo = ents.Create( "env_physexplosion" )
					physExplo:SetOwner( self.Owner )
					physExplo:SetPos( self:GetPos() )
					physExplo:SetKeyValue( "Magnitude", "-25000000" )	-- Power of the Physicsexplosion
					physExplo:SetKeyValue( "radius", tostring( i * 1012 ) )	-- Radius of the explosion
					physExplo:SetKeyValue( "spawnflags", "19" )
					physExplo:Spawn()
					physExplo:Fire( "Explode", "", 0.01 )
					
				end
				
			end
			
		end )
		
	end
	
end


