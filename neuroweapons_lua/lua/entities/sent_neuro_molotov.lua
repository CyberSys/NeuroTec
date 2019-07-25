AddCSLuaFile()

ENT.PrintName = "Molotov Cocktail"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Weapons"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false
local fireDuration = 1 

ENT.HealthVal = 50 -- missile health
ENT.Model = "models/weapons/w_molotov.mdl" -- 3d model	
local Junks = { 
	"models/props_junk/garbage_glassbottle003a_chunk01.mdl",
	"models/props_junk/garbage_glassbottle003a_chunk02.mdl",
	"models/props_junk/garbage_glassbottle003a_chunk02.mdl",
	"models/props_junk/garbage_glassbottle003a_chunk03.mdl"
}

ENT.EngineSoundPath = "missile.accelerate" -- Engine sound, precached or string filepath.
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )
ENT.Damage = 250 

if CLIENT then 

	function ENT:Draw()
		self:DrawModel()
	end 
	
end 

if( SERVER ) then 

	function ENT:Use( ply, caller, blah, bleh ) 

		return 
		
	end 	
	function ENT:OnTakeDamage( dmg )
	
	end 

	
	function ENT:PhysicsCollide( data )
		
		if( data.DeltaTime < .2 ) then return end 
		
		if( !self.Bounced ) then 	
			
			self:EmitSound("physics/glass/glass_bottle_impact_hard"..math.random(1,3)..".wav", 511, 100 )
			self.Bounced = true 
			self:SetVelocity( data.OurOldVelocity ) 
			
			return 
			
		end 
		
		self:EmitSound("ambient/fire/gascan_ignite1.wav", 511, 100 )
		
		for i=1,#Junks do 
			
			local prop = ents.Create("prop_physics")
			prop:SetPos( self:GetPos() )
			prop:SetAngles( self:GetAngles() )
			prop:SetOwner( self.Owner )
			prop:SetModel( Junks[i] )
			prop:Spawn()
			prop:Fire("kill","",15)
			prop:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() )
			prop:SetPhysicsAttacker( self.Owner )
			prop:Ignite( 15, 1 )
			prop:SetNWBool("NeuroNetFire", true )

			local hookName = "NeuroWeapon_FireDamage"..prop:EntIndex()
						
			ParticleEffectAttach( "fireplume_small", PATTACH_ABSORIGIN_FOLLOW, prop, 0 )
			ParticleEffect( "neuro_gascan_explo_air", self:GetPos(), Angle(0,0,0), nil )
			ParticleEffect( "Explosion", self:GetPos(), Angle(0,0,0), nil )
					
			prop:EmitSound( "physics/glass/glass_bottle_break"..math.random(1,2)..".wav", 511, 100 )
						
			-- append our burning function to the newly spawned props
			hook.Add("Think",hookName, function() 
											if( IsValid( prop ) ) then 
												for k,v in pairs( ents.FindInSphere( prop:GetPos(), 100 ) ) do
													if( ( !v.LastIgnite || ( v.LastIgnite && v.LastIgnite + fireDuration <= CurTime( ) ) ) && IsValid( v ) && ( v.Alive == nil || ( v:IsPlayer() && v:Alive( ) ) ) ) then 
														
														v.LastIgnite = CurTime() 
														
														v:Ignite( fireDuration, 72 )
														
													end 
													
												end 
											else
												hook.Remove("Think", hookName )
											end 
										end ) 
			
	
		end 
		
		self:Remove()
		
		
	end 
	
	function ENT:Think()
		if( !self.Ticker ) then 
			self.Ticker = CurTime()
			util.SpriteTrail( self, 0, Color( 255,255,255,35 ), false, 4, 2, 2, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
			self:EmitSound("ambient/fire/mtov_flame2.wav", 511, 100 )
			self:Ignite( 25, 0 )
			
		end 
		if( CurTime() - self.Ticker > 2 ) then 
			
		
		end 
		
	end 

end 
