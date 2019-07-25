ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Ye Olde Cannon"
ENT.Author	= "Hoffa / Sillirion"
ENT.Category 		= "NeuroTec Weapons";
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 500				

ENT.Model 			= "models/sillirion/fieldcannon/cannon_base.mdl"

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
		self.Barrel:SetModel("models/sillirion/fieldcannon/cannon_gun.mdl")
		self.Barrel:SetPos( self:LocalToWorld( Vector( 35, 1, 33.5 ) ) )
		self.Barrel:SetAngles(self:GetAngles() + Angle( -15,0,0) ) 
		self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetSolid( SOLID_NONE )
		self.Barrel:SetMoveType( MOVETYPE_NONE )
		self.Barrel:SetParent( self )
		self.Barrel.Owner = self 
		local wheelpos = { Vector( 38, 20, 0 ),Vector( 38, -20, 0 ) }

		local wheelang = {Angle(0,0,0),Angle(0,180,0)}
		for i=1,2 do 
			
			local wheel = ents.Create("prop_physics_override")
			wheel:SetPos( self:LocalToWorld( wheelpos[i] ) )
			wheel:SetAngles( self:GetAngles() + wheelang[i] )
			wheel:SetModel( "models/sillirion/fieldcannon/cannon_wheel.mdl" )
			wheel:Spawn() 
			-- wheel:SetParent( self )
			constraint.Weld( self, wheel, 0,0,0, true )
			
			-- constraint.Axis( self, wheel, 0, 0, wheelpos[i], wheelpos[i]+Vector(0,0,1), 0, 0, 500, 1 )
			-- constraint.Axis(self, wheel, 0, 0, wheelpos[i], wheelpos[i]+wheel:GetUp(), 5000000, 0, 0, 1, Vector(0,0,0), true )
			self:DeleteOnRemove( wheel )
		end 
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
			
		
			
		if( self.LastMissileAttack + 10 <= CurTime() ) then 
			-- print("walla?")
			
			self.LastMissileAttack = CurTime()
			self:EmitSound("ambient/energy/spark6.wav", 50, 25 )
			for i=1,10 do 
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
			ball:SetPos( self:LocalToWorld( Vector( 45, 0, 35 ) ) )
			ball:SetAngles( self.Barrel:GetAngles() ) 
			ball:Spawn()
			ball:Activate()
			ball:SetModel( "models/props_phx/misc/smallcannonball.mdl" )
			ball.Owner = ply
			ball.Radius = 64
			ball.MinDamage = 50000
			ball.MaxDamage = 15000
			ball:GetPhysicsObject():SetMass( 35 ) 
			ball:GetPhysicsObject():ApplyForceCenter( ball:GetForward() * math.random( 90000,  115000 ) )
			self:GetPhysicsObject():ApplyForceCenter( ball:GetForward() * -150000 )
			
			-- ParticleEffectAttach( "tank_muzzleflash", PATTACH_ABSORIGIN_FOLLOW,ball, 0 )
			local a = ball:GetAngles()
			-- a:RotateAroundAxis( ball:GetUp(), -90 ) 
			
			ParticleEffect("tank_muzzleflash", ball:GetPos(),a, nil )
			self:PlayWorldSound( "wot/cannons/120mm_main_gun.wav" )
			self:EmitSound( "wot/cannons/120mm_main_gun.wav", 511, 80 )
			
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
