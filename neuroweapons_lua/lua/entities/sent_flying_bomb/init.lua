AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )


ENT.HealthVal = 100

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = ply:GetShootPos() + ply:GetAimVector() * 250
	local ent = ents.Create( "sent_flying_bomb" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( "models/ukulele/props_v1_flying_bomb/v1_flying_bomb.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 500 )
		self.PhysObj:EnableDrag( false )
		self.PhysObj:EnableGravity( true )
		-- self.PhysObj:SetVelocity( self:GetForward() * 9000 )
	end
	
	-- util.PrecacheSound("Missile.Accelerate")
	self.Speed = 0
	self.Sauce = 450
	self.Target = NULL
	
	self.EngineSound = CreateSound( self, "V1/buzzbomb01.wav" )
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( ( data.Speed > 450 && data.DeltaTime > 0.2 && self.Started ) || self.Sauce <= 0 && !self.Destroyed ) then 
		
		self:DoExplosion()
		
	end
	
end

function ENT:PhysicsUpdate()
	
	if( self.Started ) then
		
		self.Sauce = self.Sauce - 1
		
		if( self.Sauce <= 0 ) then 
		
			if( self.Started ) then 
			
				self.Started = false 
				self:SetNetworkedBool("Started",false)
				self.smoketrail:Remove() 
				-- /*self.PhysObj:AddAngleVelocity( self:GetRight() * 500 ) */ 
				
			end 
			
			
			return 
			
		end 
		
		local Owner = self.Owner
		
		if( IsValid( Owner ) && Owner:Alive() && Owner:KeyDown( IN_WALK ) ) then
			
			if( Owner:KeyDown( IN_MOVELEFT ) ) then
				
				self.PhysObj:AddAngleVelocity( self:GetUp() * 1 )
				self.PhysObj:ApplyForceOffset( self:GetRight() * -0.5, self:GetRight() * -0.5 )
				
			elseif( Owner:KeyDown( IN_MOVERIGHT ) ) then
			
				self.PhysObj:AddAngleVelocity( self:GetUp() * -1 )
				self.PhysObj:ApplyForceOffset( self:GetRight() * 0.5, self:GetUp() * 0.5 )
			
			elseif( Owner:KeyDown( IN_FORWARD ) ) then
			
				self.PhysObj:ApplyForceOffset( self:GetForward() * 1.5, self:GetForward() * 1.5 )
				
			elseif( Owner:KeyDown( IN_BACK ) ) then
				
				self.PhysObj:ApplyForceOffset( self:GetForward() * -1.5, self:GetForward() * -1.5 )

			end
			
		end
			
			
	
		
		self.Speed = self.Speed + 150
		self.PhysObj:ApplyForceCenter( self:GetForward() * self.Speed + self:GetUp() * self.Speed / 3.5 )

	end
	
end

function ENT:Use( activator, caller )
	
	if( !self.Started ) then
	
		self.EngineSound:Play()
		self.owner = activator
		
		-- local trail = util.SpriteTrail(self, 0, Color(255,255,255,math.random(130,170)), false, 17, math.random(1,2), 12, math.random(1,3), "trails/smoke.vmt");  
		
		timer.Simple( 2, function() if( IsValid( self ) ) then
			
			self:GetPhysicsObject():Wake()
			self.smoketrail = ents.Create("env_rockettrail")
			self.smoketrail:SetPos( self:LocalToWorld( Vector( -199, 0, 73 ) ) )
			self.smoketrail:SetParent(self)
			self.smoketrail:SetLocalAngles( Angle( -10, 0, 0 ) )
			self.smoketrail:SetParent(self)
			self.smoketrail:Spawn()
			self.Started = true
			
			end
			
		end )
		
		self:SetNetworkedBool( "Started", true )
		
		self.PhysObj:EnableMotion(true)
		self.PhysObj:Wake()
		
		-- self:EmitSound( "Missile.Accelerate", 511, 100 )
		
	end
	
end

function ENT:DoExplosion()
	
	self.Destroyed = true
	
	local hitcount = 0
	
	for i=1,15 do
		
		local tr,trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = self:GetPos() + Vector( math.sin(CurTime())*256, math.cos(CurTime())*256, math.random( -256,55 ) )
		tr.filter = self
		trace = util.TraceLine( tr )
		
		if( trace.Hit ) then
			
			hitcount = hitcount + 1
			
		end
			
	
	end

	local explo = EffectData()
	explo:SetOrigin(self:GetPos())
	util.Effect("Explosion", explo)
	
	local effect =  "v1_impact" --( hitcount < 8 ) and "v1_air" or "v1_impact"
	ParticleEffect( effect, self:GetPos(), self:GetAngles(), nil )
	
	local own = self.Owner
	if( !IsValid( own ) ) then own = self end
	
	util.BlastDamage( self, own, self:GetPos(), 2048, 1000)
	
	self:Remove()
	

end


function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		self.Owner = dmginfo:GetAttacker()
		
	else
		
		self:DoExplosion()

	end
	
end

function ENT:Think()
	
	if( self.Started && IsValid( self.Owner ) ) then
		
		if( self.Owner:KeyDown( IN_WALK ) && self.Owner:KeyDown( IN_SPEED ) ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "V-1 Fuel Drained" )
			self.Sauce = 0
			
		end
		
	end
	
					
end 

function ENT:OnRemove()
	
	self.EngineSound:Stop()
	
end
