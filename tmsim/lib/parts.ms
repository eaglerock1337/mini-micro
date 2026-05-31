// parts.ms - Time machine components

import "part"

// Parts array

Parts = {}
Parts.

// Critical parts

Parts.PowerUnit = new part.Part
Parts.PowerUnit.name = "Power Distrib. Unit"
Parts.PowerUnit.shortName = "PwrUnit"

Parts.ControlPanel = new part.Part
Parts.ControlPanel.name = "Control Panel"
Parts.ControlPanel.shortName = "CtrPanl"

Parts.LifeSupport = new part.Part
Parts.LifeSupport.name = "Life Support"
Parts.LifeSupport.shortName = "LifSupp"

Parts.AirLock = new part.Part
Parts.AirLock.name = "Cabin Airlock"
Parts.AirLock.shortName = "Airlock"
Parts.AirLock.conditions = ["opn", "lck"]

Parts.TimeCircuits = new part.Part
Parts.TimeCircuits.name = "Time Circuits"
Parts.TimeCircuits.shortName = "TimeCir"

Parts.FluxCapacitor = new part.Part
Parts.FluxCapacitor.name = "Flux Capacitor"
Parts.FluxCapacitor.shortName = "FluxCap"

Parts.Console = new part.Part
Parts.Console.name = "Computer Console"
Parts.Console.shortName = "Console"

Parts.Computer = new part.Part
Parts.Computer.name = "Mini Micro Computer"
Parts.Computer.shortName = "Computr"

// Auxillary Parts

Parts.ThreatSensors = new part.Part
Parts.ThreatSensors.name = "Threat Sensors"
Parts.ThreatSensors.shortName = "Sensors"

Parts.WaterCollector = new part.Part
Parts.WaterCollector.name = "Water Collector"
Parts.WaterCollector.shortName = "WtrColl"

Parts.FoodGenerator = new part.Part
Parts.FoodGenerator.name = "Food Generator"
Parts.FoodGenerator.shortName = "FoodGen"

Parts.InvisShield = new part.Part
Parts.InvisShield.name = "Inivisibility Shield"
Parts.InvisShield.shortName = "Shields"

Parts.HoverPropulsion = new part.Part
Parts.HoverPropulsion.name = "Hover Propulsion"
Parts.HoverPropulsion.shortName = "HovProp"

Parts.ResonanceCoil = new part.Part
Parts.ResonanceCoil.name = "Resonance Coil"
Parts.ResonanceCoil.shortName = "ResCoil"

Parts.MrFusion = new part.Part
Parts.MrFusion.name = "Mr. Fusion Reactor"
Parts.MrFusion.shortName = "Mr.Fusn"

Parts.SteamGenerator = new part.Part
Parts.SteamGenerator.name = "Steam Generator"
Parts.SteamGenerator.shortName = "StmGenr"

// Part class functions

Parts.criticalParts = function
  return [self.PowerUnit, self.ControlPanel, self.LifeSupport,
    self.Airlock, self.TimeCircuits, self.FluxCapacitor,
    self.Console, self.Computer]
end function

Parts.auxillaryParts = function
  return [self.ThreatSensors, self.WaterCollector,
    self.FoodGenerator, self.InvisShield, self.HoverPropulsion,
    self.ResonanceCoil, self.MrFusion, self.SteamGenerator]
end function

Parts.externalParts = function
  return []
end function

Parts.internalParts = function
  return []
end function