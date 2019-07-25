 ENT.Base = "base_ai"
 ENT.Type = "ai"
   
 ENT.PrintName = "RC Jaanus Helicopter Drone"
 ENT.Author = "Hoffa StarChick"
 ENT.Contact = "no"
 ENT.Purpose = ""
 ENT.Instructions = ""
 ENT.Information	= ""  
 ENT.Category		= "NeuroTec Admin"
  
 ENT.AutomaticFrameAdvance = true
   
 ENT.Spawnable = false
 ENT.AdminSpawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
  self.AutomaticFrameAdvance = bUsingAnim
end  

ENT.HealthVal = 1200
ENT.Target = nil
ENT.Pilot = NULL
ENT.MaxGDistance = 0
ENT.HitPercentPrimary = 0
ENT.HitPercentSecondary = 0
ENT.DeathTimer = 0
ENT.Destroyed = false
ENT.Burning = false
ENT.IsOverWater = false
ENT.LagCompensate = 450
ENT.Weapon = "sent_chopper_gun"
ENT.MaxRockets = 4 // MaxRockets = MaxPodRockets * 2
ENT.MaxPodRockets = 2
ENT.Velocity = 300
ENT.VelocityMod = 100
ENT.VelocityMult = 16
ENT.MinVelocity = 300
ENT.MaxVelocity = 600
ENT.RollVal = 0
ENT.RollVal2 = 0
ENT.YawVal = 0
// No touchy please.
ENT.MaxYawSpeed = 3
ENT.YawSpeed = 0
ENT.YawAcceleration = 0.0678
ENT.YawMax = 1.5
ENT.RollSpeed = 0
ENT.RollAcceleration = 0.04532
ENT.MaxRollSpeed = 19
ENT.MaxPitchSpeed = 15
ENT.PitchSpeed = 0
ENT.PitchAcceleration = 0.15123

ENT.Mod = 1

ENT.RotorWashing = false
ENT.RotorWash = nil

ENT.HoverSoundFile = "drone_noise.wav"
ENT.HoverSoundPlaying = false

ENT.HitTabPrimary = {
{7500,4001,0};
{4000,3501,10};
{3500,3001,20};
{3000,2501,30};
{2500,2001,55};
{2000,1001,70};
{1000,0,100};
}
ENT.HitTabSecondary = {
{7500,4001,100};
{4000,3501,100};
{3500,3001,100};
{3000,2501,69};
{2500,2001,54};
{2000,1001,70};
{1000,0,0};
}