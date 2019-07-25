AddCSLuaFile()

SWEP.HoldType = "shotgun"

if CLIENT then
   SWEP.PrintName = "M61 Vulcan Minigun"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - MGs"

SWEP.Spawnable = true

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.025
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 500
SWEP.Primary.ClipMax = 500
SWEP.Primary.DefaultClip = 500

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Recoil = 0.45
SWEP.Primary.Sound = Sound("Vulcan.Single")
SWEP.Tracer = "AR2Tracer"
SWEP.CSMuzzleFlashes = true 
SWEP.CSMuzzleX = true 
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/v_minigunvulcan.mdl"
SWEP.WorldModel = "models/weapons/w_m134_minigun.mdl"

SWEP.HeadshotMultiplier = 2.2
function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end
   if ( self:GetNetworkedBool( "reloading" ) ) then return false end
   
   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   
	if( !self.Owner:IsNPC() && self.Spinup < self.FullSpun ) then return false end 
	
   return true
end

function SWEP:Think()
	
	if( !IsValid( self.Owner ) ) then return end 
	if( self.Owner:KeyDown( IN_ATTACK ) ) then 
		
		if( !self.SpinupSound ) then 
			
			self.SpinupSound = CreateSound( self, "weapons/minigun/spinup.mp3" )
			self.Spinup = 0
			self.FullSpun = 150 
			
		end 
		
		if(  !self.SpinupSound:IsPlaying() ) then 
			
			self.SpinupSound:Play()
		
		else 
			
			self.Spinup = math.Approach( self.Spinup, self.FullSpun, 5 )
			-- print( self.Spinup )
			if( self.Spinup == self.FullSpun ) then 
				
				-- if( !self.Owner:KeyDown( IN_ATTACK2 ) ) then 
				
				self.SpinupSound:Stop()
				
				-- end 
				
			end 
			
		end 
	else 
		
		self.Spinup = 0 
		if( self.SpinupSound ) then 
				
			self.SpinupSound:Stop()
				
		end 
		
	end 

end 

-- function SWEP:Initialize()
	
	// making me miss super() calls 
	-- self.BaseClass.Initialize()
	
	-- self.SpinupSound = CreateSound( self, "weapons/minigun/spinup.mp3" )

	
	
-- end 
-- SWEP.IronSightsPos = Vector(-2.215, -2.116, 2.36)
-- SWEP.IronSightsAng = Vector(-0.13, 0.054, 0)
