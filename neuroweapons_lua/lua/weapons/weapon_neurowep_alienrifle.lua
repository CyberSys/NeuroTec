AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Alien Rifle"
    SWEP.Slot = 3
		
	surface.CreateFont( "NeuroTec_Javelin", {
		font = "BOMBARD_",
		size = 45,
		weight = 100,
	} )


end

SWEP.Category = "NeuroTec Weapons - Rifles"
SWEP.Author = "Hoffa"
SWEP.Contact = ""
SWEP.Purpose = "Dispenses Alien Stuff"
SWEP.Instructions = "Take out those pesky hoomans!"

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminOnly = false 

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 65
SWEP.SequentialReload = false 
SWEP.ViewModel = "models/weapons/v_laserrifle.mdl"
SWEP.WorldModel = "models/weapons/w_laserrifle.mdl"
 SWEP.HoldType = "shotgun"
 SWEP.IronSightHoldType = "rpg"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 1
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 3
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 20
SWEP.Primary.DefaultClip    = 20
SWEP.Primary.Automatic      = true    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= 0.35
SWEP.Primary.Sound = Sound( "npc/vort/attack_shoot.wav")

-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots      = 0
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo 		 = "none"
SWEP.Secondary.Delay 		= 1

SWEP.PhysBulletEnable = true 
-- SWEP.Primary.PhysAmmoType = "sent_neuro_bigknife"
SWEP.PhysBulletPropType = "sent_alien_shell"
SWEP.BulletForce = 1900110
-- SWEP.HasLockonSystem = true 

-- EFfect Overrides
SWEP.Tracer = "neuro_railbeam"
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1.45
SWEP.NoLines = true 

SWEP.Scoped = false
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material(  "scope/javelinscope.png" )
SWEP.ScopeTexture2 = Material( "scope/javelinscope.png" )
SWEP.ScopeTextureScale = 1.0
SWEP.ScopeUseTextureSize = false 
SWEP.ImpactForce = 11000000
SWEP.GravityEnabledOnShells = false 

SWEP.IronSightsPos = Vector(-5.12, 0, 1.239)
SWEP.IronSightsAng = Vector(0, 0, 0)

// Call everytime a physical bullet is launched 
function SWEP:SwepPhysbulletCallback( bullet ) 
	
	bullet.MinDamage = 45
	bullet.MaxDamage = 55
	bullet.Radius = 64
	-- bullet.HasShockwave = true 
	
	-- local Glow = ents.Create("env_sprite")				
	-- Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
	-- Glow:SetKeyValue("rendercolor","175 175 255")
	-- Glow:SetKeyValue("scale",tostring(.125))
	-- Glow:SetPos(bullet:GetPos())
	-- Glow:SetParent(bullet)
	-- Glow:Spawn()
	-- Glow:Activate()

	-- local Shine = ents.Create("env_sprite")
	-- Shine:SetPos(bullet:GetPos())
	-- Shine:SetKeyValue("renderfx", "0")
	-- Shine:SetKeyValue("rendermode", "5")
	-- Shine:SetKeyValue("renderamt", "255")
	-- Shine:SetKeyValue("rendercolor", "195 195 255")
	-- Shine:SetKeyValue("framerate12", "20")
	-- Shine:SetKeyValue("model", "light_glow01.spr")
	-- Shine:SetKeyValue("scale", tostring( .251 ) )
	-- Shine:SetKeyValue("GlowProxySize", tostring( .25 ))
	-- Shine:SetParent(bullet)
	-- Shine:Spawn()
	-- Shine:Activate()
	
	-- util.SpriteTrail( bullet, 0, Color( 255,0,0,255), false, 16, 0, 1, .25, "effects/ex_smoketrail" )

end 

SWEP.Pos = Vector(18, 6, 1)
SWEP.Ang = Angle(0, -180, 90)

function SWEP:CreateWorldModel()
   if not self.WModel then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
   -- print("whot")
   return self.WModel
end

function SWEP:DrawWorldModel()
	if( !IsValid( self.Owner ) ) then return end 
   local wm = self:CreateWorldModel()
   
   local bone = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
   local pos, ang = self.Owner:GetBonePosition(bone)
		
   if bone then
      ang:RotateAroundAxis(ang:Right(), self.Ang.p)
      ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
      ang:RotateAroundAxis(ang:Up(), self.Ang.r)
      wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
      wm:SetRenderAngles(ang)
      wm:DrawModel()
   end
end