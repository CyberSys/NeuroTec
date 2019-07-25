
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile_launch.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake()

	end
	
	-- timer.Simple( 1.5, function() if( IsValid( self ) ) then self:EmitSound("ambient/atmosphere/city_tone.wav",511, 200 )  end  end )
	self.LastSound = 0
	timer.Simple( 30, function() if IsValid(self) then self:Remove() end end,self) //That might prevent gmod from crashing due to physics.
	self.BoostTimer = 0
	-- self.Trail = util.SpriteTrail(self, 0, Color(200,200,200,85), false, 25, 0, 2, 1/(15+1)*0.5, "trails/smoke.vmt") 
	self.Speeds = {}
		local TrailDelay = math.Rand( .25, .5 ) / 11
	local TraceScale1 = 1.5
	local TraceScale2 = 1.5
	local GlowProxy = 1.75
	
	self.SpriteTrail = util.SpriteTrail( 
						self, 
						0, 
						Color( 255, 
						205, 
						100, 
						225 ), 
						false,
						8, 
						8, 
						TrailDelay, 
						 1 / ( 0 + 6) * 0.5, 
						"trails/smoke.vmt" );
						
	self.SpriteTrail2 = util.SpriteTrail( 
						self, 
						0, 
						Color( 255, 
						255, 
						255, 
						15 ), 
						true,
						12, 
						0, 
						TrailDelay*60, 
						 1 / ( 0 + 48 ) * 0.5, 
						"trails/smoke.vmt" );
						
	local Glow = ents.Create("env_sprite")				
	Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
	Glow:SetKeyValue("rendercolor","255 150 100")
	Glow:SetKeyValue("scale",tostring(TraceScale1))
	Glow:SetPos(self:GetPos())
	Glow:SetParent(self)
	Glow:Spawn()
	Glow:Activate()

	local Shine = ents.Create("env_sprite")
	Shine:SetPos(self:GetPos())
	Shine:SetKeyValue("renderfx", "0")
	Shine:SetKeyValue("rendermode", "5")
	Shine:SetKeyValue("renderamt", "255")
	Shine:SetKeyValue("rendercolor", "255 130 100")
	Shine:SetKeyValue("framerate12", "20")
	Shine:SetKeyValue("model", "light_glow01.spr")
	Shine:SetKeyValue("scale", tostring( TraceScale2 ) )
	Shine:SetKeyValue("GlowProxySize", tostring( GlowProxy ))
	Shine:SetParent(self)
	Shine:Spawn()
	Shine:Activate()
	
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 ) then 	
	
		self:Remove() 
		
		return 
		
	end 
	
	-- self.BoostTimer = self.BoostTimer + 1
	-- if( self.BoostTimer < 5 ) then
	
		-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 2000 ) 
		-- print( "boost ")
	-- end
	-- if( self.LastSound + 2 <= CurTime() ) then
		
		-- self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",511,110)
		
		-- self.LastSound = CurTime()
		
	-- end
	self:NextThink(CurTime()+5)
	-- table.insert( self.Speeds, )
	-- print( math.ceil(self:GetVelocity():Length() ), math.ceil( ( self:GetPos() - self.Owner:GetPos() ):Length() ) )
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 1000 ) ) do
		
		if( v:IsPlayer() ) then
		
			self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",25,110)
			self:EmitSound("bf2/weapons/Artillery_projectile_"..math.random(1,3)..".mp3")

		end
		
	end

end
function ENT:OnRemove()
	
	-- local count = 0
	-- for i=1,#self.Speeds do
		
		-- count = count + self.Speeds[i]
	
	-- end
	-- print("HERE COMES THE LOAD" )
	-- PrintTable( self.Speeds ) 
	-- print( "AVERAGE", count/#self.Speeds )
	if( self:WaterLevel() > 0 ) then 
		
		self:EmitSound(  "misc/shel_hit_water_"..math.random(1,3)..".wav", 511, 100 )
		self:PlayWorldSound(  "misc/shel_hit_water_"..math.random(1,3)..".wav" )
		ParticleEffect( "water_impact_big", self:GetPos(), Angle( 0,0,0 ), nil )

	
	end 
		-- local _min = self.MinDamage or 5500
		-- local _max = self.MaxDamage or 9500
		-- util.BlastDamage( self, self.Owner, data.HitPos, 1340, math.random( _min, _max ))
		
end


function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
		
		return
		
	end
	
	if (data.Speed > 50 && data.DeltaTime > 0.2 ) then 

		self:PlayWorldSound( "explosion"..math.random(3,5)..".wav" )-- "ambient/explosions/exp2.wav" )
		
		local shake = ents.Create( "env_shake" )
		shake:SetPos( self:GetPos() )
		shake:SetOwner( self )
		shake:SetKeyValue( "amplitude", "1000" )
		shake:SetKeyValue( "radius", "5000" )
		shake:SetKeyValue( "duration", "1" )
		shake:SetKeyValue( "frequency", "255" )
		shake:SetKeyValue( "spawnflags", "4" )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 )
		shake:Fire( "kill", "", 2 )
		
		local Ang = ( data.HitPos - data.HitNormal ):Angle()
		
		if( IsValid( data.HitEntity ) && !data.HitWorld ) then
		
			ParticleEffect("rt_impact_tank", self:GetPos(), Ang, nil )
			
		else
		
			ParticleEffect("rt_impact", self:GetPos(), Ang, nil )
		
		end
		
		if( !IsValid( self.Owner ) ) then
			
			self.Owner = self
			
		end 
		
		local _min = self.MinDamage or 5500
		local _max = self.MaxDamage or 9500
		util.BlastDamage( self, self.Owner, data.HitPos, 1340, math.random( _min, _max ))
		
		self:Remove()
		
	end
	end)
end
