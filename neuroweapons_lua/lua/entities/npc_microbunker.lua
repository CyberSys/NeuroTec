ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Bunker test"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Micro Weapons";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 5000				

ENT.Model = "models/sillirion/normandy/bunker.mdl"
	
local function inLOS( a, b )

	if( !IsValid( a ) || !IsValid( b ) ) then
		
		return false
	
	end
	
	if( ( a:GetPos() - b:GetPos()):Length() > 10000 ) then return false end
	
	local trace = util.TraceLine( { start = a:GetPos() + a:GetUp() * 100, endpos = b:GetPos() + Vector(0,0,100), filter = { a, b }, mask = MASK_BLOCKLOS } )
	return !trace.Hit
	
end

if( SERVER ) then

	AddCSLuaFile(  )
	
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  tr.HitPos + tr.HitNormal * 32
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()

		return ent
	end
	
	function ENT:Initialize()
	
		self:SetModel( self.Model )	
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		self.Turret = ents.Create("prop_physics_override")
		self.Turret:SetModel("models/sillirion/normandy/bunkerturret.mdl" )
		self.Turret:SetPos( self:LocalToWorld( Vector( 40, 10, 2 )))
		self.Turret:SetAngles(self:GetAngles() ) 
		self.Turret:PhysicsInit( SOLID_NONE )
		self.Turret:SetSolid( SOLID_NONE )
		self.Turret:SetMoveType( MOVETYPE_NONE )
		self.Turret:SetParent( self )
		self.Turret.Owner = self 
		
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel("models/sillirion/normandy/bunkergun.mdl")
		self.Barrel:SetPos( self.Turret:LocalToWorld( Vector( 0, 0, 18 )) )
		self.Barrel:SetAngles(self:GetAngles() ) 
		self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetSolid( SOLID_NONE )
		self.Barrel:SetMoveType( MOVETYPE_NONE )
		self.Barrel:SetParent( self.Turret )
		self.Barrel.Owner = self 
	
		
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 
		self.LastMissileAttack = 0
		
		self:GetPhysicsObject():Wake()
		
	end

	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		local atk = dmginfo:GetAttacker()
		if( atk == self || atk.Owner == self || atk == self.Owner ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
		
		if( self.HealthVal <= 0 ) then
			
			self.Destroyed = true 
			
			self:PlayWorldSound("explosion"..math.random(3,5))
			
			ParticleEffect( "microplane_bomber_explosion", self:GetPos(), Angle( 0,0,0 ), nil )
			util.BlastDamage( self, self, self:GetPos(), 256, 256 )
			
			self:Remove()
			
			return
		
		end 
		
	
	end
	
	
	function ENT:OnRemove() 

		-- self.Roar:Stop()
		
	end
	
	function ENT:ShootMeanCannon()
		
		if( !IsValid( self ) ) then return end 
		if( !self.LastShot ) then self.LastShot = CurTime() end 
		
		if( self.LastShot + 5 >= CurTime() ) then return end 
		
		self.LastShot = CurTime() 
		
		local ball = ents.Create("sent_artillery_shell")
            ball:SetPos( self.Barrel:GetPos() + self.Barrel:GetForward() * 150 ) 
			ball:SetAngles( self.Barrel:GetAngles() )
			ball:Spawn()
			ball:Activate()
			ball:SetModel( "models/props_phx/misc/smallcannonball.mdl" )
			ball.Owner = self.Owner
			ball.Radius = 250
			ball.MinDamage = 4000
			ball.MaxDamage = 6000
			ball:GetPhysicsObject():SetMass( 1 ) 
			ball:GetPhysicsObject():ApplyForceCenter( ball:GetForward() * math.random( 90000,  115000 ) )
			
			-- ParticleEffectAttach( "tank_muzzleflash", PATTACH_ABSORIGIN_FOLLOW,ball, 0 )
			local a = ball:GetAngles()
			-- a:RotateAroundAxis( ball:GetUp(), -90 ) 

			fx = EffectData()
		        fx:SetOrigin( self.Barrel:GetPos() + self.Barrel:GetForward() * 150 )
		        util.Effect( "navalgun_muzzleflash",fx )

			ParticleEffect("navalgun_muzzleflash", ball:GetPos(),a, nil )
			self:PlayWorldSound( "wot/cannons/120mm_main_gun.wav" )
			self:EmitSound( "wot/cannons/120mm_main_gun.wav", 511, 80 )
	end 

	function ENT:Think() 
		self:GetPhysicsObject():Wake()
		if( !IsValid( self.Target ) ) then 
			local closest = NULL
			local dist = 9999999
for k,v in pairs( ents.FindInCone( self.Barrel:GetPos(), self.Barrel:GetForward()* 160,  12000.0, 1024.0 ) ) do
				local distdiff = ( self:GetPos() - v:GetPos() ):Length() 
				if( v.HealthVal && distdiff < dist && v.Owner != self && v:GetClass() != self:GetClass() && v.IsMicroCruiser ) then
					if( v:GetVelocity():Length() > 5 && !v.Destroyed && inLOS( v, self ) ) then 					
						distdiff = dist 
						closest = v 
					end 
				end 
			end
			
			if( IsValid( closest ) ) then 
				self.Target = closest
				-- self:EmitSound("npc/turret_floor/active.wav", 511, 50 )
				return 
			end 
		else
			-- Have a target
			local dist = ( self:GetPos() - self.Target:GetPos() ):Length()
			
			if( dist > 15000 ) then 
				self.Target = NULL 
				self.LastHadTarget = CurTime()
				return
				
			end 
			-- print(inLOS( self.Target, self) )
			if( !inLOS( self.Target, self ) ) then 
				self.Target = NULL
				self.LastHadTarget = CurTime()
				return 
			end
			
			if( self.Target:GetVelocity():Length() < 10 ) then 
				self.Target = NULL 
				return 
			end 

			local ma = self.Turret:GetAngles()
			local ta = (  ( self.Target:GetPos() + self.Target:GetVelocity() * .5 ) - self:GetPos()  ):Angle()
			local diff = math.AngleDifference( ta.y, ma.y )
			if( math.abs( diff ) < 15 ) then
				self.LastShoot = CurTime()
				self:ShootMeanCannon()
			end 

		end 
	end
function ENT:PhysicsUpdate()
if( IsValid( self.Target ) ) then 
--local TargetAngle = ( self.Target:GetPos() - self:GetPos() ):Angle()
--TargetAngle:Normalize()
--local YawMax = self:GetAngles()
--YawMax:RotateAroundAxis( self:GetUp(), -45 )
--local YawMin = self:GetAngles() 
--YawMin:RotateAroundAxis( self:GetUp(), 45 )

--if( TargetAngle.y >= YawMax.y && TargetAngle.y < YawMin.y ) then 
 -- allow to rotate
 


		local ang = self:GetAngles()
		local lerpp = 0.15
		if( !IsValid( self.Target ) ) then 
			ang:RotateAroundAxis( self:GetUp(), math.AngleDifference( ang.y, self.Turret:GetAngles().y ) )
			self.Turret:SetAngles( LerpAngle(  0.02, self.Turret:GetAngles(), ang ) )
		else
			local targetAngle = ( self.Target:GetPos() - self:GetPos()  ):Angle()
			local tAng = targetAngle 
			ang:RotateAroundAxis( self:GetUp(), math.AngleDifference( tAng.y, ang.y ) )
			self.Turret:SetAngles( LerpAngle( lerpp, self.Turret:GetAngles(), ang ) ) 
			self.Barrel:SetAngles( Angle( targetAngle.p, ang.y, ang.r ) )
		end 
	end 
end

if( CLIENT ) then 
	function ENT:Initialize() 
	end
	function ENT:Draw()
		self:DrawModel() 
	end
end
end
