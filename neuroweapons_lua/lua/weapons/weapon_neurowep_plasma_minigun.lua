AddCSLuaFile()

SWEP.HoldType = "crossbow"

if CLIENT then
   SWEP.PrintName = "RBS-80 Pulse Gun"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base_ent"
SWEP.Category = "NeuroTec Extra Weapons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.Cone = 0.014

SWEP.DrawCrosshair		= false
SWEP.Primary.ClipSize = 500
SWEP.Primary.ClipMax = 1225
SWEP.Primary.DefaultClip = 250

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Sound = Sound( "Neuro_Laser.Single" )
SWEP.Primary.Delay = 0.1

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/c_terminator_minigun.mdl"
SWEP.WorldModel = "models/weapons/w_terminator_minigun.mdl" --models/weapons/w_terminator_gun.mdl
SWEP.Tracer = "tracerA"
SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(0.6, 0, 3.24)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:PrimaryAttack()

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

	if( self.Owner:WaterLevel() > 0 ) then 
return
end

	  if ( self.LastAttack or 0 + self.Primary.Delay <= CurTime() ) then

      self.LastAttack = CurTime()
         
		if( self:Clip1() <= 0 ) then 
		self:Reload() 
		return false 
		end
		
if SERVER then
	
local e = ents.Create("sent_laser_projectile")
		
e:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 30 )
e:SetAngles( self.Owner:EyeAngles() )
e:SetOwner(self.Owner);
	
e.Owner = self.Owner;
	
e:Spawn();
	
e:Activate();

			self.Owner:EmitSound(  "weapons/plasmagunshot.wav", 511, 100)
			
		end
end		
		
		self.Weapon:TakePrimaryAmmo( 1 )
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
	
