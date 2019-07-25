AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

util.PrecacheSound( "hk/hk_Fire.wav" );

ENT.LazorSound = Sound("hk/hk_Fire.wav");
ENT.Model = "models/inaki/props_vehicles/terminator_aerialhk_cannon.mdl"
ENT.MaxDamage = 25
ENT.MinDamage = 15
ENT.BlastRadius = 200
ENT.HealthVal = 250

function ENT:Initialize()

	self.Entity:SetModel( self.Model )
	self.Entity:SetVar('DoAttack',CurTime())
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_NONE )
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.BurstSize = self.BurstSize or 3
	self.Damage = self.Damage or 15
	self.Entity:SetHealth(self.HealthVal)	
	
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

	if ( Target == nil ) then

		return

	end
	
	if (!Target:IsValid()) then
			
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
 	bullet.Force	= 10					 					// Amount of force to give to phys objects 
 	bullet.Damage	= self.Damage
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "TracerA" 
	bullet.Attacker 	= self.Entity.Owner
 	bullet.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
 	self:FireBullets( bullet ) 
	
	self:EmitSound( self.LazorSound, 511, math.random( 65, 71 ) )

	
	local Flare = ents.Create("env_flare")
	Flare:SetPos(self:GetPos()+self:GetForward() * 58 )
	Flare:SetParent(self.Entity)
	Flare:SetAngles( self.Entity:GetAngles() )
	Flare:SetKeyValue("scale", "1.5")
	Flare:Spawn()
	Flare:Fire("Explode", "", 0)
	Flare:Fire("Kill", "", 0.2)

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
		
		if ( v:IsValid() && v:Health( ) > 0 ) then 
			
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
					info:SetDamageForce( ( p - b.HitPos ):Normalize( ) * 10 )  
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
	local entities = ents.FindInSphere(selfpos,3072)
	
	for k,v in pairs(entities) do
	// loooooooooooooooong....
		if (v != self.Entity && v:GetClass() != self.Owner:GetClass()) then
		// .....loooogiiic is...
			if ( ( v:GetClass("rpg_missile") or v:IsVehicle() && v:GetPhysicsObject():GetVelocity():Length() > 0) && self.ShouldAttack ) then
			// looooooong
				if ( self.Entity:GetPos():Distance(v:GetPos()) > 420 && v:GetPos().z < self.Entity:GetPos().z )  then
				// still not done with it wtf?
					
					// Aimbot!!
					self.Entity:LerpAim(v)

					local tr = {}
					tr.start=self:GetPos()+self:GetForward()*100
					tr.endpos=self:GetPos()+self:GetForward()*3072
					tr.filter=self
					local Trace = util.TraceLine(tr)
						
					if ( Trace.Hit && Trace.Entity == v ) then
					
						local TSR = self.Entity:GetVar('DoAttack',0)
						
						if ( ( TSR + 3.5 ) > CurTime( ) ) then 
							
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

function ENT:OnTakeDamage(dmginfo)
if self.Destroyed then
return
end

self.Entity:TakePhysicsDamage(dmginfo)
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	if ( self.HealthVal < 5 ) then

self:EmitSound ("ambient/energy/spark5.wav")

		local explo = EffectData()
		explo:SetOrigin(self.Entity:GetPos())
		util.Effect("Explosion", explo)
		
local effect = EffectData()
 effect:SetOrigin( self:GetPos() )
 effect:SetNormal( self:GetPos() )
 effect:SetMagnitude( 5 )
 effect:SetScale( 2 )
 effect:SetRadius(5.1 )
util.Effect( "sparks", effect )
		self.Destroyed = true
		self:Remove()
end
end

function ENT:OnRemove()
	
	for i=1, self.BurstSize do
		
		timer.Destroy( tostring(self.guid)..i )
		
	end
	
end

