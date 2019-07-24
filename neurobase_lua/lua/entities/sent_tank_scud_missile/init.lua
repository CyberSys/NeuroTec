
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
 	 
 	local ent = ents.Create( "sent_tank_scud_missile" )
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

	self:SetCollisionGroup( 1 )	
	
	self.MissileTime = CurTime() + 5
	
	self.DestPos = self.FollowPos
	self.ActivateDel = CurTime()+3
	self.Speed = 20
	self.TargetPos = Vector(0,0,0)
	-- local fx = EffectData()
	-- fx:SetStart( self:GetPos() + self:GetForward()*-200 )
	-- fx:SetOrigin( self:GetPos() + self:GetForward()*-200 )
	-- fx:SetNormal( self:GetUp()*-1 )
	-- fx:SetMagnitude( 1 )
	-- fx:SetScale( 200.0)
	-- fx:SetRadius( 300 )
	-- util.Effect( "ThumperDust", fx )
	
	local nozzle = ents.Create("prop_physics")
	nozzle:SetPos( self:GetPos() + self:GetForward() * -250 )
	nozzle:SetAngles( self:GetAngles() * -1 )
	nozzle:SetModel( "models/error.mdl" )
	nozzle:SetRenderMode( RENDERMODE_TRANSALPHA )
	nozzle:SetColor( Color( 0,0,0,0 ) )
	nozzle:SetParent( self )
	nozzle:Spawn()
	ParticleEffectAttach( "scud_trail", PATTACH_ABSORIGIN_FOLLOW, nozzle, 0 )
	
	ParticleEffect(  "scud_launch", self:GetPos() + self:GetForward()*-200, self:GetAngles()*-1, self )
	
	local shake = ents.Create( "env_shake" )
	shake:SetPos( self:GetPos() )
	shake:SetOwner( self )
	shake:SetKeyValue( "amplitude", "10" )
	shake:SetKeyValue( "radius", "1024" )
	shake:SetKeyValue( "duration", "4" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", "", 10 )
	
end

-------------------------------------------PHYS COLLIDE
function ENT:PhysicsCollide( data, phys ) 
	
	ent = data.HitEntity
	if( ent == self:GetOwner() || ent:GetOwner() == self:GetOwner() ) then return end
	
	if self.ActivateDel < CurTime() && self.killed == false then
		
		if( IsValid( data.HitEntity ) && !data.HitWorld ) then
			
			self:DoExplode( true )
			
		else
		
			self:DoExplode( false )
			
		end
			
		local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
		util.Decal("Scorch", a, b )
		
	elseif self.killed == false then

		-- self.killed = true 
		-- self:Fire("kill", "", 10)
		-- self.Trail:Remove()
		-- self.MissileSound:Remove()
		-- self:EmitSound("weapons/rpg/shotdown.wav",75,math.random(80,120))	
		
	end
	
end

-------------------------------------------PHYS UPDATE
function ENT:PhysicsUpdate( physics )
	
	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:Remove()
		
		return
		
		
	end
	
	self.Speed = math.Clamp( self.Speed * 1.025, 0, 1700 )
	
	if( self.ActivateDel <= CurTime() && self.TargetPos && self.TargetPos != Vector(0,0,0) ) then
		
		local targetpos = self.TargetPos
		-- targetpos.z = 0
		local mpos = self:GetPos()
		-- mpos.z = 0
		
		local norm = ( targetpos - self:GetPos() )
		local dist = norm:Length2D()
		local dist2 = norm:Length()
		local lerp = 0.01
		if( dist > 4000 ) then
			
			norm = ( self.TargetPos - self:GetPos() )
			targetpos = self.TargetPos + Vector( 0, 0, math.Clamp( dist*1, 0, 10000 ) )
			norm = ( targetpos - self:GetPos() ) 
		
		else
			 
			 lerp = 0.1
			 targetpos = ( self.TargetPos - self:GetPos() ):Angle()
			-- self:SetAngles(   )
		end
		
		if( dist < 100 ) then
			
			self:DoExplode( true )
			
			return
			
		end
		
		self:SetAngles( LerpAngle( lerp, self:GetAngles(), norm:Angle() ) )
		
	
	end
	
	self:GetPhysicsObject():SetVelocity( self:GetForward() * self.Speed  )
	
end
-------------------------------------------THINK
function ENT:Think()

	-- for k,v in pairs( player.GetAll() ) do
		
		-- if( ( v:GetPos()
	
	if self.ExplosionDel < CurTime() then
	
		self:SetCollisionGroup( 3 )
		
	end

	phys = self:GetPhysicsObject()
	phys:Wake()
	
end


-------------------------------------------REMOVE
function ENT:OnRemove()

end

function ENT:OnRemove()
	-- self.MissileSound:Stop()
end

function ENT:DoExplode( hitstuff )

	if self.DoExplodeOnce == 0 then
		
		self.DoExplodeOnce = 1
		if( hitstuff ) then
		
			ParticleEffect("scud_explosion", self:GetPos(),Angle(0,0,0), nil )
			-- ParticleEffect("carpet_explosion", self:GetPos(), self:GetAngles(), nil )
			-- ParticleEffect("FAB_groundwave", self:GetPos(), self:GetAngles(), nil )
			
		else
		
			ParticleEffect("scud_explosion", self:GetPos(),Angle(0,0,0), nil )
			
		end
		
		self:PlayWorldSound( "ambient/explosions/explode_1.wav" )
		
		if( !IsValid( self.Owner ) ) then
			
			self.Owner = self
			
		end
		
		if( !IsValid( self.Creditor ) ) then
			
			self.Creditor = self
			
		end
		
		local shake = ents.Create( "env_shake" )
		shake:SetPos( self:GetPos() )
		shake:SetOwner( self )
		shake:SetKeyValue( "amplitude", "10" )
		shake:SetKeyValue( "radius", "10500" )
		shake:SetKeyValue( "duration", "6" )
		shake:SetKeyValue( "frequency", "255" )
		shake:SetKeyValue( "spawnflags", "4" )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 )
		shake:Fire( "kill", "", 10 )
		
		self:EmitSound( "ambient/explosions/exp2.wav", 511, 100 )
		
		for k,v in pairs( player.GetAll() ) do
		
			v:EmitSound( "bf4/misc/Explosion Single Large 12.wav", 100, math.random( 95, 105 ) )
		
		end
	
		local mindam = 7500 -- self.MinDamage or 750
		local maxdam = 1550 -- self.MaxDamage or 1500
		local mrad = 2200
		local pos = self:GetPos()+Vector(0,0,256)
		local a,b = self.Creditor or self.Owner, self.Owner
		
		for i=1,5 do 
			
			timer.Simple( i/5, function()
			
				if( IsValid( a ) && IsValid( b ) ) then
					-- print("Damage => "..mindam + maxdam / math.Rand(1.8,2.2 ) )
					util.BlastDamage( a, b, pos, mrad, mindam + maxdam / math.Rand(1.5,2.2 ) )
				
				end 
				
			end )
			
		end
		 
		self:Remove()
		
	end
	
end

