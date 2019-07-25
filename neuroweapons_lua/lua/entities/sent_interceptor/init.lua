AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Started = false
ENT.Sauce = 0
ENT.Speed = 350
ENT.NewSpeed = 0
ENT.Delay = 0
ENT.Model = "models/killstr3aks/neuroplanes/american/f2a_buffalo.mdl"
ENT.MaxDamage = 35
ENT.MinDamage = 25
ENT.BlastRadius = 75
ENT.HealthVal = math.random( 100, 150 )
ENT.PrimaryCooldown = .125

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "sent_interceptor" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( self.Model )
	self:SetVar('DoAttack',CurTime())
    self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.BurstSize = self.BurstSize or 2
	self.Damage = self.Damage or 8
	self:SetHealth(self.HealthVal)	
	
	self.AnnoyingEngineSound = CreateSound( self, "npc/manhack/mh_engine_loop"..math.random(1,2)..".wav" )
	local a,b = game.GetWorld():GetPhysicsObject():GetAABB()
	local mid = a + b / 2
	
	local tr,trace = {},{}
	tr.start = mid 
	tr.endpos = mid + Vector( 0,0,-46000 )
	tr.mask = MASK_SOLID_BRUSHONLY + MASK_WATER
	trace = util.TraceLine( tr )
	
	if( trace.Hit ) then 
	
		mid.z = trace.HitPos.z + math.random( 4500, 5500 )
		
	end 
	
	self.WorldCenter = mid 
	
	
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()	
		self.PhysObj:EnableDrag( true )
		self.PhysObj:EnableGravity( true )
		
	end
	
	if self:GetOwner() == nil then
		
		return

	end
	
	self.Owner = self:GetOwner()
	
	self:SetPhysicsAttacker(self.Owner)

end


function ENT:PhysicsCollide( data, phys )
	
	if( data.Speed > 55 &&  data.DeltaTime > .5 ) then 
	
		self.Destroyed = true
			
		ParticleEffect( "microplane_midair_explosion", self:GetPos(), self:GetAngles(), nil )
		util.BlastDamage( self, self, self:GetPos(), 256, 256 ) 
		self:EmitSound("explosion3.wav", 511, 100 )
		self:Remove()
		
	end 
	
end 
function ENT:LerpAim( Target )
		
	if( !IsValid( Target ) ) then return end 
	
	local a = self:GetPos() 
	local tpos = Target:GetPos()
	local tr,trace= {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 2050 
	tr.filter = { self }
	tr.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
	trace = util.TraceEntity( tr, self )
	
	if( trace.Hit  ) then 
		
		tpos.z = tpos.z + 1500 
	
	end 
	
	local b = tpos + ( Target:GetVelocity() * FrameTime() )
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )
	
	local ang = target:Angle()
	-- ang.r = math.AngleDifference(  self:GetForward():Angle().y, ( b - a ):GetNormalized():Angle().y ) * .1
	
	self:SetAngles( LerpAngle( 0.01225, self:GetAngles(), ang ) )
	
	-- print( target:Angle() )
end

function ENT:FireTurret()
	
	if( !self.LastPrimaryAttack ) then 
		
		self.LastPrimaryAttack = 0 
		
	end 
	
	if( self.LastPrimaryAttack + self.PrimaryCooldown >= CurTime() ) then return end 
	
	self.LastPrimaryAttack = CurTime() 
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end
		
	local bullet = {} 
 	bullet.Num 		= 3 
 	bullet.Src 		= self:GetPos() + self:GetForward() * 110	// Source 
 	bullet.Dir 		= self:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( 0.051, 0.051, 0.081 )			// Aim Cone 
 	bullet.Tracer	= 1										// Show a tracer on every x bullets  
 	bullet.Force	= 15					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( self.MinDamage, self.MaxDamage )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "GunshipTracer"
 	bullet.Callback    = function ( a, b, c ) end 
 	self:FireBullets( bullet ) 
	self:EmitSound("micro/gau8_humm2.wav", 511, math.random( 65, 71 ) )

	-- local effectdata = EffectData()
		-- effectdata:SetStart( self:GetPos() )
		-- effectdata:SetOrigin( self:GetPos() )
	-- util.Effect( "RifleShellEject", effectdata )  
		
	ParticleEffectAttach( "microplane_MG_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		
		
	-- microplane_MG_muzzleflash
	-- local e = EffectData()
	-- e:SetStart( self:GetPos()+self:GetForward() * 100  )
	-- e:SetNormal( self:GetForward() )
	-- e:SetEntity( self )
	-- e:SetScale( 1.5 )
	-- util.Effect( "ac130_muzzle", e )
	
end

function ENT:PhysicsUpdate()
	
	self.PhysObj = self:GetPhysicsObject()
	if( self.Sauce <= 0 ) then return end 
	
	if ( self.Flying ) then
	
		if self.Sauce >= 1 then
		
			self.Speed = self.Speed
			self.PhysObj:SetVelocity( self:GetForward() * self.Speed )
			self.Sauce = self.Sauce - 1
			-- self:GetPhysicsObject():ApplyForceCenter( VectorRand() * 160 )
		
		 else
										  
			self.PhysObj:EnableGravity(true)
			self.PhysObj:EnableDrag(false)
			self.PhysObj:SetMass(100)
			
		end
		
		
		if( IsValid( self.Target ) ) then 
		
			self:LerpAim( self.Target ) 
	
			local ta = ( self.Target:GetPos() - self:GetPos() ):GetNormalized():Angle()
			local ma = self:GetAngles()
			local diffY = math.AngleDifference( ma.y, ta.y )
			local diffP = math.AngleDifference( ma.p, ta.p )
			-- print( diffY , diffP )
			-- self:DrawLaserTracer( self:GetPos(), self:GetPos() + self:GetForward() * 5000 )
			if( ( self.Target:GetPos() - self:GetPos()):Length() < 4500 && math.abs( diffY ) < 2 && math.abs( diffP ) < 2 ) then 
			
				self:FireTurret()
			
			end 
		else
			
			if( self.Started && self.HoverHeight ) then 
				
				local targetPos = self.WorldCenter + Vector( math.sin( CurTime() * self:EntIndex() ) *4500 + self.HoverHeight,  math.cos( CurTime() * self:EntIndex() )  * 4500 + self.HoverHeight, 0 )
				if( IsValid( self.BaseTower ) ) then 
				
					local height = self.HoverHeight
					if( self:GetPos():Length2D( self.BaseTower:GetPos() ) > 3500 ) then 
						
						height = 8500 
						
					end 
				
					targetPos = self.BaseTower:GetPos() + Vector( math.sin( CurTime() ) * 2500, math.cos( CurTime() ) * 2500, height) 
						
				end 
				
				local tr,trace = {},{}
				tr.start = targetPos 
				tr.endpos = targetPos + Vector( 0,0,-46000)
				tr.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
				trace = util.TraceEntity( tr, self )
				
				if( trace.Hit ) then 
				
					targetPos.z = trace.HitPos.z + ( self.HoverHeight or 5000  ) 
					
				end 
				
				local targetAng = ( targetPos - self:GetPos() ):GetNormalized():Angle()
				
				self:SetAngles( LerpAngle( 0.01, self:GetAngles(), targetAng ) )
				
			
			end 
			
		
		end 
		
		-- local ft,ftrace = {},{}
		-- ft.start = self:GetPos()
		-- ft.endpos = self:GetForward() * 5000
		-- ft.filter = { self }
		-- ft.mask = MASK_SOLID 
		-- ftrace = util.TraceEntity( ft, self ) 
		
		-- if( ftrace.Hit && IsValid(  ftrace.Entity ) && ( ftrace.Entity == self.Target || ftrace.Entity.Owner == self.Target  ) ) then 
			
			-- self:FireTurret()
			
		
		-- end 
		
	end
	
end

function ENT:Think()

	if( self:WaterLevel() > 0 ) then
		
		self:Remove()
		
		return 
		
	end
	

	if self.Delay > 0 then
		self.Delay = self.Delay - 1
		self.Flying = false
	else
		self.Flying = true
		self.Delay = 0
	end
	if( !self.Flying || self.Sauce <= 0 ) then return end 
	
	if( IsValid( self.Target )	) then 
		-- print("YES")
		local targetPos = self.Target:GetPos()
		local targetSpeed = self.Target:GetVelocity():Length()
		local mySpeed = self:GetVelocity():Length()
		local dist = ( self:GetPos() - self.Target:GetPos() ):Length()
		
		
		if( dist > 7000 ) then 	
			
			self.Target = NULL
			
			return 
			
		end 
		
		-- Aim Controls 

		if (  mySpeed < targetSpeed && dist > 3500 ) then 
			 
			 self.Speed = math.Clamp( self.Speed + 10, 0, 320000 )

		elseif( targetSpeed < mySpeed || dist < 3500 ) then 
			
			self.Speed = math.Approach( self.Speed, 500, 10 ) 

		end
			
	else
		
		local selfpos = self:GetPos()
		local forward = self:GetForward()
		local _ents = ents.GetAll() -- FindInSphere with a size greater than the map is pointless. Use GetAll() instead.
		local closest = 5800 
		local dist = 0 
		
		if( self.Started ) then 
		
			for k,v in pairs(_ents) do
				
				if( v:GetClass() == self:GetClass() && v:GetPos():Distance( self:GetPos() ) < 500 ) then 
					
					if(  self.Speed > 500 && v:GetVelocity():Length() > self:GetVelocity():Length() ) then 
							
						self.Speed = self.Speed - 1
					
					elseif( self.Speed > 500 && v:GetVelocity():Length() < self:GetVelocity():Length() ) then 	
						
						self.Speed = self.Speed + 1 
						
					end 
					
				
				end 
				
				if  ( ( v != self && v.VehicleType && ( v.VehicleType == VEHICLE_PLANE || v.VehicleType == VEHICLE_HELICOPTER ) ) || string.find( v:GetClass(), "npc_" ) && v:GetClass() != "npc_bullseye" || ( v:GetClass() == self:GetClass() && IsValid( self.BaseTower ) && v.Faction != self.Faction ) ) then
					
					dist = ( v:GetPos() - selfpos ):Length()
					if( dist < closest ) then 
								-- print("waheyat")
						closest = dist
						self.Target = v 
						
					end 
				
				end 
				
			end 
		
		end 
		
	end 

end	

function ENT:Use( activator, caller )
	
	if( !self.Started ) then
	
		self.owner = activator
		self.Started = true
		self.Sauce = 10000
		self.PhysObj:EnableMotion(true)
		self.PhysObj:Wake()
		self.AnnoyingEngineSound:PlayEx( 511, 100 )
		
	end 
	
end

function ENT:OnTakeDamage(dmginfo)

	if self.Destroyed then
		
		return
	
	end
	
	local atk = dmginfo:GetAttacker()
	
	if( !IsValid( self.Target ) ) then 
		
		self.Target = atk 
		
	end 
	
	
	self:TakePhysicsDamage(dmginfo)
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal <= 0 ) then
		
		self.Destroyed = true
			
		ParticleEffect( "microplane_midair_explosion", self:GetPos(), self:GetAngles(), nil )
		util.BlastDamage( self, self, self:GetPos(), 256, 256 ) 

		self:Remove()
		
	end
	
end

function ENT:OnRemove()
	if( self.AnnoyingEngineSound ) then 
		
		self.AnnoyingEngineSound:Stop()
	
	end 
	
end

