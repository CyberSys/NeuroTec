AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.HealthVal = 100
ENT.Destroyed = false



function ENT:Initialize()
	local models = {
	{1,"models/military2/missile/missile_moskit.mdl",-91};
	{2,"models/military2/missile/missile_sm2.mdl", -156};
	{3,"models/military2/missile/missile_barak.mdl", -36};
	{4,"models/military2/missile/missile_tomahawk.mdl",-120};
	{5,"models/military2/missile/missile_tomahawk2.mdl",-118};
	{6,"models/military2/missile/missile_r-17.mdl",-210};
	{7,"models/military2/missile/missile_s300.mdl",-143};
	{8,"models/military2/missile/missile_harpoon.mdl",-79};
	{9,"models/military2/missile/missile_agm88.mdl",-83};
	{10,"models/military2/missile/missile_taepodong.mdl",-499};
	{11,"models/military2/missile/missile_tomahawk3.mdl",-134};
	}
	local rnd = math.random(1,11)
	local offset = 0
	self.Speed = math.random( 100, 130 )
	for k,v in pairs( models ) do
		
		if ( rnd == v[1] ) then
			self:SetModel( tostring(v[2]) )
			offset = v[3]
		end
		
	end
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.SpawnTime = CurTime()
	
	if (self.PhysObj:IsValid()) then
	
		self.PhysObj:Wake()
		
	end
	
	util.PrecacheSound("Missile.Accelerate")
	self.smoketrail = {}
	
	for i=1,2 do
		self.smoketrail[i] = ents.Create("env_rockettrail")
		self.smoketrail[i]:SetPos(self:GetPos() + self:GetForward() * offset)
		self.smoketrail[i]:SetParent(self.Entity)
		self.smoketrail[i]:SetLocalAngles(Vector(0,0,0))
		self.smoketrail[i]:Spawn()
	end
	
	util.SpriteTrail(self, 0, Color(255,255,255,math.random(130,170)), false, 48, math.random(1,2), 2, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt");  

	for k,v in pairs(ents.GetAll()) do 
	
		if ( v.HealthVal ) then
			
			self.Target = v
			
		end
		
	end

end

function ENT:OnTakeDamage(dmginfo)
	
	self.Entity:TakePhysicsDamage(dmginfo)

	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal <= 1 && !self.Destroyed ) then
		
		self.Destroyed = true
		
		local explo = EffectData()
		explo:SetOrigin(self:GetPos())
		explo:SetScale(math.Rand(0.5,0.9))
		explo:SetNormal(self:GetPos())
		util.Effect("Explosion", explo)
		util.BlastDamage( self.Entity, self.Entity, self:GetPos(), 1024, 200)
		self.Status = 2
		self:Remove()
		
		
	end

end

function ENT:PhysicsCollide( data, physobj )

	if (data.Speed > 50 && data.DeltaTime > 0.2 ) then 
		if( self:GetVelocity():Length() > 70 ) then
			local explo = EffectData()
			explo:SetOrigin(self.Entity:GetPos())
			explo:SetScale(math.Rand(0.5,0.9))
			explo:SetNormal(data.HitNormal)
			util.Effect("nn_explosion", explo)
			util.BlastDamage( self.Entity, self.Entity, data.HitPos, 1024, 500)
			self.Status = 0
			self:ExplosionImproved()
			self.Entity:Remove()
		end
	end
	
end

function ENT:LerpAim(Target)

	if ( Target == nil ) then

		return

	end
	
	if (!Target:IsValid()) then
			
		return
		
	end
	
	local a = self:GetPos() 
	local b = Target:GetPos() + Target:GetRight() * math.sin(CurTime()) * 180 + Target:GetUp() * math.sin(CurTime()) * 180
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )
	
	local v = self:GetVelocity()
	
	self:SetAngles( LerpAngle( 0.001, target:Angle(), self:GetAngles() ) )
	
	self:SetVelocity(v)
	
end

function ENT:PhysicsUpdate()

	if ( IsValid( self.Target ) ) then
	
		self:LerpAim(self.Target)
		
	end
	
	self.PhysObj:SetVelocity( self:GetForward() * ( 12 * self.Speed ) )
	
end


function ENT:Use( activator, caller )
end

function ENT:Think()
	/*
	if ( DEBUG ) then
	
		local p = self:GetPos()
		local b = Vector(128, 128, 128)
		debugoverlay.Text( self:GetPos(), "HURR MISSILE !1", 0.5)
		debugoverlay.Box( p, p + (b*-1), p + b,0.01, Color( 255,25,25,255 ), false )
	
	end */
	
	local tr, trace = {}, {}
	tr.start = self:GetPos() + self:GetForward() * 200
	tr.endpos = tr.start + self:GetForward() * 700 + self:GetRight() * math.random(-256,256)
	tr.filter = self
	trace = util.TraceEntity( tr, self )
	
	if ( trace.Hit ) then
	
		local explo = EffectData()
		explo:SetOrigin(self:GetPos())
		explo:SetScale(math.Rand(0.5,0.9))
		explo:SetNormal(trace.HitNormal)
		util.Effect("nn_explosion", explo)
		util.BlastDamage( self.Entity, self.Entity, trace.HitPos, 1024, 500)
		self:Remove()
		self.Status = 0
		
	end
	
end 

function ENT:OnRemove()

	if ( DEBUG ) then
	
		local t = CurTime() -  self.SpawnTime
		local msg = {
		{0,"AC-130 Test Rocket DETONATED after "};
		{1,"AC-130 Test Rocket FLARED after "};
		{2,"AC-130 Test Rocket SHOT DOWN after "};
		}
		local ms = "Unknown"
		for k,v in pairs( msg ) do
			if ( self.Status == v[1] ) then
				ms = v[2]
			end
		end
		
		for k,v in pairs ( player.GetAll() ) do
		
			v:PrintMessage( HUD_PRINTTALK, ms..t.." seconds" );
			
		end
		
	end
	
end
