
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 15
ENT.Destroyed = false
PrecacheParticleSystem("tank_gore")

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "sent_cowbomb" )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():Wake()
	ent.Owner = ply

	return ent
	

end

function ENT:Initialize()
	-- print( "WHY?") 
	self:SetModel( "models/props_farm/cow_dead2.mdl" )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin( 4 )

end

function ENT:Use( ply, ent )
	

end

function ENT:OnRemove()
	
	-- self:DoExplosion()

end

function ENT:Think()
	

end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		self.Owner = dmginfo:GetAttacker()
		
	else
	
		self:DoExplosion()
		
	end
	
end

function ENT:DoExplosion()
	
	if( self.Sploded ) then return end
	
	self.Sploded = true
	
	self:EmitSound( "highlander/cow.mp3", 150, 100 )
	
	timer.Simple( 1.5, 
	function() 
		
		if(IsValid( self ) ) then
			
			if( !IsValid( self.Owner ) ) then self.Owner = self end
			
			util.BlastDamage( self, self.Owner, self:GetPos(), 256, math.random( 1500, 2500 ))
			
			local fx = EffectData()
			fx:SetOrigin( self:GetPos() )
			util.Effect("Explosion", fx )
			
			for i=1,3 do
				
				ParticleEffect("tank_gore", self:GetPos() + Vector( math.random(-32,32),math.random(-32,32),5 ), Angle( 0,0,0 ), NULL )
				
			end
			
			self:EmitSound( "physics/flesh/flesh_squishy_impact_hard3.wav", 511, 100 )
			
			timer.Simple( 0.5, function() if( IsValid( self ) ) then self:Remove() end end )
			
		end
		
	end )
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.1 && data.Speed > 55 ) then
		
		-- self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
		self:DoExplosion()
		
	end
	
end
