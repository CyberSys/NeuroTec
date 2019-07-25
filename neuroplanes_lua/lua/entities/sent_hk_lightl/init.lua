AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/inaki/props_vehicles/terminator_aerialhk_lightl.mdl"
ENT.Tic	= "NPC_CScanner.TakePhoto"
ENT.HealthVal = math.random( 50, 88 )

function ENT:Precache( )
	
	util.PrecacheSound( Tic )
	
end

function ENT:Initialize()

	self.Entity:SetModel( self.Model )
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_NONE )
	self.PhysObj = self.Entity:GetPhysicsObject()
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
	
	if ( !self.flashlight ) then
	    self.flashlight = ents.Create( "env_projectedtexture" )
		self.flashlight:SetParent( self.Entity )	
		self.flashlight:SetPos( self:GetPos() + self:GetForward() * 11.5 + self:GetUp() * 0.5 + self:GetRight() * 2.5  )
		self.flashlight:SetAngles( self:GetAngles() )
		self.flashlight:SetKeyValue( "enableshadows", 0 )
		self.flashlight:SetKeyValue( "farz", 2048 )
		self.flashlight:SetKeyValue( "nearz", 8 )
		self.flashlight:SetKeyValue( "lightfov", 20 )
		self.flashlight:SetKeyValue( "lightcolor", "200 220 255" )
		self.flashlight:SetKeyValue( "HDRColorScale", .75 )
		self.flashlight:Spawn()

		self.flashlightbeam = ents.Create( "env_sprite" )
		self.flashlightbeam:SetParent( self.Entity )	
		self.flashlightbeam:SetPos( self:GetPos() + self:GetForward() * 11.5 + self:GetUp() * 0.5 + self:GetRight() * 2.5  )
		self.flashlightbeam:SetAngles( self:GetAngles() )
		self.flashlightbeam:SetKeyValue( "spawnflags", 1 )
		self.flashlightbeam:SetKeyValue( "renderfx", 0 )
		self.flashlightbeam:SetKeyValue( "scale", 0.75 )
		self.flashlightbeam:SetKeyValue( "rendermode", 9 )
		self.flashlightbeam:SetKeyValue( "HDRColorScale", .75 )
		self.flashlightbeam:SetKeyValue( "GlowProxySize", .1 )
		self.flashlightbeam:SetKeyValue( "model", "materials/Sprites/light_glow03.vmt" )
		self.flashlightbeam:SetKeyValue( "framerate", "10.0" )
		self.flashlightbeam:SetKeyValue( "rendercolor", "200 220 255" )
		self.flashlightbeam:SetKeyValue( "renderamt", 255 )
		self.flashlightbeam:Spawn()
			
     end
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


function ENT:Think()

	local selfpos = self.Entity:GetPos()
	local forward = self.Entity:GetForward()
	local entities = ents.FindInSphere(selfpos,3000)
	
	for k,v in pairs(entities) do
	// loooooooooooooooong....
	 if (v:IsNPC() || v:IsPlayer() || (v:IsVehicle() && v:GetPhysicsObject():GetVelocity():Length() > 0) && self.ShouldAttack ) then
			// looooooong
				if ( self.Entity:GetPos():Distance(v:GetPos()) > 300 && v:GetPos().z < self.Entity:GetPos().z )  then
				// still not done with it wtf?
					
					// Aimbot!!
					self.Entity:LerpAim(v)

					local tr = {}
					tr.start=self:GetPos()+self:GetForward()*100
					tr.endpos=self:GetPos()+self:GetForward()*3000
					tr.filter=self
					local Trace = util.TraceLine(tr)
						
					if ( Trace.Hit && Trace.Entity == v ) then
					//Tic, run for your life, you are in the lights bitch!!!
					v:EmitSound("Tic", 100, 100)
					
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
	self:EmitSound ("ambient/energy/spark6.wav")
	
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

end
