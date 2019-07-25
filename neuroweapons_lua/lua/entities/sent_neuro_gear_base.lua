AddCSLuaFile()

ENT.PrintName = "Combat Armor Base"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Gear"
ENT.Type = "anim"

-- Max damage before we break
ENT.InitialHealth = 150 
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.BulletProof = true 

ENT.AttachmentBone = "forward"
ENT.HitgroupProtected = HITGROUP_HEAD
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 0.5 = half, 1.0 = full, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( 0, 0,0 )
ENT.AttachmentPos = Vector( -.5,0,0  ) 

if CLIENT then
	
	function ENT:Draw()
		
		local activator = self:GetNWEntity("Owner")
		
		if( IsValid( activator ) ) then
	
			local bone = self.AttachmentBone or "eyes"
			local attachmentId = activator:LookupAttachment( bone ) 
			local attach = activator:GetAttachment( attachmentId )
			local ang = attach.Ang
			local pos = attach.Pos 
		
			local newAng = self.AttachmentAngle 
			ang:RotateAroundAxis( activator:GetUp(), newAng.y )
			ang:RotateAroundAxis( activator:GetRight(), newAng.p )
			ang:RotateAroundAxis( activator:GetForward(), newAng.r )
			local fwd = ang:Forward() * self.AttachmentPos.x 
			local rght = ang:Right() * self.AttachmentPos.y
			local up = ang:Up() * self.AttachmentPos.z 
			local newpos = pos + fwd + rght + up
			self:SetPos( newpos )
			self:SetAngles(ang)
			if( self.ModelScale ) then 
				
				self:SetModelScale( self.ModelScale, 0.1 )
			
			end 
			
			self:SetRenderOrigin( newpos )
			self:SetRenderAngles(ang)

			
		end 
			
		self:SetupBones()
		if( activator != LocalPlayer() || GetConVarNumber("Developer")>0 ) then
			self:DrawModel()
		end
		self:SetRenderOrigin()
		self:SetRenderAngles()
		
	end
	
end
	
function ENT:PhysicsUpdate()
	

	
end 

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth 
	self:SetNWInt("HealthVal", math.floor( self.HealthVal ) )

	if SERVER then
		
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		self.PhysObj = self:GetPhysicsObject()
		
		if ( self.PhysObj:IsValid() ) then
		
			self.PhysObj:Wake()
			self.PhysObj:SetMass( 5 )
			self.PhysObj:EnableDrag( true )
			self.PhysObj:EnableGravity( true )
			
		end
		
	end 

	if( self.OnCreate ) then 
		
		self:OnCreate()
		
	end 
	
	
end

if SERVER then

	function ENT:SpawnFunction( ply, tr, class )
		
		local SpawnPos = ( tr.HitPos + ( tr.HitNormal * 12 ) )
		local vec = ply:GetAimVector():Angle()
		local newAng = Angle( 0, vec.y, 0 )
		local ent = ents.Create( class )

		if ent.SpawnPos then
			ent:SetPos( SpawnPos + ent.SpawnPos )
		else
			ent:SetPos( SpawnPos )
		end

		if ent.SpawnAngle then
			ent:SetAngles( newAng + ent.SpawnAngle )
		else
			ent:SetAngles( newAng )
		end

		ent:Spawn()
		ent:Activate()
		ent.Owner = ply
		
		return ent		
		
	end

	function ENT:PhysicsCollide( data, physobj )
	
		if ( self.Destroyed ) then return end

	end

	-- function ENT:PhysicsUpdate()

	-- end

	function ENT:Use( activator, caller, var1, var2 )
		
		if( self.AttachmentBone ) then 
						
			
			-- Bones:
			-- ValveBiped.Anim_attachment_RH
			-- ValveBiped.Bip01_Spine
			-- ValveBiped.Bip01_R_Hand
			-- ValveBiped.Bip01_R_Forearm
			-- ValveBiped.Bip01_R_Foot
			-- ValveBiped.Bip01_R_Thigh
			-- ValveBiped.Bip01_R_Calf
			-- ValveBiped.Bip01_R_Shoulder
			-- ValveBiped.Bip01_R_Elbow
			-- local boneIndex = activator:LookupBone( "ValveBiped.Bip01_Head1" )
			-- local pos, ang = activator:GetBonePosition( boneIndex )

			local bone = self.AttachmentBone or "eyes"
			local attachmentId = activator:LookupAttachment( bone ) 
			local attach = activator:GetAttachment( attachmentId )
			if( !attach ) then return end 
			
			local ang = attach.Ang
			local pos = attach.Pos 
			local aa = activator:EyeAngles()
			
			activator:SetEyeAngles( Angle( 0, aa.y, aa.r ) )

			if( !activator.NeuroArmor ) then 
				activator.NeuroArmor = {}
			end
			
			for k,v in pairs( activator.NeuroArmor ) do 
				
				if( v.HitgroupProtected == self.HitgroupProtected ) then 	
					
					v:Remove()
					break 
					
				end 
				
			end 

			local newAng = self.AttachmentAngle 
			ang:RotateAroundAxis( self:GetUp(), newAng.y )
			ang:RotateAroundAxis( self:GetRight(), newAng.p )
			ang:RotateAroundAxis( self:GetForward(), newAng.r )
			
			local fwd = ang:Forward() * self.AttachmentPos.x 
			local rght = ang:Right() * self.AttachmentPos.y
			local up = ang:Up() * self.AttachmentPos.z 
			local newpos = pos + fwd + rght + up
			
			self:SetPos( newpos )
			self:SetAngles( ang )
			self:SetParent( activator )
			self:Fire("SetParentAttachmentMaintainOffset", bone, 0 )
			self:SetNWEntity("Owner", activator )
			self:SetOwner( activator ) 
			
			-- callback hook
			if( type(self.OnEquipItem) == "function" ) then 
				
				self:OnEquipItem( activator )
				
			end 
						
			-- store the new equipment on the player.
			table.insert( activator.NeuroArmor, self.Entity ) 
		
		end 
		
	end

	function ENT:OnTakeDamage( dmginfo )
		if ( self.Destroyed ) then return end
		self.HealthVal = self.HealthVal - dmginfo:GetDamage() 
		
		if( self.HealthVal <= 0 ) then 
			-- callback hook
			if( type( self.OnDestroyed ) == "function" ) then 
				
				self:OnDestroyed( dmginfo )
				
			end 
			
			self:ForceDeath()
		
		end 
		
	end
	
	function ENT:ForceDeath()
		
		if( self.DeathForced ) then return end 
		
		self.DeathForced = true 
		
		local p = ents.Create("prop_physics")
		p:SetPos( self:GetPos() )
		p:SetAngles( self:GetAngles() )
		p:SetModel( self:GetModel() )
		p:SetColor( self:GetColor() )
		p:SetVelocity( self:GetVelocity() + VectorRand() )
		p:Spawn()
		p:Fire("kill","",10)
		self:Remove()
		
	end 

	function ENT:Think()
		
		self.PhysgunDisabled  = IsValid( self:GetNWEntity("Owner",NULL) )
		-- callback hook
		if ( self.ThinkCallback ) then
		
			self:ThinkCallback( )
			
		end
		
	end 

	
	function ENT:OnRemove()
	
	end

end