AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Explosive Plane"
    SWEP.Slot = 3

end

SWEP.Category = "NeuroTec Weapons - Launchers"
SWEP.Author = "Hoffa"
SWEP.Contact = ""
SWEP.Purpose = "Dispenses Airplanes"
SWEP.Instructions = "Take out those pesky.. everything!"

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminOnly = false 

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 65
SWEP.SequentialReload = false 
SWEP.ViewModel = "models/killstr3aks/c_javelin.mdl"
SWEP.WorldModel = "models/radek/neuroplanes/rus/il_2/il2.mdl"
 SWEP.HoldType = "rpg"
 SWEP.IronSightHoldType = "rpg"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 0
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "Big Dongs"
SWEP.Primary.Delay 			= 0.5
SWEP.Primary.Sound = Sound( "")

-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots      = 0
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = true
SWEP.Secondary.Ammo 		 = "none"
SWEP.Secondary.Delay 		= 1

SWEP.PhysBulletEnable = true 
-- SWEP.Primary.PhysAmmoType = "sent_neuro_bigknife"
SWEP.PhysBulletPropType = "sent_interceptor"
SWEP.BulletForce = 1255
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
SWEP.ImpactForce = 1000
SWEP.GravityEnabledOnShells = true 


function SWEP:SecondaryAttack()
	
	if( !IsValid( self.Owner ) ) then return end 
	local vel = self.Owner:GetVelocity()
	-- vel.z = 0 
	local le = vel:Length()
	local dot = self.Owner:GetAimVector():Dot( vel:GetNormalized() )
	-- print(  )
	if(  dot > .5 && le < 1000 && self.Owner:EyeAngles().p > -45 ) then 
		-- self.Owner:SetVelocity(   )
		self.Owner:SetVelocity( self.Owner:GetAimVector() * 55 + Vector( 0, 0, le/20 ) )
	end 
	-- if(  ) then 
		
	-- end 
	
end 

local ValidPlanes = {
"models/killstr3aks/neuroplanes/american/f2a_buffalo.mdl",
"models/killstr3aks/neuroplanes/american/p23.mdl",
"models/killstr3aks/neuroplanes/german/ar_65.mdl",
"models/killstr3aks/neuroplanes/german/he112.mdl",
"models/killstr3aks/neuroplanes/german/he_51.mdl",
"models/killstr3aks/neuroplanes/russian/i16.mdl",
"models/radek/neuroplanes/rus/il_2/il2.mdl",
"models/killstr3aks/neuroplanes/german/me410.mdl"
}

-- local planeModels = 
function SWEP:Initialize()
	-- self.WorldModel = ValidPlanes[math.random(1,#ValidPlanes)]
	if( self.Silenced ) then  
		self.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED
		self.ReloadAnim = ACT_VM_RELOAD_SILENCED
	end 
   if CLIENT and self:Clip1() == -1 then
      self:SetClip1(self.Primary.DefaultClip)
   elseif SERVER then
      self.fingerprints = {}
      if( self.ComplexSound ) then 
			self.ShootSound = CreateSound( self, self.Primary.Sound )
      end 
      self:SetIronsights(false)
   end
   self:SetDeploySpeed(self.DeploySpeed)
	if (SERVER) then
		self:SetNPCFireRate(self.Primary.Delay)
		self:SetNPCMaxBurst( 10 )
	end
	self:SetHoldType( self.HoldType )
   if self.PhysBulletEnable then
      self.LastAttack = CurTime() - 5
   end
   self.RicochetSound = Sound( "weapons/fx/rics/ric4.wav" )
end

-- SWEP.IronSightsPos = Vector(-5.12, 0, 3.239)
-- SWEP.IronSightsAng = Vector(0, 0, 0)

// Call everytime a physical bullet is launched 
function SWEP:SwepPhysbulletCallback( bullet ) 
	
	-- bullet:EmitSound("vehicles/airboat/fan_motor_start1.wav", 511, 100 )
	-- bullet.MinDamage = 550
	-- bullet.MaxDamage = 750
	-- bullet.Radius = 128
	bullet:SetAngles( bullet:GetAngles() + AngleRand() * .005 )
	bullet:SetModel( self.WorldModel )
	bullet.owner = self.Owner
	bullet.Started = true
	bullet.Sauce = 10000
	bullet.PhysObj:EnableMotion(true)
	bullet.PhysObj:Wake()
	bullet.AnnoyingEngineSound:PlayEx( 511, 100 )
	bullet.Speed = 1200
	if( self.EngineLoop ) then 
		self.EngineLoop:FadeOut( 1,1 )
	end 
	
	-- local newRag = ents.Create("prop_ragdoll")
	-- newRag:SetPos( self.Owner:GetPos() )
	-- newRag:SetAngles( self.Owner:GetAngles() )
	-- newRag:SetModel( self.Owner:GetModel() )
	-- newRag:Spawn()
	-- newRag:Activate()
	-- newRag:Fire("kill","",15)
	-- newRag:SetSkin( self.Owner:GetSkin() )
	-- newRag:SetRenderMode( RENDERMODE_TRANSALPHA )
	-- newRag.GetPlayerColor = function( )
		-- return IsValid( self.Owner ) and self.Owner:GetPlayerColor() or Vector(1,1,1)
	-- end		
	
	bullet:EmitSound("icanfly.mp3",511, 100 )
	
	-- self.Owner:CopyAllBoneAngles( newRag  )
	-- bullet:SetOwner( newRag )
	-- newRag:GetPhysicsObject():SetMass( 5 ) 
	-- newRag:GetPhysicsObject():EnableGravity( false )
	-- newRag:GetPhysicsObject():SetVelocity( bullet:GetVelocity() )
	-- for i=0,newRag:GetPhysicsObjectCount()-1 do 
		-- local obj = newRag:GetPhysicsObjectNum( i )
		-- obj:EnableGravity( false )
		-- obj:EnableDrag( true )
		-- obj:SetMass( 1 ) 
		-- obj:SetVelocity( bullet:GetPhysicsObject():GetVelocity() )
	-- end 
	-- bullet:DeleteOnRemove( newRag )
	-- local bone = newRag:LookupBone("ValveBiped.Bip01_Head1")
	-- local bp,ba = newRag:GetBonePosition( bone )
	-- constraint.Rope( bullet, newRag, 0, bone, Vector(), Vector(),256, 0, 0, 2, "cable/rope", false )
	-- timer.Simple( 1, function() 
	
	-- self.Owner:Spectate( OBS_MODE_CHASE )
	-- self.Owner:SpectateEntity( newRag )
	-- local owner = self.Owner 
	-- local b = bullet 
	-- local idx = b:EntIndex() 
	-- local lastpos = b:GetPos()
	-- owner:D( false )
	-- hook.Add("Think", "UndoPlaneChaseCam"..idx, function()
		
		-- if( !IsValid( newRag ) ) then 
			-- owner:UnSpectate()
			-- owner:SetPos( lastpos )
			-- owner:Kill()
			-- owner:DrawViewModel( true )
			-- hook.Remove("Think", "UndoPlaneChaseCam"..idx )
		-- else 
			-- lastpos = newRag:GetPos()
			-- owner:SetPos( lastpos )
		-- end 
		
	-- end )
	
	-- end )
	
	self.Owner:StripWeapon( self:GetClass() )
	
	
end 

function SWEP:ClientAttackCallback()
	
	-- ParticleEffect(  "tank_muzzleflash", self.Owner:GetShootPos(), self.Owner:EyeAngles(), self.Owner )
	
end 

SWEP.Pos = Vector(0, 6, 2)
SWEP.Ang = Angle(0, -180, 0)
function SWEP:PreDrawViewModel( vm, weapon, ply )
	-- print(weapon )
	-- if( !IsValid( self.SpinnyThingy ) ) then 
		-- self.SpinnyThingy = ClientsideModel( "models/killstr3aks/neuroplanes/russian/I17_propeller.mdl", RENDER_GROUP_VIEW_MODEL_OPAQUE)
		-- self.SpinnyThingy:SetParent( vm )

	-- end 
	-- if( self.SpinnyThingy ) then 

		-- local a = self.SpinnyThingy:GetAngles()
		-- a:RotateAroundAxis( vm:GetForward(), 1 )
		-- self.SpinnyThingy:SetRenderAngles( a )
		-- self.SpinnyThingy:SetPos( vm:LocalToWorld( Vector( 12.5, -11.15, -6.5 ) ) )
	-- end 
	
	vm:SetAngles( self.Owner:EyeAngles() + Angle(0,0,0) )
	vm:SetPos( vm:GetPos() + vm:GetForward() * 25  + vm:GetRight() * 15 + vm:GetUp() * -10)
	vm:SetModel( self.WorldModel )
	-- print( vm )
end 
function SWEP:CreateVisualViewModel( vm, bone  )
	if( !self.VisualViewModel ) then 
		
		self.VisualViewModel = ClientsideModel( self.WorldModel, RENDER_GROUP_VIEW_MODEL_OPAQUE)
		self.VisualViewModel:SetParent( vm )
		-- self.VisualViewModel:Fire("SetParentAttachmentMaintainOffset", bone )
	end 
	
	return self.VisualViewModel 
end 
function SWEP:Think()
	
	if CLIENT then return end 
	if( self.EngineLoop && self.Owner:KeyDown( IN_ATTACK2 ) ) then 
		
		self.EngineLoop:Play()
		
	else	
		self.EngineLoop:Stop()
		
	end 
	
	if SERVER then 
		local velo = self.Owner:GetVelocity()
		if( velo.z < 0 ) then 
			self.Owner:SetVelocity( self.Owner:GetAimVector() * math.Clamp( math.abs( velo.z ), 0, 5 ) + Vector(0,0,math.abs(velo.z/50) ) )			
		end 
		
		if( self.Owner:KeyDown( IN_RELOAD ) ) then 
		
			if( !self.LastAttack ) then self.LastAttack = 0 end 
			if( self.LastAttack + self.Primary.Delay >= CurTime() ) then return end 
			self.LastAttack = CurTime()
			
			local bullet = ents.Create( "sent_mini_shell" )
			bullet:SetPos( self.Owner:GetShootPos() + self.Owner:GetUp() * -6 + self.Owner:GetRight() * 8)
			bullet:SetAngles( self.Owner:EyeAngles() + AngleRand() * .0025 )
			bullet.TinyTrail = true
			bullet.TracerScale1 = .2
			bullet.TracerScale2 = .2
			bullet.ImpactScale = 1
			bullet.TracerGlowProxy = .2
			bullet:Spawn()
			bullet.MinDamage = 15
			bullet.MaxDamage = 25
			bullet.Radius = 62
			bullet:SetPhysicsAttacker( self.Owner, 99999999 )
			bullet:SetOwner( self.Owner )
			bullet.Owner = self.Owner
			bullet:GetPhysicsObject():SetMass( 5 )
			bullet:GetPhysicsObject():SetDamping( 0,0 )
			bullet:GetPhysicsObject():SetVelocity( self.Owner:GetAimVector() * 5000000 )
			bullet:SetNoDraw( true )
			self.Owner:EmitSound("wt/guns/m4_singleshot.wav", 511, 100 )
			ParticleEffect( "microplane_MG_muzzleflash", bullet:GetPos(),  bullet:GetAngles(), bullet )		
				
		
		end 
	
	end 
	
end 

function SWEP:Deploy()

	if( !self.EngineLoop ) then 
		self.EngineLoop = CreateSound( self.Owner, "npc/manhack/mh_engine_loop2.wav" )
	end 
	
return true 
end 
function SWEP:Holster()
	if( IsValid( self.VisualViewModel ) ) then 
		self.VisualViewModel:Remove()
		self.VisualViewModel = nil 
	end 
	if( self.EngineLoop ) then 
		self.EngineLoop:Stop()
	end 
	if( IsValid( self.WModel ) ) then 
		self.WModel:Remove()
	end 
	-- print("u wot mate")
	return true 
end
 
 
function SWEP:CreateWorldModel()
   if !IsValid( self.WModel ) then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
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