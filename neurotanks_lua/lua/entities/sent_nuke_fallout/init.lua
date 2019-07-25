
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/props_junk/watermelon01.mdl"  )
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE )
	self:SetSolid(SOLID_NONE)
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
end


function ENT:OnRemove()
	

end

function ENT:Think()
	
	self:NextThink(CurTime()+2)
	self.Owner:Neuro_DealDamage( DMG_RADIATION, math.Rand( 1.15,2.61 ), self:GetPos(), 4000, false, "" )
			
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 15500 ) ) do
		
		-- if ( math.random( 1, 10 ) == 2 ) then
			
			-- print("burn")
			if( IsValid( v ) && ( v:IsNPC() || v:IsPlayer() || v.HealthVal ) ) then
			
				self.Owner:Neuro_DealDamage( DMG_RADIATION, math.Rand( 1.15,2.61 ), v:GetPos(), 100, false, "" )
			
			end
		-- end
	
	end

end
