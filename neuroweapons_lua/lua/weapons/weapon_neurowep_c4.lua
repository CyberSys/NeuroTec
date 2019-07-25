AddCSLuaFile()

SWEP.HoldType = "crossbow"

if CLIENT then
   SWEP.PrintName = "C-4"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.DrawCrosshair = false
SWEP.Base = "weapon_neurowep_base_ent"
SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.ComplexSound = false
SWEP.Primary.CustomMuzzle = "MG_muzzleflash"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false 
SWEP.PhysBulletEnable = true 
SWEP.Primary.PhysAmmoType = "sent_mini_shell"
SWEP.C4Model = "models/weapons/w_c4_planted.mdl"

SWEP.DrawCrosshair		= true

SWEP.Primary.Damage = 7500
SWEP.Primary.Delay = 60
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1
SWEP.HoldType = "slam"

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "slam"
SWEP.Primary.Recoil = 0
SWEP.Primary.PhysRecoil = 1

SWEP.Primary.Sound = Sound("micro/gau8_humm2.wav")
SWEP.Primary.EndSound = Sound("micro/gau8_end_test.wav")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-1.96, -5.119, 4.349)
SWEP.IronSightsAng = Vector(0, 0, 0)
	
function SWEP:PrimaryAttack()
	
	return false 

end 
if( SERVER ) then 
	
	function SWEP:Initialize()
		-- self.BaseClass:Initialize()
		self.PlantTimer = 0 
		
	
	end 
	local c4times = { 5, 10, 15, 20, 25, 30, 35, 40, 45 }
	function SWEP:Reload()
		
		if( !self.CurrentTimerValue ) then 
			self.CurrentTimerValue = 1
			self.LastTimerUpdate = 0 
			
		end 
		
		if( self.LastTimerUpdate + 0.5 >= CurTime() ) then return end 
		self.LastTimerUpdate = CurTime()
		
		if( self.CurrentTimerValue <= #c4times ) then
		
			self.MaxLife = c4times[self.CurrentTimerValue]
			self.Owner:PrintMessage( HUD_PRINTTALK, "C4 Timer: "..self.MaxLife.." seconds" )
			self.CurrentTimerValue = self.CurrentTimerValue + 1 
			
		else 
			
			self.CurrentTimerValue = 1
			
		end 
		
	
	end 
	function SWEP:Holster()
	 self.PlantTimer = 0 
	 self.Planting = false 
	 
	 return true 
	end 
	
	function SWEP:Think()
		
		if( IsValid( self.Owner ) ) then 
			
			if( self.Owner:KeyDown( IN_ATTACK ) || self.Planting ) then 
				if( !self.Planting && IsFirstTimePredicted()  ) then 
				
					self:SendWeaponAnim(self.PrimaryAnim)
					self.Owner:SetAnimation( PLAYER_ATTACK1 )
					self.Planting = true 
					-- self:EmitSound("weapons/c4/c4_click.wav", 100, 100 )
				
				end 
				
				self.PlantTimer = self.PlantTimer + 1 
				
				-- if( self.PlantTimer == 1  ) then 
					
					
				-- end 
				
				-- self.Owner:PrintMessage( HUD_PRINTCENTER, self.PlantTimer )
				if( !self.Planted && self.PlantTimer >= 180 && IsFirstTimePredicted() ) then 
					
					self.Planted = true 
					
					local tr,trace ={},{}
					tr.start = self.Owner:GetShootPos()
					tr.endpos = tr.start + self.Owner:GetAimVector()*64
					tr.filter = { self, self.Owner } 
					tr.mask = MASK_SOLID 
					trace = util.TraceLine( tr ) 
					local a = trace.HitNormal:Angle()
					-- ang:RotateAroundAxis( self:GetUp(), newAng.y )
					a:RotateAroundAxis( self:GetRight(), 90 )
					a:RotateAroundAxis( self:GetForward(), 180 )
					
					
					local c4 = ents.Create("sent_neuro_c4")
					c4:SetPos(  trace.HitPos + trace.HitNormal * 4 )
					c4:SetAngles( a )
					c4:Spawn()
					c4:GetPhysicsObject():Wake()
					c4:GetPhysicsObject():SetMass( 15 )
					-- c4:SetOwner( self.Owner )
					c4.Owner = self.Owner 
					c4:SetPhysicsAttacker( self.Owner, 600 )
					c4.IsPlanted = true 
					c4:EmitSound("weapons/c4/c4_plant.wav", 511, 100 )
					c4.MaxLife = self.MaxLife or 45 
					
					if( trace.Hit && !trace.HitWorld && !trace.Entity:IsPlayer() ) then 
						c4:SetParent( trace.Entity ) 
					end 
					
					self.Owner:EmitSound("radio/bombpl.wav", 511, 100 )
					self.Owner:SwitchToDefaultWeapon()
					self:Remove()
					
				end 
				
			else
					 
				self.Planting = false 
				self.PlantTimer = 0 
				
			end 
		else
				 
			self.Planting = false 
			self.PlantTimer = 0 
					
		end 
	
	end 

else 
	
	function SWEP:Think() end 
	
	local SpriteMat = Material( "sprites/physg_glow2" )
	function SWEP:Draw()
		
		cam.Start3D() 

			render.SetMaterial( SpriteMat ) -- Tell render what material we want, in this case the flash from the gravgun
			render.DrawSprite( self:LocalToWorld( Vector( 3, 1, 10 ) ), 8, 8, Color( 255, 5, 5, 255 ) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.

		cam.End3D()
	end 


end 
