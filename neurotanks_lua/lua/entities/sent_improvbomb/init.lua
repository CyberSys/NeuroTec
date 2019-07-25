
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 5
ENT.Destroyed = false
PrecacheParticleSystem("tank_gore")

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 32
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "sent_improvbomb" )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():Wake()
	ent.Owner = ply
	
	ply:PrintMessage( HUD_PRINTCENTER, "Press Use to activate proximity trigger" )
	
	return ent
	

end

function ENT:Initialize()
	
	local JunkModels = {
	"models/props_c17/tv_monitor01.mdl",
	"models/props_c17/SuitCase_Passenger_Physics.mdl",
	"models/props_c17/SuitCase001a.mdl",
	"models/props_c17/furnitureWashingmachine001a.mdl",
	"models/props_lab/monitor01a.mdl",
	"models/props_vehicles/carparts_wheel01a.mdl",
	"models/props_wasteland/gaspump001a.mdl",
	"models/props_lab/kennel_physics.mdl",
	"models/props_wasteland/controlroom_filecabinet001a.mdl",
	"models/props_c17/gravestone002a.mdl",
	"models/props_combine/breenchair.mdl"
	
	}
	
	self:SetModel( JunkModels[math.random(1,#JunkModels)] )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin( 4 )
	
	self.Active = false
	
end

function ENT:Use( ply, ent )
	
	if( !self.Active ) then
	
		self.Active = true
		self.Owner = ply
		ply:PrintMessage( HUD_PRINTCENTER, "Bomb Activated." )
		
	end

end

function ENT:OnRemove()
	
	self:DoExplosion()

end

function ENT:Think()
	
	if( self.Active ) then
		
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 150 ) ) do
			
			if( v != self.Owner && ( v:IsPlayer() || v:IsNPC() || v.TankType != nil ) ) then
				
				self:DoExplosion()
				
				break
			
			end
		
		end
	
	end

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
	self:EmitSound( "npc/turret_floor/active.wav", 150, 100 )
	
	timer.Simple( math.Rand( 0.6, 1.5 ), 
	function() 
		
		if(IsValid( self ) ) then
		
			util.BlastDamage( self, self.Owner, self:GetPos(), 255, math.random( 350, 1500 ))
	
			ParticleEffect("HE_impact_dirt", self:GetPos() + Vector( math.random(-32,32),math.random(-32,32),5 ), Angle( 0,0,0 ), NULL )
		
			self:EmitSound("ambient/explosions/explode_1.wav",511,100)
			
			self:Remove()
			
		end
	
	end )
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.1 && data.Speed > 255 ) then
		
		
		self:DoExplosion()
		
	end
	
end
