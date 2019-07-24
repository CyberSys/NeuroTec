AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	-- if ( self:GetModel() ) then
		
		-- self:SetModel( self:GetModel() )
		
	-- else
	
		self:SetModel( "models/bf2/weapons/predator/predator_rocket.mdl" )
	
	-- end
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj ) then
		
		self.PhysObj:Wake()
		-- self.PhysObj:EnableGravity(true)
		-- self.PhysObj:EnableDrag(false)
		-- self.PhysObj:SetMass(250)

	end
	
	self.SpawnTime = CurTime()
	-- self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",25,110)
	local count = 0
	local tr,trace = {},{}
	for i=1,10 do
		tr.start = self:GetPos() 
		tr.endpos = tr.start + VectorRand() * 1500 
		tr.filter = self
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
		
		if( trace.Hit ) then 
			
			count = count + 1 
			
		end 
		
	end 
	
	if( count < 4 ) then 	
	
		self.Whistle = CreateSound( self, "wt/misc/bomb_whistle.wav")
		self.Whistle:Play()
		
	end 
	
	util.SpriteTrail(self, 0, Color(255,255,255,math.random(11,12)), false, 3, math.random(0.5,1.1), 1, math.random(1,3), "trails/smoke.vmt");  
end

function ENT:Think()

	-- local tr, trace = {},{}
	-- tr.start = self:GetPos()
	-- tr.endpos = tr.start + self:GetForward() * 55
	-- tr.filter = self
	-- trace = util.TraceLine( tr )
	
	-- if ( trace.Hit && trace.HitSky || self:WaterLevel() > 0 ) then
		
		-- if( self:WaterLevel() > 0 ) then
			
			-- ParticleEffect( "water_impact_big", self:GetPos(), Angle( 0,0,0 ), nil )
			-- util.BlastDamage( self,( self.Owner or self ), self:GetPos() + Vector(0,0,32), 270, math.random( 1500,2500 ) )
			-- self:PlayWorldSound( "Misc/shel_hit_water_"..math.random(1,3)..".wav" )
			-- self:EmitSound(  "wt/misc/bomb_explosion_"..math.random(1,6)..".wav", 511, 100 )
		
		-- end
		
		-- self:Remove()
		
	-- end

end

function ENT:PhysicsCollide( data, physobj )
	
	if( self.SpawnTime + 0.25 > CurTime() ) then return end
	
	if (  !IsValid( self.Owner ) ) then
	
		self.Owner = self
	
	end

	
	if (data.Speed > 5 && data.DeltaTime > 0.2 ) then 

		ParticleEffect( "lowyield_nuke_air_main_mini", data.HitPos, data.HitNormal:Angle(), nil )
		ParticleEffect( "bignuke_mini_dustwave_group", data.HitPos, data.HitNormal:Angle(), nil )
		ParticleEffect( "bignuke_mini_groundwave", data.HitPos, data.HitNormal:Angle(), nil )
		local pos = self:GetPos()
		timer.Simple( 0.25, function() 
		
			for k,v in pairs ( ents.FindInSphere( pos, 1024 ) ) do 
				
				if( IsValid( v ) ) then 
				
					v:Ignite( 10,10 )
					local p = v:GetPhysicsObject()
					if( IsValid( p ) ) then 
						
						p:ApplyForceCenter( ( data.HitPos - v:GetPos() ) * -6000 )
					
					end 
					
				end 
				
			end 
		
		end )
		
		self:PlayWorldSound(  "wt/misc/bomb_explosion_"..math.random(1,6)..".wav" )
		self:PlayWorldSound(  "ambient/atmosphere/thunder1.wav" )
		self:EmitSound("ambient/atmosphere/thunder1.wav", 511, 100 )
		
		util.BlastDamage( self, self.Owner, data.HitPos + data.HitNormal * 52, 512, math.random( 15000,35500 ) )
		
		util.Decal("Scorch", data.HitPos + data.HitNormal * 32, data.HitPos - data.HitNormal * 32 )
	
		self:Remove()
	
	end
	
end

function ENT:OnRemove()
	
	if( self.Whistle ) then 
	
		self.Whistle:FadeOut( 0.5 )
	
	end 
	
end
