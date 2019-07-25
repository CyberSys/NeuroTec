ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "AH-1 Cobra"
ENT.Author	= "Hoffa & StarChick"
ENT.Category 		= "NeuroTec Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER

ENT.RotorSound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
ENT.MountedGunModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl" 
ENT.MountedGunPosition = Vector( 172, 0, -34 ) 
ENT.RotorPropellerPos = Vector( 0,0,95 )
ENT.TailPropellerPos = Vector( -452, -27.5, 73 )
ENT.RotorModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_rotor.mdl"
ENT.TailRotorModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_tail.mdl" 
ENT.SpinUpTime = 10
ENT.SpinUpSound = ""
ENT.SpinUpForce = 0
ENT.SpinDownSound = ""

ENT.PassengerSeatPos = Vector( 150,0,-10 )
		
ENT.MGunTurretPosition = Vector( 172, 0, -38 )
ENT.MGunTurretModel =  "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_turret.mdl"

ENT.RadarCamPos = Vector( 168, 0, -49 )
ENT.RadarCamModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_radar.mdl" 

		
ENT.Model = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra.mdl"
//Speed Limits
ENT.MaxVelocity = 1555
ENT.MinVelocity = -1444

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 4.2

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
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl"
ENT.MachineGunOffset = Vector( 180, 0, -53 )
ENT.CrosshairOffset = -53

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 5.0
ENT.SecondaryFireMode = true // Initial secondary firemode: true = dumbfire, false = homing

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true