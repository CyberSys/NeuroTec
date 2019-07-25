AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Wingman HE .44"
    SWEP.Slot = 3
end
SWEP.Category = "NeuroTec Weapons - Pistols"
SWEP.Author = "Smithy285, Hoffa & Killstr3aKs"
SWEP.Contact = ""
SWEP.Purpose = "Mouse 1: Fire Flechette\n Mouse 2: Detonate"
SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true 
SWEP.AdminOnly = false 
SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/killstr3aks/c_wingman.mdl"
SWEP.WorldModel = "models/killstr3aks/w_wingman.mdl"
SWEP.HoldType = "revolver"
 -- SWEP.IronSightHoldType = "revolver"
-- Primary Fire Attributes --
SWEP.Primary.Recoil         = 7
SWEP.Primary.Damage         = 150
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 6
SWEP.Primary.DefaultClip    = 6
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= .4
SWEP.Primary.Sound = Sound( "Weapon_Deagle.Single" )

-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 85
SWEP.Secondary.NumShots      = 1
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo 		 = "none"
SWEP.Secondary.Delay 		= 1

SWEP.PhysBulletEnable = true 
SWEP.Primary.PhysAmmoType = "sent_neuro_h44_flechette"
SWEP.PhysBulletPropType = "sent_neuro_h44_flechette"
SWEP.BulletForce = 10000
SWEP.HasLockonSystem = true 

SWEP.Scoped = false
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material(  "scope/javelinscope.png" )
SWEP.ScopeTexture2 = Material( "scope/javelinscope.png" )
SWEP.ScopeTextureScale = 1.0
SWEP.ScopeUseTextureSize = false 
SWEP.ImpactForce = 50000000

function SWEP:PostDraw()

end 

function SWEP:PreDraw()

end 	