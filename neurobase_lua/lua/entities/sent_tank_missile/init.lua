
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.EntAngs = NULL
ENT.MissileSound = NULL
ENT.ExplosionDel = CurTime() + 1
ENT.DoExplodeOnce = 0
ENT.ActivateDel = CurTime()

ENT.MissileTime = CurTime() + 5	

ENT.DestPos = NULL
ENT.angchange	= 5
ENT.killed = false
ENT.Trail = NULL

function ENT:SpawnFunction( ply, tr )
--------Spawning the entity and getting some sounds i use.   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 10 
 	 
 	local ent = ents.Create( "sent_tank_missile" )
	ent:SetPos( SpawnPos ) 
 	ent:Spawn()
 	ent:Activate() 
 	ent.Owner = ply
	
	self.DestPos = self.FollowPos	
	self.ActivateDel = self.ActivateDel
	return ent 
 	 
end

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile_closed.mdl")
	-- self:SetColor( Color( 55, 55, 55, 255 ) )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	
	 self.EntAngs = self:GetAngles()
	 local pos = self:GetPos()
	 
		-- self.smoketrail = ents.Create( "env_smoketrail" )
		-- self.smoketrail:SetParent( self )	
		-- self.smoketrail:SetPos( pos + self:GetForward() * -83 )
		-- self.smoketrail:SetAngles( self:GetAngles() )
		-- self.smoketrail:SetKeyValue("emittime", math.Rand( 4, 7 ))
		-- self.smoketrail:SetKeyValue( "lifetime", math.Rand( 0.01, 0.1 ) )
		-- self.smoketrail:SetKeyValue( "startcolor", "160 160 160" )
		-- self.smoketrail:SetKeyValue( "startsize", math.Rand( 4, 8 ) )
		-- self.smoketrail:SetKeyValue( "endcolor", "192 192 192" )
		-- self.smoketrail:SetKeyValue( "endsize", math.Rand( 8, 16 )  )
		-- self.smoketrail:SetKeyValue( "opacity", math.Rand( 0.77, 0.91 ) )
		-- self.smoketrail:SetKeyValue( "firesprite", "sprites/firetrail.spr" )
		-- self.smoketrail:SetKeyValue( "maxdirectedspeed", math.Rand( -1,1 ) )
		-- self.smoketrail:SetKeyValue( "maxspeed", 12 )
		-- self.smoketrail:SetKeyValue( "minspeed", 1 )
		-- self.smoketrail:SetKeyValue( "smokesprite", "sprites/whitepuff.spr" )
		-- self.smoketrail:SetKeyValue( "spawnradius", 0 )
		-- self.smoketrail:SetKeyValue( "spawnrate", 200 )
		-- self.smoketrail:SetKeyValue( "origin", ""..pos.x.." "..pos.y.." "..pos.z.."" )
		-- self.smoketrail:Spawn()
		
	-- //Set 0.3 to lifetime for the small trail to prevent it vanishing during close fire.
	-- self.Trail = util.SpriteTrail(self, 0, Color(200,200,200,255), false, 4, 0, 0.3, 1/(15+1)*0.5, "trails/smoke.vmt") 
	
	-- self.MissileSound = CreateSound(self,"weapons/rpg/rocket1.wav")
	-- self.MissileSound:Play()
	-- self:SetCollisionGroup( 1 )	
	local a = self:GetAngles()
	a:RotateAroundAxis( self:GetUp(), 180 )
	
	ParticleEffect( "AA_muzzleflash", self:GetPos(), a, nil )
			
	self.MissileTime = CurTime() + 5
	self.SpawnTime = CurTime()
	
	self.DestPos = self.FollowPos
	self.ActivateDel = self.ActivateDel	
	self.Speed = 10
	-- self.Boosted = true
	
end

-------------------------------------------PHYS COLLIDE
function ENT:PhysicsCollide( data, phys ) 
	timer.Simple(0,function()
		ent = data.HitEntity
		
		if( data.HitSky ) then self:Remove() return end
		
		
		if self.ActivateDel < CurTime() && self.killed == false then
			
			if( IsValid( data.HitEntity ) && !data.HitWorld ) then
				
				self:DoExplode( true )
				
			else
			
				self:DoExplode( false )
				
			end
				
			local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
			util.Decal("Scorch", a, b )
			
		elseif self.killed == false then

			self.killed = true 
			self:Fire("kill", "", 10)
			self.Trail:Remove()
			self.MissileSound:Remove()
			self:EmitSound("weapons/rpg/shotdown.wav",75,math.random(80,120))	
			
		end
	end)
end

-------------------------------------------PHYS UPDATE
function ENT:PhysicsUpdate( physics )
	
	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:DoExplode(true)
		
		self:Remove()
		
		return
		
	end
	
	
	if( self.ShouldCluster && self.SpawnTime+1.75<=CurTime()) then
		
		local tr,trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = tr.start + self:GetForward() * 3250
		tr.filter = self
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
	
		if( trace.Hit && !trace.HitSky ) then

			for i=1,self.NumCluster do
				
				local bomblet = ents.Create( self.ClusterType )
				bomblet:SetPos( self:GetPos() + self:GetForward() * ( 5 * i ) + VectorRand() * 45 )
				bomblet:SetAngles( self:GetAngles() + Angle( math.random(-17,17),( 360/self.NumCluster ) * i, math.random(-180,180) ) )
				bomblet:SetOwner( self.Owner )
				bomblet:Spawn()
				bomblet:GetPhysicsObject():SetVelocity( bomblet:GetForward() * 1500 )
				
			end
		
			self:DoExplode( true )
				
			return
			
		end
		
	end
	
	if( self.Boosted ) then
	
		self.Speed = self.Speed * 1.25
		if(  IsValid( self:GetPhysicsObject() ) ) then
		
			self:GetPhysicsObject():SetVelocity( self:GetForward() * self.Speed )
		 
		 end
		 
	end
	
	if( self.TargetPos && self.TargetPos != Vector( 0,0,0 ) ) then
		
		if( self.TargetDistance < 2000 ) then
			
			-- self.Boosted = true
			
			return
		
		end
		-- print( "test ")
		local targetpos = self.TargetPos
		-- targetpos.z = 0
		local mpos = self:GetPos()
		local norm = ( targetpos - self:GetPos() )
		local dist = norm:Length2D()
		local dist2 = norm:Length()
		local lerp = 0.01
		local distanceDivider = self.ImpactDiveDistance or self.TargetDistance/2
		
		if( dist > distanceDivider ) then
			
			local targetHeight = self.TargetHeight or 5000
			
			norm = ( self.TargetPos - self:GetPos() )
			targetpos = self.TargetPos + Vector( 0, 0, math.Clamp( dist*1, 0, targetHeight ) ) + VectorRand()*32
			norm = ( targetpos - self:GetPos() ) 
		
		else
			 
			 lerp = 0.1
			 targetpos = ( self.TargetPos - self:GetPos() ):Angle()
			-- self:SetAngles(   )
		end
		

		self:SetAngles( LerpAngle( lerp, self:GetAngles(), norm:Angle() ) )
		
		self.Speed = math.Clamp( self.Speed * 1.25, 0, 50000 )
		self:GetPhysicsObject():SetVelocity( self:GetForward() * self.Speed )
		
		if( dist2 < 100 ) then
			
			self:DoExplode( true )
			
			return
			
		end
		
		return
		
	end
	
	
	if( IsValid( self.Target ) ) then
		
		local targetpos = self.Target:GetPos()
		local norm = ( targetpos - self:GetPos() )
		local dist = norm:Length()
		
		if( dist > 2000 ) then
			
			targetpos = targetpos + Vector( math.random(-5,5),math.random(-5,5),math.Clamp( dist/10, 0, 1500 ) )
			norm = ( targetpos - self:GetPos() )
			
		end
		
		if( dist < 100 ) then
			
			self:DoExplode( true )
			
			return
			
		end
		
		self:SetAngles( norm:Angle() )
		self:GetPhysicsObject():SetVelocity( self:GetForward() * 12200 )
	
	end
	
end
-------------------------------------------THINK
function ENT:Think()

	if self.ExplosionDel < CurTime() then
	
		self:SetCollisionGroup( 3 )
		
	end

	phys = self:GetPhysicsObject()
	phys:Wake()
	
end

function ENT:OnRemove()

end


function ENT:DoExplode( hitstuff )

	if self.DoExplodeOnce == 0 then
		
		self.DoExplodeOnce = 1
		local fx = "rocket_impact_dirt"
		if( self.CustomParticleEffect ) then
			
			fx = self.CustomParticleEffect
				
		else
			
			if( hitstuff ) then
			
				fx = "rocket_impact_wall"
				
			end
			
		end
		ParticleEffect( fx, self:GetPos(), self:GetAngles(), nil )
			
		local snd = self.ImpactSound or "ambient/explosions/explode_"..math.random( 1, 2 )..".wav"
		self:PlayWorldSound( snd )
		
		if( !IsValid( self.Owner ) ) then
			
			self.Owner = self
			
		end
		
		if( !IsValid( self.Creditor ) ) then
			
			self.Creditor = self
			
		end
		
		self.MinDamage = self.MinDamage or 750
		self.MaxDamage = self.MaxDamage or 1500
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos()+Vector(0,0,72), self.Radius or 800, self.MinDamage + self.MaxDamage / math.Rand(1.8,2.2 ) )
		
		self:Remove()
		
	end
	
end

