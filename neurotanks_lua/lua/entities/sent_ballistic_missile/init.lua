AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Speed = 3000
ENT.Damage = 2500
ENT.Radius = 2236
ENT.Cluster = 12
function ENT:OnTakeDamage(dmginfo)
 self:NA_RPG_damagehook(dmginfo)
end
function ENT:Initialize()
		
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Ticker = 0

	if ( self:GetModel() ) then		
		self:SetModel( self:GetModel() )		
	else	
		self:SetModel( "models/military2/missile/missile_patriot.mdl" )		
	end
	
	math.randomseed( self:EntIndex() * 1000 + CurTime() )
	local r = math.random( 0, 1 ) 
	self.rand = ( r > 0  ) and 1 or -1
	
	self.PhysObj = self:GetPhysicsObject()
	self.Sound = CreateSound(self, "Missile.Accelerate")
	
	if ( self.PhysObj:IsValid() ) then
		
		self.PhysObj:EnableGravity(false)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass( 60 )
		self.PhysObj:Wake()
		
	end

	self.Speed = 200;
	
	util.PrecacheSound("Missile.Accelerate")

	-- self.smoketrail = ents.Create("env_rockettrail")
	-- self.smoketrail:SetPos(self:GetPos() + self:GetForward() * -83)
	-- self.smoketrail:SetParent(self)
	-- self.smoketrail:SetLocalAngles(Angle(0,0,0))
	-- self.smoketrail:Spawn()
	self:EmitSound("weapons/missile_launch.wav")

	local nozzle = ents.Create("prop_physics")
	nozzle:SetPos( self:GetPos() + self:GetForward() * -250 )
	nozzle:SetAngles( self:GetAngles() )
	nozzle:SetModel( "models/error.mdl" )
	nozzle:SetRenderMode( RENDERMODE_TRANSALPHA )
	nozzle:SetColor( Color( 0,0,0,0 ) )
	nozzle:SetParent( self )
	nozzle:Spawn()
	ParticleEffectAttach( "scud_trail", PATTACH_ABSORIGIN_FOLLOW, nozzle, 0 )
	
	-- util.SpriteTrail(self, 0, Color(255,225,180,math.random(150,170)), false, 24, math.random(1,2), 0.5, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt");  

end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	if ( !self.Owner || !IsValid( self.Owner ) ) then		
		self.Owner = self		
	end
	
	ParticleEffect( "v1_impact", self:GetPos(), self:GetAngles(), nil )
	-- util.BlastDamage( self, own, self:GetPos(), 2048, 1000)
	
	util.BlastDamage( self, self.Owner, data.HitPos + Vector( 0,0,128 ), self.Radius, self.Damage )

	self:Remove()
		
end

local function apr( a, b, c )
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:DispatchCluster()
	
	for i = 1, self.Cluster do
	
		local p = self:GetPos()
		p.x = p.x + math.sin( CurTime() ) * 64
		p.y = p.y + math.cos( CurTime() ) * 64
		
		local r = ents.Create("sent_c100_cluster")
		r:SetPos( p ) 
		r:SetAngles( Angle( 70 + math.random( -5, 5 ), i * ( 360 / self.Cluster ), 0 ) )
		r:SetOwner( self )
		r:Spawn()
		r.Owner = self.Owner
		r:GetPhysicsObject():ApplyForceCenter( r:GetForward() * 900000 )
		
	end
	
	local explo = EffectData()
	explo:SetOrigin( self:GetPos() )
	explo:SetScale( 0.5 )
	util.Effect( "Flaksmoke", explo )
	
	self:Remove()
	
end

function ENT:PhysicsUpdate()
	
	if( !IsValid( self.PhysObj ) ) then return end 
	
	-- self.PhysObj:SetVelocity( self:GetForward() * self.Speed )
	local veloc = self.PhysObj:GetVelocity()	
	self.PhysObj:SetVelocity(veloc)
	self.Speed = math.Clamp(self.Speed + 30, 200, 5500)
	self.PhysObj:ApplyForceCenter(self:GetForward() * self.Speed )
			
	
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end
	
	if( self.Ticker < 50 ) then
	-- if( self.Ticker < 3 ) then
			
		self.Ticker = self.Ticker + 1
		
		return
		
	end
	
	if( !self.ImpactPoint ) then
		
		return
		
	end
	
	local tr, trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 250
	tr.filter = self
	trace = util.TraceLine( tr )
	
	if ( trace.Hit && trace.HitSky ) then
		
		self:Remove()
		
	end
	
	local pos = self.ImpactPoint
	local mp = self:GetPos()
	local _2Ddistance = ( Vector( pos.x, pos.y, 0 ) - Vector( mp.x, mp.y, 0 ) ):Length()
	
	if ( _2Ddistance > 3150 ) then
		
		pos = self.ImpactPoint + Vector( math.sin( CurTime() * ( self:EntIndex() * 55 ) * self.rand ) * 2048, math.tan( CurTime() * ( self:EntIndex() * 55 ) * self.rand ) * 2048,( 2648 + ( ( math.cos( CurTime() + self:EntIndex() * 100 * self.rand ) * 128 ) ) ) + ( ( self:GetPos() - self.ImpactPoint ):Length() / 3.5 )  )
		
	else
	
		if( self.ShouldCluster ) then
		
			local tr, trace = {},{}
			tr.start = self:GetPos()
			tr.endpos = tr.start + self:GetForward() * 3400
			tr.filter = self
			trace = util.TraceLine( tr )
			
			if( trace.Hit ) then
				
				self:DispatchCluster()
			
			end
		
		end
		
		self.Speed = self.Speed + 25
		if _2Ddistance < 2000 then
			self:EmitSound("bf2/weapons/Artillery_projectile_"..math.random(1,3)..".mp3")
		end
	end
	
	local dir = ( pos - mp ):Angle()
	dir.y = self:GetAngles().y
	local a =  LerpAngle( 0.1318, self:GetAngles(), dir )
	//a.p, a.r, a.y = apr( a.p, dir.p, 4.5 ),apr( a.r, dir.r, 4.5 ),apr( a.y, dir.y, 4.5 )
	
	self:SetAngles( a )

end

function ENT:Think()

//	self.Sound:PlayEx( 100, 1 )
	self:EmitSound("weapons/missileengine.mp3")
	
end 

function ENT:OnRemove()

	self.Sound:Stop()
	self:StopSound( "weapons/missileengine.mp3" )	
end
