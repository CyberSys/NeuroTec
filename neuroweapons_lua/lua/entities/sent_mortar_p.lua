ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "8 cm Granatwerfer 34"
ENT.Author	= "Daylight106/Hastagaspatcho"
ENT.Category 		= "NeuroTec Weapons";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 500				

ENT.Model 			= "models/surgeon/mortar34.mdl"

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
	
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel("")
		self.Barrel:SetPos( self:LocalToWorld( Vector( -30, 1, 33.5 ) ) )
		self.Barrel:SetAngles(self:GetAngles() + Angle( -75,0,0) ) 
		self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetSolid( SOLID_NONE )
		self.Barrel:SetMoveType( MOVETYPE_NONE )
		self.Barrel:SetParent( self )
		self.Barrel.Owner = self 
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 
		self.LastMissileAttack = 0
		
		self:GetPhysicsObject():Wake()
		
	end

	function ENT:OnTakeDamage(dmginfo) 
		
		if( self.Destroyed ) then return end 
		
		local dmg = dmginfo:GetDamage()
		self.HealthVal = self.HealthVal - dmg 
			

	
	end
	
	
	function ENT:OnRemove() 

	end
	
	function ENT:Use( ply )
			
		
			
		if( self.LastMissileAttack + 5 <= CurTime() ) then 
			-- print("walla?")
			
			self.LastMissileAttack = CurTime()
			self:EmitSound("weapons/javelin/reload2.wav", 50, 25 )
			for i=1,5 do 
			timer.Simple( i/10, function() 
				if(!IsValid( self ) ) then return end 
				local fx = EffectData()
				fx:SetOrigin( self:LocalToWorld( Vector( 4, 0, 37 ) ) )
				fx:SetStart( self:LocalToWorld( Vector( 4, 0, 37 ) ) )
				fx:SetScale( .25 )
				fx:SetMagnitude( .31 )
				fx:SetNormal( Vector( 0,0,1 ) )
				util.Effect("Sparks", fx )
				
				end )
				
			end 
			
			timer.Simple( 1, function()
			if( IsValid( self )) then 
			
			local ball = ents.Create("sent_artillery_shell")
			ball:SetPos( self:LocalToWorld( Vector( 0, 0, 35 ) ) )
			ball:SetAngles( self.Barrel:GetAngles() ) 
			ball:Spawn()
			ball:Activate()
			ball:SetModel( "models/surgeon/mortarshell.mdl" )
			ball.Owner = ply
			ball.Radius = 45
			ball.MinDamage = 200
			ball.MaxDamage = 2000
			ball:GetPhysicsObject():SetMass( 35 ) 
			ball:GetPhysicsObject():ApplyForceCenter( ball:GetForward() * math.random( 70000,  80000 ) )
			self:GetPhysicsObject():ApplyForceCenter( ball:GetForward() * -35000 )
			
			-- ParticleEffectAttach( "tank_muzzleflash", PATTACH_ABSORIGIN_FOLLOW,ball, 0 )
			local a = ball:GetAngles()
			-- a:RotateAroundAxis( ball:GetUp(), -90 ) 
			
			ParticleEffect("tank_muzzleflash", ball:GetPos(),a, nil )
			self:PlayWorldSound( "wot/t1_cun/burst.wav" )
			self:EmitSound( "weapons/mortar/mortar_Fire1.wav", 511, 70 )
			
			end 
			
			end )
		end 
	-- print("booM", ply )
	
	end 
	function ENT:Think() 
		
		-- self:GetPhysicsObject():Wake()
	
	
	end
	function ENT:PhysicsUpdate()
	
	end 
	
end

if( CLIENT ) then 

	function ENT:Initialize() 
	
	end
	
	function ENT:Draw() 
		
		self:DrawModel() 
		
	end
	
end
