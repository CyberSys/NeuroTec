AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/hunter/tubes/circle4x4.mdl"
ENT.Sound = "lockon/snare.mp3"//"bf2/weapons/m249_Fire.wav"//"weapons/shotgun/shotgun_dbl_Fire7.wav"
ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0
ENT.MaxDamage = 100
ENT.MinDamage = 20
ENT.BlastRadius = 666
ENT.InitialHealth = 3000
ENT.HealthVal = nil
ENT.Firemode = false

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "npc_phalanx" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE)	
	self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.LastReminder = CurTime()
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.Firemode = false
	self:SetColor( Color(150,150,150,255) )
	self:SetMaterial( "phoenix_storms/dome" )
	
	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/solcommand/typhoon/base.mdl")
	self.Turret:SetPos(self:GetPos() + self:GetUp() * 45 )
	self.Turret:SetParent( self )
	self.Turret:Spawn()

	self.Barrel = ents.Create("prop_physics_override")
	self.Barrel:SetModel( "models/solcommand/phalanx.mdl" )
	self.Barrel:SetPos(self.Turret:GetPos() + self.Turret:GetUp() * 37)
	self.Barrel:SetParent( self.Turret )
	self.Barrel:Spawn()
	  	
	constraint.NoCollide( self.Turret, self, 0, 0 )
	constraint.NoCollide( self.Turret, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	constraint.NoCollide( self.Weapon, self.Turret, 0, 0 )

        self.Roar = CreateSound( self, "micro/gau8_test.wav" )
		self.RoarEnd = "micro/gau8_end_test.wav"
		
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 
		
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		
	end
		
	self.Owner = self
	
	self:SetPhysicsAttacker(self.Owner)

end

local function inLOS( a, b )

	if( !IsValid( a ) || !IsValid( b ) ) then
		
		return false
	
	end
	
	if( ( a:GetPos() - b:GetPos()):Length() > 10000 ) then return false end
	
	local trace = util.TraceLine( { start = a:GetPos() + a:GetUp() * 100, endpos = b:GetPos() + Vector(0,0,100), filter = { a, b }, mask = MASK_BLOCKLOS } )
	-- print( "HIT?", trace.Hit )
	return !trace.Hit
	
end

function ENT:OnRemove() 

		self.Roar:Stop()
		
	end
	
function ENT:ShootMeanCannon()
		
		if( !IsValid( self ) ) then return end 
		-- local bullet = ents.Create("sent_mini_shell")
local bullet = {} 
	bullet.Num 		= 1
	bullet.Src 		= self.Barrel:GetPos() + self.Barrel:GetAngles():Forward() * 100
	bullet.Dir 		= self.Barrel:GetAngles():Forward()			-- Dir of bullet 
	bullet.Spread 	= Vector( 0.025, 0.022, 0.019 )						-- Aim Cone 
	bullet.Tracer	= math.random(10,25)					-- Show a tracer on every x bullets  
	bullet.Force	= 50					 					-- Amount of force to give to phys objects 
	bullet.Damage	= 15
	bullet.AmmoType = "Ar2" 
	bullet.TracerName 	= "AirboatGunHeavyTracer" 
	bullet.Attacker = self.Owner
	bullet.Callback    = function (a,b,c) 
			
			if( b.HitSky ) then return end 
			local fx = EffectData()
			fx:SetOrigin( b.HitPos )
			fx:SetScale( 1.0 )
			fx:SetNormal( b.HitNormal )
			
			if( IsValid( b.HitEntity ) && b.HitEntity != game.GetWorld() ) then 
			
				util.Effect("micro_he_impact_plane", fx )
			
			else
			
				util.Effect("micro_he_impact", fx )
			
			end 
			
			util.BlastDamage( self, self, b.HitPos + b.HitNormal, 36, math.random( 2, 3 ) )
			
		end 
		
	
		self.Barrel:FireBullets( bullet )
		-- ParticleEffectAttach( "mg_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, self.Barrel, 0 )
		ParticleEffect( "AA_muzzleflash", self.Barrel:GetPos() + self.Barrel:GetForward() * 200, self.Barrel:GetAngles(), nil )
end 


function ENT:PhysicsUpdate()
		
		if( IsValid( self.Target ) ) then 

		
			local targetAngle = ( self.Target:GetPos() - self:GetPos()  ):Angle()
			local adiff = math.AngleDifference( targetAngle.y, self:GetAngles().y )
			local angg = self:GetAngles()
			angg:RotateAroundAxis( self:GetUp(), adiff )
			self.Turret:SetAngles( LerpAngle( 0.99, self.Turret:GetAngles(), angg) )
			-- targetAngle:RotateAroundAxis( self:GetUp(), 180 )
			targetAngle = ( self:GetPos() - self.Target:GetPos() ):Angle()
			self.Barrel:SetAngles(  Angle( Lerp( 0.9, self.Barrel:GetAngles().p, -targetAngle.p ), self.Turret:GetAngles().y, self.Turret:GetAngles().r ) )
end
end

function ENT:Think() 
		
		self:GetPhysicsObject():Wake()
		if( !IsValid( self.Target ) ) then 
	
			local closest = NULL
			local dist = 9999999
			
			for k,v in pairs( ents.FindInSphere(self:GetPos(), 7500 ) ) do 
				
				local distdiff = ( self:GetPos() - v:GetPos() ):Length() 
				
				if( distdiff < dist && v.Owner != self && v:GetClass() != self:GetClass() && v != self.Owner.Pilot && v.Owner != self.Owner ) then
					
					if( v:GetVelocity():Length() > 700 && !v.Destroyed && inLOS( v, self ) && v:GetPos().z > self:GetPos().z + 250 ) then 					
						
						distdiff = dist 
						closest = v 
						
					end 
					
					
				end 
			
			
			end
			
			if( IsValid( closest ) ) then 
			
				self.Target = closest

				return 
				
			end 
		
		else
			
			-- Have a target
			
			local dist = ( self:GetPos() - self.Target:GetPos() ):Length()
			
			if( dist > 7500 ) then 
			
				self.Target = NULL 
				self.LastHadTarget = CurTime()
				
				return
				
			end 
			-- print(inLOS( self.Target, self) )
			if( !inLOS( self.Target, self ) || self.Target:GetPos().z <= self:GetPos().z +150) then 
				
				self.Target = NULL
				self.LastHadTarget = CurTime()
				
				return 
				
			end
			
			if( IsValid( self.Owner ) && self.Target == self.Owner.Pilot ) then self.Target = NULL return end 
			-- print( self.Owner.Pilot )
			if( self.Target:GetVelocity():Length() < 100 ) then 
				
				self.Target = NULL 
				return 
				
			end 
			
			local ma = self.Turret:GetAngles()
			local ta = (  ( self.Target:GetPos() + self.Target:GetVelocity() * .5 ) - self:GetPos()  ):Angle()
			local diff = math.AngleDifference( ta.y, ma.y )
			-- print( diff:Length() )
			-- print( diff )
		
			local tr,trace = {},{}
			tr.start = self.Barrel:GetPos() + self.Barrel:GetForward() * 150 
			tr.endpos = tr.start + self.Barrel:GetForward() * 2000
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr ) 
					
			if( diff > -10 && diff < 10 && !trace.Hit ) then
			
				-- self.LastShoot = CurTime()
				-- self.Roar:Play()
				self:EmitSound("micro/gau8_humm2.wav")
				for i=1,2 do 
						
					timer.Simple( 4/i, function() 
						
						if( IsValid( self ) ) then 
						
							self:ShootMeanCannon()
						
						end 
						
					end )
					
					
				end 
				
			else
				
				-- if( self.LastShoot && self.LastShoot + .1 >= CurTime() ) then 
				
					-- self.Roar:FadeOut( 1 )
					-- self:EmitSound( self.RoarEnd, 511, 100 )
				
				-- end 
				
				
			end 
		
		
		end 
	
	
	end

function ENT:OnTakeDamage(dmginfo)
	
	local dt = dmginfo:GetDamageType()
	
	if( dt && DMG_BLAST_SURFACE == DMG_BLAST_SURFACE || dt && DMG_BLAST == DMG_BLAST || dt && DMG_BURN == DMG_BURN   ) then 
		// Nothing, these can hurt us
	else
	
		local atk = dmginfo:GetAttacker()
		local infomessage = "This vehicle can only be damaged by armor piercing rounds and explosives!"
		if( atk == self ) then return end
		
		if( self.LastReminder + 3 <= CurTime() && atk:IsPlayer() ) then
			
			self.LastReminder = CurTime()
			atk:PrintMessage( HUD_PRINTCENTER, infomessage )

		end
		
		return
		
	end
	
	self:TakePhysicsDamage( dmginfo )
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	self:SetNetworkedInt( "health" , self.HealthVal )
	
	if ( self.HealthVal < 0 ) then
		
		self:DeathFX()
		
	end
	
end

function ENT:OnRemove()

end

