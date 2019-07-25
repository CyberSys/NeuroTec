ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "A.I A.A"
ENT.Author	= "Hoffa"
ENT.Category 		= "NeuroTec Weapons";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 500				

ENT.Model 			= "models/bf2/weapons/tow/tow_support.mdl"
	
local function inLOS( a, b )

	if( !IsValid( a ) || !IsValid( b ) ) then
		
		return false
	
	end
	
	if( ( a:GetPos() - b:GetPos()):Length() > 10000 ) then return false end
	
	local trace = util.TraceLine( { start = a:GetPos() + a:GetUp() * 100, endpos = b:GetPos() + Vector(0,0,100), filter = { a, b }, mask = MASK_BLOCKLOS } )
	-- print( "HIT?", trace.Hit )
	return !trace.Hit
	
end

if( SERVER ) then

	AddCSLuaFile(  )
	
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  tr.HitPos + tr.HitNormal * 16
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
		self.Turret:SetModel( "models/bf2/weapons/M134/m134.mdl" )
		self.Turret:SetPos( self:LocalToWorld( Vector( 0, 0, 45 ) ) )
		self.Turret:SetAngles(self:GetAngles() ) 
		self.Turret:PhysicsInit( SOLID_NONE )
		self.Turret:SetSolid( SOLID_NONE )
		self.Turret:SetMoveType( MOVETYPE_NONE )
		self.Turret:SetParent( self )
		self.Turret.Owner = self 
		
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel("models/bf2/weapons/M134/m134_cannon.mdl")
		self.Barrel:SetPos( self.Turret:LocalToWorld( Vector( 2.1, -6, 0.0 ) ) )
		self.Barrel:SetAngles(self:GetAngles() ) 
		self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetSolid( SOLID_NONE )
		self.Barrel:SetMoveType( MOVETYPE_NONE )
		self.Barrel:SetParent( self.Turret )
		self.Barrel.Owner = self 
	
		self:SetNetworkedEntity("TurretReceiver", self.Turret )
		self.Missiles = {}
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetForward(), 45 )
		
		for i=1,3 do
		
			self.Missiles[i] = ents.Create("prop_physics_override")
			self.Missiles[i]:SetModel("models/bf2/weapons/Eryx/eryx_rocket.mdl")
			self.Missiles[i]:SetPos( self:LocalToWorld( Vector(2,10,28+(10.5*i)) ) )
			self.Missiles[i]:SetAngles( ang )
			self.Missiles[i]:PhysicsInit( SOLID_NONE )
			self.Missiles[i]:SetSolid( SOLID_NONE )
			self.Missiles[i]:SetMoveType( MOVETYPE_NONE )
			self.Missiles[i]:SetParent( self.Turret )
			self.Missiles[i].Owner = self
			self.Missiles[i]:SetSubMaterial( 0, self:GetMaterials()[1] )
			self.Missiles[i]:Spawn()
		
		end 
		
		local sign = ents.Create("prop_physics_override")
		sign:SetPos( self:LocalToWorld( Vector( 0,6.5,50 ) ) )
		sign:SetAngles( self.Turret:GetAngles() )
		sign:SetModel("models/props_c17/streetsign001c.mdl")
		sign:SetSubMaterial( 0, self:GetMaterials()[1] )
		sign:PhysicsInit( SOLID_NONE )
		sign:SetSolid( SOLID_NONE )
		sign:SetMoveType( MOVETYPE_NONE )
		sign:Spawn()
		sign:SetParent( self.Turret )
		sign.Owner = self 
		
		local ball = ents.Create("prop_physics_override")
		ball:SetPos( self:LocalToWorld( Vector( 0,0,40 ) ) )
		ball:SetAngles( self.Turret:GetAngles() )
		ball:SetModel("models/dav0r/hoverball.mdl")
		ball:SetSubMaterial( 0, self:GetMaterials()[1] )
		ball:PhysicsInit( SOLID_NONE )
		ball:SetSolid( SOLID_NONE )
		ball:SetMoveType( MOVETYPE_NONE )
		ball:Spawn()
		ball:SetParent( self )
		ball.Owner = self 
		
		self.Roar = CreateSound( self, "micro/gau8_test.wav" )
		self.RoarEnd = "micro/gau8_end_test.wav"
		
		self.LastOuch = CurTime()
		
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 
		self.LastMissileAttack = 0
		
		self:GetPhysicsObject():Wake()
		
	end

	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
			
		local edata = EffectData()
		edata:SetEntity(self)
		edata:SetMagnitude(10)
		edata:SetScale(10)
		util.Effect("TeslaHitBoxes", edata)
		if( self.LastOuch + 1.0 <= CurTime() ) then
			self.LastOuch = CurTime() 
			self:EmitSound("npc/scanner/scanner_pain2.wav", 511, math.random(80,120) )
		
		end 
		
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

		self.Roar:Stop()
		
	end
	
	function ENT:ShootMeanCannon()
		
		if( !IsValid( self ) ) then return end 
		-- local bullet = ents.Create("sent_mini_shell")
		local bullet = {} 
		bullet.Num 		= 1 
		bullet.Src 		= self.Barrel:GetPos() + self.Barrel:GetForward() * 65
		bullet.Dir 		= self.Barrel:GetAngles():Forward()
		bullet.Spread 	= Vector( .15,.15, .15  ) * .05
		bullet.Tracer	= 1
		bullet.Force	= 500
		bullet.Damage	= 0
		bullet.AmmoType = "Ar2" 
		bullet.TracerName 	= "AR2Tracer"
		bullet.Attacker = self.Pilot
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
			
			util.BlastDamage( self, self, b.HitPos + b.HitNormal, 36, math.random( 5, 15 ) )
			
		end 
		
		self.Barrel:FireBullets( bullet )
		-- ParticleEffectAttach( "mg_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, self.Barrel, 0 )
		ParticleEffect( "mg_muzzleflash", self.Barrel:GetPos() + self.Barrel:GetForward() * 55, self.Barrel:GetAngles(), nil )
	end 

	function ENT:DeployMissileStorm() 
		
		self:EmitSound("npc/roller/mine/combine_mine_deploy1.wav", 511, 70 )
		
		for i=1,#self.Missiles do
				
			timer.Simple( i/2, 
				function() 
						
					if( IsValid( self ) ) then 
					
					
						if( !IsValid( self.Target ) ) then 
							
							self:EmitSound("npc/turret_floor/retract.wav", 511, 100 )
							self.LastMissileAttack = self.LastMissileAttack - 5 
							
						end 
						
						
					end 
					
					if( IsValid( self )  && IsValid(  self.Missiles[i] ) && IsValid( self.Target ) ) then 
						
						self:EmitSound( "HL1/fvox/beep.wav", 511, 100 )
						
						local rocket = ents.Create("sent_mini_rocket")
						rocket:SetPos( self.Missiles[i]:GetPos() )
						rocket:SetModel( self.Missiles[i]:GetModel() )
						rocket:SetAngles( self.Missiles[i]:GetAngles() )
						rocket.Owner = self
						rocket.MinDamage = math.random( 45,75 )
						rocket.MaxDamage = math.random( 75,125 )
						rocket:SetOwner( self )
						rocket.Target = self.Target 
						rocket:SetSubMaterial( 0, self:GetMaterials()[1] )
						rocket:Spawn()
						rocket:GetPhysicsObject():SetVelocity( self.Missiles[i]:GetRight() * -50 )
						rocket.Delay = 0
						rocket.Sauce = 55
						ParticleEffectAttach( "microplane_MG_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, muzzlepos, 0 )
						
						local angr = rocket:GetAngles()
						angr:RotateAroundAxis( rocket:GetUp(), 180 )
						
						ParticleEffect( "mg_muzzleflash", rocket:GetPos()+rocket:GetForward()*-15, angr, rocket )
							
						self.Missiles[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
						self.Missiles[i]:SetColor( Color( 0,0,0,0 ) )
						local r = self.Missiles[i]
				
						timer.Simple( 14.5, function() 
							
							if( IsValid( r ) ) then
								
								r:SetColor( Color( 255,255,255,255 ) )
								r:EmitSound("plats/elevbell1.wav", 60, 150 )
								local effectdata = EffectData()
								effectdata:SetOrigin( r:GetPos()  )
								effectdata:SetEntity( r )
								util.Effect( "propspawn", effectdata )
								
							end 
						
						end )
						
					end 
					
			end )
		
		end 
	
	end 
	
	function ENT:Think() 
		
		self:GetPhysicsObject():Wake()
		if( !IsValid( self.Target ) ) then 
			
			if( self.LastPing + 1 <= CurTime() ) then 
				
				self.LastPing = CurTime()
				self:EmitSound("npc/turret_floor/ping.wav", 511, 50 )
				
			end 
			
			local closest = NULL
			local dist = 9999999
			
			for k,v in pairs( ents.FindInSphere(self:GetPos(), 5000 ) ) do 
				
				local distdiff = ( self:GetPos() - v:GetPos() ):Length() 
				
				if( distdiff < dist && v.Owner != self && v:GetClass() != self:GetClass() ) then
					
					if( v:GetVelocity():Length() > 500 && !v.Destroyed && inLOS( v, self ) ) then 					
						
						distdiff = dist 
						closest = v 
						
					end 
					
					
				end 
			
			
			end
			
			if( IsValid( closest ) ) then 
			
				self.Target = closest
				self:EmitSound("npc/turret_floor/active.wav", 511, 50 )
				return 
				
			end 
		
		else
			
			-- Have a target
			
			local dist = ( self:GetPos() - self.Target:GetPos() ):Length()
			
			if( dist > 5000 ) then 
			
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
			-- print( diff:Length() )
			-- print( diff )
			
			if( diff > -25 && diff < 25 && self.Target:GetPos().z > self:GetPos().z+200 && dist < 3500 ) then
			
				if( self.LastMissileAttack + 15 <= CurTime() ) then 
				
					self.LastMissileAttack = CurTime()
					self:DeployMissileStorm()
				
				end 
				
			
			end 
			
			
			if( diff > -10 && diff < 10 ) then
				
				self.LastShoot = CurTime()
				-- self.Roar:Play()
				self:EmitSound("micro/gau8_humm2.wav")
				for i=1,5 do 
						
					timer.Simple( .5/i, function() 
						
						if( IsValid( self ) ) then 
						
							self:ShootMeanCannon()
						
						end 
						
					end )
					
					
				end 
				
			else
				
				if( self.LastShoot && self.LastShoot + .1 >= CurTime() ) then 
				
					-- self.Roar:FadeOut( 1 )
					self:EmitSound( self.RoarEnd, 511, 100 )
				
				end 
				
				
			end 
		
		
		end 
	
	
	end
	function ENT:PhysicsUpdate()
	
		local ang = self:GetAngles()
		local lerpp = 0.25
		if( !IsValid( self.Target ) ) then 
			-- print( self.LastHadTarget )
			-- if( self.LastHadTarget && self.LastHadTarget + 2.5 >= CurTime() ) then 
				
				-- lerpp = 0.02
			
			
			-- end
			
			ang:RotateAroundAxis( self:GetRight(), 15 )
			ang:RotateAroundAxis( self:GetUp(), math.sin(CurTime() )*180 )
		 
			
			-- 
			-- ang:RotateAroundAxis( self:GetForward(), -45 )
			self.Turret:SetAngles( LerpAngle(  0.02, self.Turret:GetAngles(), ang ) )
		
		else
			
			local targetAngle = ( self.Target:GetPos() - self:GetPos()  ):Angle()
			-- targetAngle:RotateAroundAxis( self.Turret:GetUp(), 180 )

			self.Turret:SetAngles( LerpAngle( lerpp, self.Turret:GetAngles(), targetAngle) ) 
			
				-- print("ahasd")
		end 
		
	
	end 
	
end

if( CLIENT ) then 

	function ENT:Initialize() 
	
	end
	
	function ENT:Draw() 
		local Receiver = self:GetNetworkedEntity("TurretReceiver", NULL )
		if( IsValid( Receiver ) ) then 
			
			cam.Start3D( EyePos(), EyeAngles())

				local tr,trace = {},{}
				tr.start = Receiver:LocalToWorld( Vector( -9, -9, 9 ) )
				tr.endpos = Receiver:GetPos() + Receiver:GetForward() * 6500 + Receiver:GetUp() * -100
				tr.filter = { self, Receiver }
				tr.mask = MASK_SOLID 
				trace = util.TraceLine( tr )
				render.SetMaterial(Material("sprites/bluelaser1"))
				render.DrawBeam( tr.start, trace.HitPos, 2, 0, 12.5, Color(255, 0, 0, 255))

				local Size = math.random() * 1.35
				render.SetMaterial(Material("Sprites/light_glow02_add_noz"))
				render.DrawQuadEasy( trace.HitPos, (EyePos() - trace.HitPos):GetNormal(), Size, Size, Color(255,0,0,255), 0)
				
			cam.End3D()
			
		
		end 
		self:DrawModel() 
		
	end
	
end
