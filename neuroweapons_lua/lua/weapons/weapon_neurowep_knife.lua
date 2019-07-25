AddCSLuaFile()

SWEP.HoldType = "melee"
SWEP.IronSightHoldType = "revolver"

if CLIENT then
   SWEP.PrintName = "Knife"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Melee"

SWEP.Spawnable = true

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.5
SWEP.Primary.Cone = 0.010

SWEP.Primary.ClipSize = 0
SWEP.Primary.ClipMax = 0
SWEP.Primary.DefaultClip = 0

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "batman"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "weapons/knife/knife_slash1.wav" )
SWEP.Secondary.Automatic = false 

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 60
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel	= "models/weapons/w_knife_t.mdl"

SWEP.HeadshotMultiplier = 2.2

function SWEP:CanPrimaryAttack()
return true 
end 

function SWEP:SecondaryAttack(worldsnd)
	
	if( self.LastAttack && self.LastAttack + 1.25 >= CurTime() ) then return end 
   self:SetNextSecondaryFire( CurTime() + 1 )
   self:SetNextPrimaryFire( CurTime() + ( self.Primary.Delay or 0 ) )
   
   if not self:CanSecondaryAttack() then return end

	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if SERVER then

		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel )
		
   end 
   
	self:PrimaryAttack( false )
	self.LastAttack = CurTime()

end

	
function SWEP:Think()
	
	-- if( self.LastHit && self.LastHit + .25 >= CurTime() ) then 
		
		-- self.LastHit = nil 
		
		
		
	
	-- end 
	
	
end 


function SWEP:PrimaryAttack( primary )

   self:SetNextSecondaryFire( CurTime() + ( self.Secondary.Delay or 0 ) )
   self:SetNextPrimaryFire( CurTime() + ( self.Primary.Delay or 0 ) )
   
   if not self:CanPrimaryAttack() then return end

	self:SendWeaponAnim(self.PrimaryAnim)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if SERVER then

		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel )
		
   end 
	
	local hit = false 
	local result = nil 
	for i=1,12 do 
		
		local tr,trace = {},{}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = tr.start + self.Owner:GetAimVector() * (42 + ( math.sin(i/4)*10 ) ) + self.Owner:GetUp() *( 8+( -4 * i ) ) + self.Owner:GetRight() * ( 16 + ( i * -4 ) )
		tr.mask = MASK_SOLID
		tr.filter = { self, self.Owner }
		trace = util.TraceLine( tr )
		if( trace.Hit ) then 
			
			result = trace 
			local effectdata = EffectData()
			effectdata:SetOrigin( trace.HitPos )
			effectdata:SetStart( trace.HitNormal )
			effectdata:SetNormal( trace.HitNormal )
			effectdata:SetMagnitude( 1 )
			effectdata:SetScale( self.ImpactScale or 0.45 )
			effectdata:SetRadius( 1 )
				effectdata:SetScale( 0.35 )
		   if trace.HitWorld and trace.MatType == MAT_METAL then
				util.Effect( "micro_he_impact_plane", effectdata )
				self:EmitSound("physics/metal/metal_solid_impact_hard"..math.random(4,5)..".wav", 511, 100 )
			elseif( trace.Entity && ( trace.Entity.IsBodyPart || trace.Entity:IsPlayer() || trace.Entity:IsNPC() ) && trace.MatType != MAT_METAL ) then 
				effectdata:SetScale( 0.5 )
				util.Effect( "micro_he_blood", effectdata )
				if( primary == false ) then 
					self:EmitSound("weapons/knife/knife_stab.wav", 511, 100 )
				else 
					self:EmitSound("weapons/knife/knife_hit"..math.random(1,5)..".wav", 511, 100 )
				end 
			else
				util.Effect( "micro_he_impact", effectdata )
				self:EmitSound("weapons/knife/knife_hitwall1.wav", 511, 100 )
			end
			
			if( SERVER ) then 
			
				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner )
				dmg:SetInflictor( self )
				if( primary == false ) then 
					dmg:SetDamage( 25 )
				else 
					dmg:SetDamage( self.Primary.Damage )
				end 
				dmg:SetDamageType( DMG_SLASH )
				dmg:SetDamagePosition( trace.HitPos )
				dmg:SetDamageForce( self.Owner:GetAimVector() * 50 )
				util.BlastDamageInfo( dmg, trace.HitPos, 1 )
			
			end 
		end 
		
		-- debugoverlay.Line( tr.start, trace.HitPos, 2, Color(255,0,0,255), true )
	end 
	
	self.LastAttack = CurTime()
	
	if( hit && result ) then
		-- self.LastHit = CurTime() 
		-- self.LastTraceRes = result 
	end 
	
end