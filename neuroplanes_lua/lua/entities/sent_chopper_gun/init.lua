AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "ah64fire.wav"//"weapons/shotgun/shotgun_dbl_Fire7.wav"
ENT.Model = "models/airboatgun.mdl"
ENT.MaxDamage = 50
ENT.MinDamage = 10
ENT.BlastRadius = 128

function ENT:Initialize()

	self.Entity:SetModel( self.Model )
	self.Entity:SetVar('DoAttack',CurTime())
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_NONE )
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.BurstSize = self.BurstSize or 10
	self.Damage = self.Damage or 20
	
	local seed = math.random( 0, 1000 )
	self.guid = tostring( CurTime() - seed )..self:EntIndex( )
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		
	end
	
	if self.Entity:GetOwner() == nil then
		
		return

	end
	
	self.Owner = self.Entity:GetOwner()
	
	self.Entity:SetPhysicsAttacker(self.Owner)

end

function ENT:LerpAim(Target)

	if ( !IsValid( Target ) ) then
		
		return
		
	end
	
	local a = self:GetPos() 
	local b = Target:GetPos() 
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )
	
	self:SetAngles( LerpAngle( 0.05, target:Angle(), self:GetAngles() ) )
	
end

function ENT:FireTurret()

	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
 	local bullet = {} 
 	bullet.Num 		= 1 
 	bullet.Src 		= self:GetPos() + self:GetForward() * 44	// Source 
 	bullet.Dir 		= self:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( 0.03, 0.03, 0.01 )			// Aim Cone 
 	bullet.Tracer	= 1										// Show a tracer on every x bullets  
 	bullet.Force	= 5					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 14, 18 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "GunshipTracer" 
 	bullet.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
 	self:FireBullets( bullet ) 
	
	self:EmitSound( self.Sound, 511, math.random( 65, 71 ) )

	local effectdata = EffectData()
		effectdata:SetStart( self:GetPos() )
		effectdata:SetOrigin( self:GetPos() )
	util.Effect( "RifleShellEject", effectdata )  

	local e = EffectData()
	e:SetStart( self:GetPos()+self:GetForward() * 62 )
	e:SetOrigin( self:GetPos()+self:GetForward() * 62 )
	e:SetEntity( self )
	e:SetAttachment(1)
	util.Effect( "StriderMuzzleFlash", e )

end

function ENT:ExplosiveShellCallback(a,b,c)

	local info = DamageInfo( )  
		info:SetDamageType( DMG_NEVERGIB )  
		info:SetDamagePosition( b.HitPos )  
		info:SetMaxDamage( self.MaxDamage )  
		info:SetDamage( self.MinDamage )  
		info:SetAttacker( self:GetOwner( ) )  
		info:SetInflictor( self:GetOwner( ) )  
	
	local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetScale( 0.1 )
		e:SetNormal( b.HitNormal )
	util.Effect("HelicopterMegaBomb", e)
		e:SetScale( 1.2 )
	util.Effect("ImpactGunship", e)
	
	for k, v in ipairs( ents.GetAll( ) ) do  
		
		if ( IsValid( v ) && v:Health( ) > 0 ) then  
			
			local p = v:GetPos( )  
			local t,tr = {},{}
			t.start = b.HitPos
			t.endpos = p
			t.mask = MASK_BLOCKLOS 
			t.filter = self
			tr = util.TraceLine( t )
			
			if ( p:Distance( b.HitPos ) <= self.BlastRadius ) then  
			
				if ( tr.Hit && tr.Entity ) then
				
					info:SetDamage( self.Damage * ( 1 - p:Distance( b.HitPos ) / self.BlastRadius ) )  
					info:SetDamageForce( ( p - b.HitPos ):GetNormalized( ) * 10 )  
					v:TakeDamageInfo( info )  
					
				end
				
			end 
			
		end  

	end  
	
	return { damage = true, effects = DoDefaultEffect } 
	
end

function ENT:Think()

	local selfpos = self.Entity:GetPos()
	local forward = self.Entity:GetForward()
	local entities = ents.FindInSphere(selfpos,2400)
	
	for k,v in pairs(entities) do
	// loooooooooooooooong....
		if (v != self.Entity && v:GetClass() != self.Owner:GetClass()) then
		// .....loooogiiic is...
			if (v:IsNPC() || v:IsPlayer() || (v:IsVehicle() && v:GetPhysicsObject():GetVelocity():Length() > 0) && self.ShouldAttack ) then
			// looooooong
				if ( self.Entity:GetPos():Distance(v:GetPos()) > 300 && v:GetPos().z < self.Entity:GetPos().z )  then
				// still not done with it wtf?
					
					// Aimbot!!
					self.Entity:LerpAim(v)

					local tr = {}
					tr.start=self:GetPos()+self:GetForward()*100
					tr.endpos=self:GetPos()+self:GetForward()*2400
					tr.filter=self
					local Trace = util.TraceLine(tr)
						
					if ( Trace.Hit && Trace.Entity == v ) then
					
						local TSR = self.Entity:GetVar('DoAttack',0)
						
						if ( ( TSR + 2.5 ) > CurTime( ) ) then 
							
							return
							
						end
						
						self.Entity:SetVar('DoAttack',CurTime())
						
						for i = 1, self.BurstSize do
						
							local x=i/5
							
							if( self ) then
							
								timer.Create( tostring(self.guid)..i, x, 1, function() self:FireTurret() end )
								//timer.Simple( x, function() self:FireTurret() end )
								
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
end

function ENT:OnRemove()
	
	for i=1, self.BurstSize do
		
		timer.Destroy( tostring(self.guid)..i )
		
	end
	
end

