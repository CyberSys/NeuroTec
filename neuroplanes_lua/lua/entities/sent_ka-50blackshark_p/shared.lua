ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName = "Kamov Ka-50 Black Shark"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.Model = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark.mdl"
//Speed Limits
ENT.MaxVelocity = 900
ENT.MinVelocity = -900

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 3

ENT.InitialHealth = 3200
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 20
ENT.FlareCount = 15
ENT.MaxFlares = 15

// Equipment
ENT.MachineGunModel = "models/bf2/helicopters/Ka-50 BlackShark/Ka-50 BlackShark_cannon.mdl"
ENT.MachineGunOffset = Vector( 244, 0, 2 )
ENT.CrosshairOffset = -53
ENT.LinearMachineGun = true

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 5.0

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true
