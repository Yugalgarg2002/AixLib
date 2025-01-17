within AixLib.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating;
record Viessmann_BW301A45_58kW_5_50COP_R410A =
  AixLib.Fluid.HeatPumps.Data.ScrollWaterToWater.Generic (
    volRat = 2.4538775738,
    V_flow_nominal = 0.00755495224539,
    leaCoe = 0.00208728004583,
    etaEle = 0.742721606102,
    PLos = 3.97958870109e-15,
    dTSup = 0.0,
    UACon = 66989.2819213,
    UAEva = 147854.290996)
  "Calibrated parameters for Viessmann Vitocal 300G BW 301.A45"
  annotation (
    defaultComponentPrefixes = "parameter",
    defaultComponentName="datHeaPum",
    preferredView="info",
  Documentation(info="<html>
<p>
Generated by Filip Jorissen on 2017-05-19.
</p>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
