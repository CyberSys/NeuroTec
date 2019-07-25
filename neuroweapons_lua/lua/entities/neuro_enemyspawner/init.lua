AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

CreateConVar("neuro_maxnpcsperspawner", 3,  FCVAR_NOTIFY )

ENT.MaxHealth = 25000
ENT.HealthVal = 25000

function ENT:SpawnFunction( ply, tr)
	
	local SpawnPos = tr.HitPos

	local ent = ents.Create( "neuro_enemyspawner" )
	ent:SetPos( SpawnPos + tr.HitNormal * 100 )
	ent:Spawn()
	ent:Activate()
	ent.Spawner = ply
	
	return ent
	
end




function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
		
	local dt = dmginfo:GetDamageType()
	local bitwise = ( bit.bor( dt, DMG_BLAST_SURFACE ) == DMG_BLAST_SURFACE ) || ( bit.bor(dt, DMG_BLAST )  == DMG_BLAST ) || ( bit.bor( dt, DMG_BURN ) == DMG_BURN  )
	local dmg = dmginfo:GetDamage()
	
	if( bitwise ) then
		
		self.HealthVal = self.HealthVal - dmg
		
	else
		
		return
	
	end
	
	
	if(	self.HealthVal < 0 ) then
		
		self.Destroyed = true
		ParticleEffect( "tank_cookoff", self:GetPos() + Vector( 0,0,16 ), self:GetAngles(), self )
		
	end
	
end

function ENT:Initialize()

	self:SetModel( "models/props_vehicles/trailer001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )		
	self:SetSolid( SOLID_VPHYSICS )
	
	self:GetPhysicsObject():Wake()

	self.MyNPCS = {}

	
end

local NPCs = {
"tank_mini_drone"
}
-- local Mdls = {
-- "",
-- "",
-- "",
-- }

-- local Mdls = {
-- "models/gman_high.mdl",
-- "models/Kleiner.mdl",
function ENT:OnRemove()

	for i=1,#self.MyNPCS do
	
		if( IsValid( self.MyNPCS[i] ) ) then
		
			self.MyNPCS[i].Destroyed = true
		
		end
		
	
	end

end
function ENT:Think()
	
	self.MaxNPCs = GetConVarNumber("neuro_maxnpcsperspawner")
	
	for k,v in pairs( self.MyNPCS ) do
	
		if( !IsValid( v ) ) then
			
			table.remove( self.MyNPCS, k )
			
		end
		
	end
	
	self:NextThink( CurTime()+50)
	-- print( "wallA" )
	local NumNpcs = #self.MyNPCS
	local weps = { "weapon_ar2", "rpg-7"}
	
	if( NumNpcs < self.MaxNPCs ) then
		

		local Pos = self:GetPos()
		local i = NumNpcs+1
		
		self.MyNPCS[i] = ents.Create( NPCs[math.random(1,#NPCs)] )
		self.MyNPCS[i]:SetPos( Pos + Vector( math.random(-512,512),120+math.random(32,100),40 ) )
		-- self.MyNPCS[i]:SetHealth( 750 )
		self.MyNPCS[i]:Spawn()
		self.MyNPCS[i]:GetPhysicsObject():Wake()
		
		-- self.MyNPCS[i]:SetModel( "models/Kleiner.mdl" )
		-- self.MyNPCS[i]:Fire("setrelationship","player d_ht 98",0)
		-- self.MyNPCS[i]:Fire("setrelationship","sent* d_ht 98",0)
		-- self.MyNPCS[i]:Give( weps[math.random(1,2)] ) 

	end
	
end

