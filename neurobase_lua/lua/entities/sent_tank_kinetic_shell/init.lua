
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.MaxDamage = 1550
ENT.MinDamage = 1450
ENT.Radius = 128

function ENT:Initialize()

	self:SetModel( "models/thedoctor/sabot_shell_Full.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	
	if(phys:IsValid()) then
	
		phys:Wake()
		phys:SetMass( 5000 )
		-- phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
		
	end


	
	if( self.MinDamage && self.MaxDamage ) then
		
		self.DamageToDeal = math.random( self.MinDamage, self.MaxDamage )
		self.IsCritShell = ( self.DamageToDeal > self.MaxDamage * 0.9  )
		
		if( self.IsCritShell && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRITICAL" )
		
		end
		
	end

end

function ENT:PhysicsUpdate()
		
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end
	
	if( !self.Discarded ) then

		local tr, trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = tr.start + self:GetForward() * 3500
		tr.filter = self
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr ) 
		if( trace.Hit && IsValid( trace.Entity ) ) then
			
			self:SetModel( "models/thedoctor/sabot_dsk.mdl" )
			self.Discarded = true
			for i=1,4 do
				
				local prop = ents.Create("prop_physics")
				prop:SetPos( self:GetPos() + VectorRand()*32 )
				prop:SetModel( "models/gibs/manhack_gib04.mdl" )
				prop:SetAngles( Angle( math.random(-180,180),math.random(-180,180),math.random(-180,180) ) )
				prop:Spawn()
				prop:GetPhysicsObject():ApplyForceCenter( prop:GetForward() * 500 )
				prop:Fire("kill","",3)
				
			end
			
		
		end
	
	end
	
end
function ENT:Think()

	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:Remove()
		
		return
		
	end
	
	if( self.Detonating == true || self.IsCritShell ) then 			

		local fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin(self:GetPos() )
		fx:SetNormal( self:GetForward()*-1 )
		fx:SetScale( 0.5 )
		util.Effect("Sparks", fx )
		
	end
	
	self:NextThink( CurTime() + 0.1 )

	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 60000 )
	-- self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D

end

function ENT:PhysicsCollide( data, physobj )
		
	if( data.DeltaTime > 0.2 ) then
		
		if( IsValid( data.HitEntity ) && data.HitEntity:GetClass() == "prop_physics" && !self.HitOnce ) then
			
			self:SetPos( self:GetPos() + self:GetForward() * 20 )
			self:SetVelocity( data.OurOldVelocity )
			self.HitOnce = true
			
			return
		
		end
		
		if( self.Detonating == true ) then return end
		
		if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then --// Plox gief support for SetOwner ( table )
			
			return
			
		end
		
		local Deflect = self:TankAmmo_ShouldDeflect( data, physobj )
        if( Deflect ) then return end

		
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		if( !IsValid( self.Creditor ) ) then self.Creditor = self end
		
		if (data.Speed > 1 && data.DeltaTime > 0.1 ) then 

			ParticleEffect( "RPGShotDown", self:GetPos(), Angle(0,0,0), nil )

			if( IsValid( data.HitEntity ) &&  data.HitEntity.HealthVal ) then
				
				local destpos = self:GetPos()+self:GetForward()*16
				
				if( data.HitEntity.ArmorThicknessFront ) then
		
					destpos = data.HitPos + data.HitNormal * math.Clamp( 100 * (1.0-data.HitEntity.ArmorThicknessFront), 0, 50 )
					-- print("Took Armor into consideration")
					
				end
				
				self:EmitSound( "physics/metal/metal_box_break2.wav", 511, 100 )
		
				self:SetPos( destpos )
				debugoverlay.Cross( destpos, 55, 15, Color(255,0,0,255),true)
				debugoverlay.Cross( data.HitPos, 55, 15, Color(0,255,0,255),true)
				debugoverlay.Cross( data.HitPos + data.HitNormal * 30, 55, 15, Color(0,0,255,255),true)
				-- self:DrawLaserTracer( data.HitPos, data.HitPos + data.HitNormal * 32 )
				self:SetParent( data.HitEntity )
				self.Detonating = true
		
				self:Explode( true ) 

				
			else
				
		
				self:Explode( false ) 
			
			end
			
		end			
			
	end
		
end

function ENT:Explode( pierced )

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	local fx = EffectData()
	
	ParticleEffect( "ap_impact_wall", self:GetPos(), Angle(0,0,0), nil )

	if( pierced ) then
	
		-- self:EmitSound( "ambient/explosions/explode_2.wav", 511, 100 )
		
		self:EmitSound( "physics/metal/metal_sheet_impact_bullet1.wav", 511, 100 )
			
		util.Effect("RPGShotDown", fx )
		fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() )
		fx:SetNormal( self:GetForward() * -1 )
		fx:SetScale( 4.1 )
		util.Effect("ManHackSparks", fx )
		
		if( self.MinDamage && self.MaxDamage ) then
		
			util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 80, self.DamageToDeal )
			-- print( self.Radius, self.DamageToDeal )
		else
		
			util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 80, math.random( 950, 1250 ) )

		end
		
	else
		
		fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() )
		fx:SetNormal( self:GetForward() * -1 )
		fx:SetScale( 5 )
		util.Effect("ManHackSparks", fx )
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 80, math.random( 550, 750 ) )

	end
	 
	-- print( self.DamageToDeal )
	

	
	self:Remove()
	
end
