AddCSLuaFile('cl_init.lua')
 AddCSLuaFile('shared.lua') 
 include('shared.lua')
 ENT.Model = "models/Npc/kuma/taliban_bomber.mdl" 
 ENT.health = 100  
 ENT.angry = false 
 ENT.dead = false
 ENT.SoundCanPlay = true
 ENT.Detonated = false
 
 function ENT:Initialize()     
 self:SetModel( self.Model )    
 self:SetHullType ( HULL_HUMAN )    
 self:SetHullSizeNormal()    
 self:SetSolid( SOLID_BBOX )   
 self:SetMoveType( MOVETYPE_STEP )  
 self:SetMaxYawSpeed( 500 )    
 self:CapabilitiesAdd( bit.bor( CAP_MOVE_GROUND, CAP_MOVE_JUMP, CAP_OPEN_DOORS ) )
 self:SetHealth(self.health)      
 end  
 
 function ENT:Think()
self:FindVictim()
self:DetonationSystem()

end
 
 
 function ENT:SelectSchedule() 	  
 if self.angry == true then 
 self:SetSchedule(SCHED_CHASE_ENEMY)  
 end 
 

 end 

function ENT:FindVictim()
 
local nearby = ents.FindInSphere(self:GetPos(),15000) 	
if (!nearby) then 
return
 end 
 
for k,v in pairs(nearby) do 		
if v:IsNPC() && v != self or v:IsPlayer() then 
self:SetEnemy(v)
self:UpdateEnemyMemory(v,v:GetPos())
self:AddEntityRelationship(v, D_HT, 99)
self.angry = true 

if v:IsPlayer() && v:Health() <= 0 then 
self:ClearEnemyMemory()
self:SetSchedule(SCHED_PATROL_WALK)

  		
end 	 
end 	  	  	
end     
end

function ENT:DetonationSystem()
local FindBitches = ents.FindInSphere(self:GetPos(),50)

for k,b in pairs(FindBitches) do 

 if b:IsNPC() && b != self or b:IsPlayer()  and ( !self.Detonated ) and( self.SoundCanPlay )  then
 self:EmitSound("bots/akbar"..math.random(1,4)..".mp3", 511, 100)
self.SoundCanPlay = false

timer.Simple( 1.2 , function() if( IsValid( self ) ) then self:DieBitches() end end )	
end
end
end

function ENT:DieBitches()
	
	self.Detonated = true 	
	
	ParticleEffect( "VBIED_b_explosion", self:GetPos(), self:GetAngles(), nil )
	ParticleEffect( "tank_gore", self:GetPos(), self:GetAngles(), nil )
	util.BlastDamage( self, self, self:GetPos(), 550, 7500 )
	self:PlayWorldSound( "weapons/mortar/mortar_explode2.wav" )
	self:EmitSound( "weapons/mortar/mortar_explode2.wav", 511, 100 )
	self:Remove()
end
