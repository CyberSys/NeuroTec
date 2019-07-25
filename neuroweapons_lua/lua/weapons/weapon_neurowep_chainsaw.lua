AddCSLuaFile()

SWEP.HoldType = "shotgun"

if CLIENT then
   SWEP.PrintName = "Chainsaw"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false

end
function SWEP:Drop()

	
	if( self.IdleSound ) then 
	
		self.IdleSound:Stop()
		self.AttackSound:Stop()
		
	end 
	
end 

function SWEP:PrimaryAttack()

end 

function SWEP:OnRemove()
	
	if( self.IdleSound ) then 
	
		self.IdleSound:Stop()
		self.AttackSound:Stop()
		
	end 
end 

function SWEP:Initialize()
	
	self:SetHoldType( self.HoldType )
	self:SetWeaponHoldType( self.HoldType )
	self.IdleSound = CreateSound( self, "Chainsaw.Idle" )
	self.AttackSound = CreateSound( self, "weapons/arch_chainsaw/chainsaw_attack.wav" )
	self.GrindSound = CreateSound( self, "weapons/arch_chainsaw/chainsaw_die_01.wav" )
	self.Activated = true 

end 

function SWEP:Deploy()
	
	self.Owner:EmitSound("weapons/arch_chainsaw/chainsaw_start_0"..math.random(1,2)..".wav", 511, 100 )
	return true
	
end 

function SWEP:Holster()
	
	if( self.IdleSound ) then 
	
		self.IdleSound:Stop()
		self.AttackSound:Stop()
		
	end 
	
	self.Owner:EmitSound("weapons/arch_chainsaw/chainsaw_die_01.wav", 70, 100 )
	
	return true 
	
end 
function SWEP:Think()
	
	if( self.Activated ) then 
		
		if( self.Owner:KeyDown( IN_ATTACK ) || ( self.Owner:IsBot() && IsValid( self.Owner.Target ) && ( self.Owner:GetPos() - self.Owner.Target:GetPos() ):Length() < 72 ) ) then 
			
			self.IdleSound:Stop()
			self.AttackSound:Play()
			local tr,trace={},{}
			tr.start = self.Owner:GetShootPos() + self.Owner:GetUp() * -4
			tr.endpos = tr.start + self.Owner:GetAimVector() * 72
			tr.filter = { self, self.Owner }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr )
			debugoverlay.Line( tr.start, trace.HitPos, .1, Color(5,255,5,255), true )
			
			if( trace.Hit ) then 
		
				self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
				self.Owner:SetAnimation( PLAYER_ATTACK1 )
				self.Owner:ViewPunch( AngleRand()  * .01)
				local damage = DamageInfo()
				damage:SetAttacker( self.Owner )
				damage:SetDamage( math.random( 1, 15 ) )
				damage:SetDamageForce( self.Owner:GetAimVector() * 500 )
				damage:SetInflictor( self )
				damage:SetDamageType( DMG_SLASH + DMG_aLWAYSGIB )
				damage:SetDamagePosition( trace.HitPos ) 
					
				
				util.BlastDamageInfo( damage, trace.HitPos , 4 )

				local effectdata = EffectData()
				effectdata:SetOrigin( trace.HitPos )
				effectdata:SetStart( trace.HitNormal )
				effectdata:SetNormal( trace.HitNormal )
				effectdata:SetMagnitude( 1 )
				effectdata:SetScale( 0.85 )
				effectdata:SetRadius( 1 )
	
				local mat = trace.MatType
				if( mat == MAT_FlESH || mat == MAT_ALIENFLESH || mat == MAT_BLOODYFLESH ) then 
					
					for i=1,5 do 
						local dir = VectorRand()*128
						util.Decal( "Blood",trace.HitPos + dir, trace.HitPos - dir )
						
					end 
					
					if( SERVER ) then 
					
						self.Owner:NeuroWeapons_SendBloodyScreen()
						if( trace.Entity:IsPlayer() ) then 
							
							trace.Entity.LastChainsawed = CurTime()
							
							if(  !trace.Entity:IsBot() ) then 
							
								trace.Entity:NeuroWeapons_SendBloodyScreen()
							
							end 
							
						end 
						
					end 
					
					self.Owner:EmitSound("npc/manhack/grind_flesh"..math.random(1,3)..".wav", 511, 50 )
					effectdata:SetNormal( VectorRand() )
					effectdata:SetScale( math.Rand( .5, 1.1 ) )
					util.Effect( "micro_he_blood", effectdata )
				
				
				
				elseif( mat == MAT_METAL || mat == MAT_CONCRETE || mat == MAT_COMPUTER || mat == MAT_TILE || mat == MAT_GRATE ) then 
				
					util.Decal( "ManhackCut",trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )
					self.Owner:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav", 511, 100 )
					effectdata:SetScale( .25 )
					util.Effect( "micro_he_impact", effectdata )
					effectdata:SetScale( 2 )
					util.Effect( "ManhackSparks", effectdata )
				
				else
					
					util.Decal( "ManhackCut",trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )
					self.Owner:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav", 511, 100 )
					effectdata:SetScale( .5 )
					util.Effect( "micro_he_impact", effectdata )
				
				end 
			else
				
				-- self.GrindSound:Stop()
			
			end 
			
			
			
		else 
		
			self.AttackSound:Stop()
			self.IdleSound:ChangePitch( 100+math.Rand(-1,1), 1 )
			self.IdleSound:Play()
			self.GrindSound:Stop()
		
		end 
		
		
		
	end 
	
end 
SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Equipment"

SWEP.Spawnable = true
SWEP.AdminSpawnable = false 
SWEP.AdminOnly = true 

SWEP.Primary.Damage = 45
SWEP.Primary.Delay = 0.10
SWEP.Primary.Cone = 0.018

SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "Weapon_aK47.Single" )

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 75
SWEP.ViewModel = "models/weapons/v_chainsaw.mdl"
SWEP.WorldModel	= "models/weapons/w_chainsaw.mdl"

SWEP.DrawAmmo = false
   
SWEP.HeadshotMultiplier = 4.2

-- SWEP.IronSightsPos = Vector(-6.615, -10.563, 4.417)
-- SWEP.IronSightsAng = Vector(2.625, 0, 0)