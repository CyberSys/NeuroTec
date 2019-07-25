AddCSLuaFile()

ENT.PrintName = "Sticky Grenade"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Weapons"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.HealthVal = 50 -- missile health
ENT.Model = "models/hoffa/stickynade.mdl" -- 3d model
ENT.EngineSoundPath = "missile.accelerate" -- Engine sound, precached or string filepath.
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )
ENT.Damage = 250 

if CLIENT then 

	function ENT:Draw()
		self:DrawModel()
	end 
	
end 

if( SERVER ) then 

	function ENT:Use( ply, caller, blah, bleh ) 

		return 
		
	end 	
	function ENT:OnTakeDamage( dmg )
	
	end 
	
	function ENT:PhysicsCollide( data, delta )
		
	
		if( !self.Stuck ) then 
		
			self.Stuck = true 
			-- self:SetSolid( SOLID_NONE )
			-- if( data.HitWorld ) then
			
				-- self:SetMoveType( MOVETYPE_NONE ) 
				-- self:SetPos( data.HitPos - data.HitNormal )
				
			-- else
				-- print("stuff")
				-- self:SetParent( data.HitEntity )
				-- self:SetPos( data.HitPos - data.HitNormal )
				-- local e = data.HitEntity 
				timer.Simple( 0, function()
					-- if( !IsValid( data.HitEntity  ) || !IsValid( self ) ) then return end 
						self:EmitSound( "npc/roller/mine/combine_mine_deploy1.wav", 70, 80 )
						self:SetPos( data.HitPos + data.HitNormal * -2 )
						local weld = constraint.Weld( self, data.HitEntity, 0,0, 0, true )
						-- print( weld, data.HitEntity, self )
						
				end ) 
			-- end 
			
		end 
	
	end 
	
	function ENT:Think()
		if( !self.Ticker ) then 
			self.Ticker = CurTime() 
			util.SpriteTrail( self, 0, Color( 255,255,255,25 ), false, 4, 1, 2, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		end 
		
		if( CurTime() - self.Ticker > 4  && !self.Chirped ) then 
			
			self.Chirped = true 
			self:EmitSound( "npc/roller/mine/rmine_blades_out1.wav", 100,  math.random(80,90) )
			 
		end 
		
		if( CurTime() - self.Ticker > 5 ) then 
			
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 72 ) ) do 
				
				if( !v.HealthVal ) then 
					
					local vp = v:GetPhysicsObject()
					if( IsValid( vp ) ) then 
						
						vp:Wake()
						vp:EnableMotion( true )
						vp:EnableGravity( true )
						vp:EnableDrag( true )
						
					end 
					
					constraint.RemoveConstraints( v, "Weld" )
					constraint.RemoveConstraints( v, "Axis" )
				
				end 
					
			end 
			
			local pe = ents.Create( "env_physexplosion" )
			pe:SetPos( self:GetPos() )
			pe:SetKeyValue( "Magnitude", 2000 )
			pe:SetKeyValue( "radius", 128 )
			pe:SetKeyValue( "spawnflags", 19 )
			pe:Spawn()
			pe:Activate()
			pe:Fire( "Explode", "", 0 )
			pe:Fire( "Kill", "", 0.25 )
			
			local snd = "weapons/hegrenade/explode"..math.random(3,5)..".wav"

			local blastpos = self:GetPos()
			
			if( self:WaterLevel() > 0 ) then 
				
				local tr,trace = {},{}
				tr.start = self:GetPos() + Vector( 0,0,100 )
				tr.endpos = tr.start + Vector( 0,0,-120)
				tr.mask = MASK_SOLID + MASK_WATER
				tr.filter = self 
				trace = util.TraceLine( tr ) 
				blastpos = trace.HitPos 
				
				ParticleEffect( "water_impact_big_mini", trace.HitPos, Angle( 0,0,0 ) , nil )
				snd = "misc/shel_hit_water_"..math.random(1,3)..".wav"
			else 
			
				ParticleEffect( "microplane_midair_explosion", self:GetPos() + Vector(0,0,16), self:GetAngles(), nil )
			
			end 
			
			self:PlayWorldSound( snd )
			self:EmitSound( snd, 511, 100 )
			
			ParticleEffect( "Explosion", blastpos, Angle(0,0,0), nil )
			
			local tr,trace = {},{}
			tr.start = self:GetPos() + Vector( 0,0,16 )
			tr.endpos = tr.start + Vector( 0,0,-100)
			tr.mask = MASK_SOLID
			tr.filter = self 
			trace = util.TraceLine( tr ) 
			
			local a,b = trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal
			util.Decal("Scorch", a, b )
			
			local own = self.Owner
			if ( !IsValid( own ) ) then
				own = self
			end
			
			util.BlastDamage( self, own, blastpos, 170, self.Damage )
			
			self:Remove()
			
		end 
	end 

end 
