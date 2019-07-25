
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()
self.Speed = 555250
	self:SetModel("models/sillirion/projectiles/laserproj01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self:DrawShadow(false)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
        phys:SetVelocity( self:GetForward() * self.Speed )
	end
	
	local glow = ents.Create("env_sprite")
	glow:SetKeyValue("rendercolor","163 73 164")
	glow:SetKeyValue("GlowProxySize","2")
	glow:SetKeyValue("HDRColorScale","1")
	glow:SetKeyValue("renderfx","14")
	glow:SetKeyValue("rendermode","3")
	glow:SetKeyValue("renderamt","100")
	glow:SetKeyValue("model","sprites/flare1.spr")
	glow:SetKeyValue("scale","1.5")
	glow:Spawn()
	glow:SetParent(self)
	glow:SetPos(self:GetPos())
	
end

function ENT:Think()

	local phys = self:GetPhysicsObject();
	if IsValid(phys) then 
	phys:Wake();
	end

-- if glow have not the right color with the textures, automatic change of the glowing color to match the new texture
 if( self:WaterLevel() > 0 ) then 
self:Remove() 
return 
end

end

function ENT:PhysicsCollide( data, physobj )

self.Phys = self:GetPhysicsObject();
		if(self.Phys and self.Phys:IsValid()) then
			self.Phys:SetMass(1);
		end
		self:PhysicsInitSphere(1,"metal");
		self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
		
	local start = data.HitPos + data.HitNormal
    local endpos = data.HitPos - data.HitNormal
	util.Decal("fadingscorch",start,endpos)

	local effectdata = EffectData()
	effectdata:SetAngles(data.HitNormal:Angle())
	effectdata:SetOrigin(endpos)
	util.Effect("cball_bounce", effectdata)
  
if (IsValid( self.Owner ) ) then

local dmg = DamageInfo()
  dmg:SetDamageType( DMG_ENERGYBEAM  )
  dmg:SetDamage( self.Damage or 10 )
  dmg:SetInflictor( self )
  dmg:SetAttacker( self.Entity:GetOwner() )
  util.BlastDamageInfo( dmg, data.HitPos, 50 )

else

local dmg = DamageInfo()
  dmg:SetDamageType( DMG_ENERGYBEAM  )
  dmg:SetDamage( self.Damage or 10 )
  dmg:SetInflictor( self )
  dmg:SetAttacker( self.Entity )
  util.BlastDamageInfo( dmg, data.HitPos, 50 )
	
end
self:Remove();
end
