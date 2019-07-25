AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "M-27 Pulse Rifle"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base_ent"
SWEP.Category = "NeuroTec Extra Weapons"

list.Add("NPCUsableWeapons", {class = "weapon_neurowep_plasma", title = SWEP.PrintName or ""});

SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.Damage = 5
SWEP.Primary.Cone = 0.014

SWEP.DrawCrosshair		= false
SWEP.Primary.ClipSize = 125
SWEP.Primary.ClipMax = 125
SWEP.Primary.DefaultClip = 125

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Sound = Sound( "Neuro_Laser.Single" )
SWEP.Primary.Delay = 0.2

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/v_terminator_gun.mdl"
SWEP.WorldModel = "models/weapons/w_terminator_gun.mdl"
SWEP.Tracer = "tracerA"
SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-6.2, -3.891, 2.439)
SWEP.IronSightsAng = Vector(0, 0, 0)

--################### Init the SWEP @aVoN
function SWEP:Initialize()
	-- Set holdtype, depending on NPCs, so it doesn't look too strange
	timer.Simple(0.2,
		function()
			if(not (IsValid(self) and self.SetWeaponHoldType)) then return end;
			if(self.Owner and self.Owner:IsValid() and self.Owner:IsNPC()) then
				local class = self.Owner:GetClass();
				if(class ~= "npc_metropolice") then
					self:SetWeaponHoldType("ar2");
				end
			end
		end
	);
	self:SetWeaponHoldType(self.HoldType);
end

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
--e:SetAngles( self.Weapon:GetAngles() )
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
	
