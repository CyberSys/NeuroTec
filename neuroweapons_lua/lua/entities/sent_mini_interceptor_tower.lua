ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Interceptor Tower"
ENT.Author	= "Hoffa / Sillirion"
ENT.Category 		= "NeuroTec Weapons";
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.AdminOnly = true 
ENT.VehicleType = VEHICLE_WEAPON
-- ENT.PrintName = "AI Anti Air"
ENT.InitialHealth = 20500				

ENT.Model 			= "models/sillirion/radar.mdl"

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
	
		self.HealthVal = self.InitialHealth 
		self.LastPing = CurTime() 
		self.LastDroneSpawn = CurTime()
		self.LastOuch = CurTime() 
		self.Drones = {}
				
		
		self.MaxDrones = 7 
		self.DroneRepairDistance = 5000 
		self.DroneMaxSauce = 10 * 1000
		self.DroneMaxHealth = 250
		self.DroneSpawnDelay = 5 
		self.DroneSauceIncrement = 25
		self.DroneHealthIncrement = 1 

		
		self:GetPhysicsObject():Wake()
		
	end
	
	local droneModels = { 
	"models/killstr3aks/neuroplanes/british/skua.mdl",
	"models/killstr3aks/neuroplanes/american/f2a_buffalo.mdl",
	"models/killstr3aks/neuroplanes/german/he112.mdl",
	"models/killstr3aks/neuroplanes/russian/i17.mdl"
	}
	function ENT:CreateDrone()
		
		local drone = ents.Create("sent_interceptor")
		drone:SetPos( self:GetPos() + Vector( math.sin( 360/self.MaxDrones * #self.Drones ) * 750,math.cos( 360/self.MaxDrones * #self.Drones ) * 750, 550 ) )
		drone:SetAngles( Angle( 0, 360/self.MaxDrones * #self.Drones, 0 ) )
		drone:Spawn()
		drone:SetModel( droneModels[math.random(1,#droneModels)] )
		drone:Activate()
		drone.Faction = self:EntIndex()
		drone.HoverHeight = math.random(450,2000)
		drone.BaseTower = self 
		drone:Use( self, self, 0, 0 )  
		self:DeleteOnRemove( drone )
		
		return drone 
		
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
		
		if( dmg > 25 ) then 
			
			-- for k,v in pairs( self.Drones ) do 
			local drone = self.Drones[math.random(1,#self.Drones)]
			
			if( IsValid( drone ) ) then 
			
				drone.Target = dmginfo:GetAttacker()
			
			end 
			-- end 
			
		end 
		
		if( self.HealthVal <= 0 ) then
			
			self.Destroyed = true 
			
			self:PlayWorldSound("explosion"..math.random(3,5))
			
			ParticleEffect( "rt_impact", self:GetPos(), Angle( 0,0,0 ), nil )
			-- ParticleEffect( "microplane_bomber_explosion", self:GetPos()+Vector(0,0,72), Angle( 0,0,0 ), nil )
			-- ParticleEffect( "microplane_bomber_explosion", self:GetPos()+Vector(0,0,144), Angle( 0,0,0 ), nil )
			util.BlastDamage( self, self, self:GetPos(), 256, 256 )
			
			self:Remove()
			
			return
		
		end 
		
	
	end
	
	
	function ENT:OnRemove() 

	end
	
	function ENT:Use( ply )
			
		
	
	end 
	function ENT:Think() 
		if( self.LastDroneSpawn + self.DroneSpawnDelay <= CurTime() ) then 
			
			self.LastDroneSpawn = CurTime() 
			
			if( #self.Drones < self.MaxDrones ) then 
			
				local drone = self:CreateDrone()
				table.insert( self.Drones, drone )
				
			end 
			
		end 
		
		for i=1,#self.Drones do 
			
			if( !IsValid( self.Drones[i] ) ) then 
					
				table.remove( self.Drones, i ) 
				
			else
				
				if( self:GetPos():Distance( self.Drones[i]:GetPos() ) < self.DroneRepairDistance ) then 	
				
					self.Drones[i].HealthVal = math.Approach( self.Drones[i].HealthVal, self.DroneMaxHealth, self.DroneHealthIncrement )
					self.Drones[i].Sauce = math.Approach(self.Drones[i].Sauce,  self.DroneMaxSauce, self.DroneSauceIncrement )
					
				end 
			
			end 
		
		end 
	
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
