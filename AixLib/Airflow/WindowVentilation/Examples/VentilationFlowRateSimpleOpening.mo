﻿within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSimpleOpening
  "Use different empirical expressions to determine the window ventilation flow rate by simple opening"
  extends Modelica.Icons.Example;
  /*Parameters for boundary conditions*/
  parameter Modelica.Units.SI.Length winClrWidth(min=0)=1.0
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrHeight(min=0)=1.8
    "Height of the window clear opening";
  parameter Modelica.Units.SI.Angle aziRef(displayUnit="deg")=0
    "Azimuth angle of the referece surface impacted by wind";
  parameter Modelica.Units.SI.Height locHeight(min=0)=4
    "Middle local height of the ventilation zone";
  Modelica.Blocks.Sources.Ramp TRoomSet(
    height=15,
    duration=120,
    offset=15,
    startTime=50) "Set room temperature in °C"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Ramp TAmbSet(
    height=-40,
    duration=160,
    offset=40,
    startTime=10) "Set ambient temperature in °C"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1 "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.TimeTable winSpe10Set(table=[0,0; 20,0; 30,5; 40,0; 50,
        10; 60,0; 70,20; 80,0; 100,0; 110,20; 120,0; 130,10; 140,0; 150,5; 160,0;
        180,0]) "Set wind speed at the height of 10 m"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Sine winDirSet(amplitude=2*Modelica.Constants.pi, f=0.05)
    "Set wind direction"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.WarrenParkins warrenParkins(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
        "Model Warren Parkins"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.GidsPhaff gidsPhaff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
      "Model de Gids Phaff"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=aziRef) "Model Larsen Heiselberg"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Caciolo caciolo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=aziRef) "Model Caciolo"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  AixLib.Airflow.WindowVentilation.Utilities.WindProfilePowerLaw winSpeProLoc(
    height=locHeight, heightRef=10)
    "Calculate wind speed profile local"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Tang tang(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    "Model Tang"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.VDI2078 vdi2078_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078,
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading)
    "Model VDI 2078, without sun shading"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.VDI2078 vdi2078_2(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078,
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.ExternalBlindsOn)
    "Model VDI 2078, with sun shading"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.VDI2078 vdi2078_3(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078,
    use_cofSunSha_in=true) "Model VDI 2078, with sun shading input"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN16798 din16798_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    heightASL=200) "Model DIN 16798"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN4108 din4108_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    "Model DIN 4108"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.ASHRAE ashrae(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=aziRef) "Model ASHRAE"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Sources.Pulse cofSunShaSet(
    amplitude=0.5,
    period=10,
    offset=0.5) "Set sunshading coefficient"
    annotation (Placement(transformation(extent={{50,10},{60,20}})));
equation
  connect(TRoomSet.y, from_degC.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(TAmbSet.y, from_degC1.u)
    annotation (Line(points={{-79,60},{-62,60}}, color={0,0,127}));
  connect(from_degC.y, warrenParkins.TRoom) annotation (Line(points={{-39,90},{10,
          90},{10,98},{18,98}}, color={0,0,127}));
  connect(from_degC1.y, warrenParkins.TAmb) annotation (Line(points={{-39,60},{0,
          60},{0,94},{18,94}}, color={0,0,127}));
  connect(winSpe10Set.y, warrenParkins.winSpe10) annotation (Line(points={{-79,30},
          {-10,30},{-10,88},{18,88}}, color={0,0,127}));
  connect(gidsPhaff.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,58},
          {10,58},{10,98},{18,98}}, color={0,0,127}));
  connect(gidsPhaff.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{18,54},{0,54},{0,94},{18,94}}, color={0,0,127}));
  connect(gidsPhaff.winSpe10, warrenParkins.winSpe10) annotation (Line(points={{
          18,48},{-10,48},{-10,88},{18,88}}, color={0,0,127}));
  connect(larsenHeiselberg.TRoom, warrenParkins.TRoom) annotation (Line(points={
          {18,18},{10,18},{10,98},{18,98}}, color={0,0,127}));
  connect(larsenHeiselberg.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{18,14},{0,14},{0,94},{18,94}}, color={0,0,127}));
  connect(larsenHeiselberg.winSpe10, warrenParkins.winSpe10) annotation (Line(
        points={{18,8},{-10,8},{-10,88},{18,88}}, color={0,0,127}));
  connect(winDirSet.y, larsenHeiselberg.winDir) annotation (Line(points={{-79,0},
          {-20,0},{-20,4},{18,4}}, color={0,0,127}));
  connect(caciolo.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,-22},
          {10,-22},{10,98},{18,98}}, color={0,0,127}));
  connect(caciolo.TAmb, warrenParkins.TAmb) annotation (Line(points={{18,-26},{0,
          -26},{0,94},{18,94}}, color={0,0,127}));
  connect(winSpe10Set.y, winSpeProLoc.winSpeRef) annotation (Line(points={{-79,30},
          {-70,30},{-70,-30},{-62,-30}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, caciolo.winSpeLoc) annotation (Line(points={{-39,
          -30},{-30,-30},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(caciolo.winDir, larsenHeiselberg.winDir) annotation (Line(points={{18,
          -36},{-20,-36},{-20,4},{18,4}}, color={0,0,127}));
  connect(tang.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,-62},{10,
          -62},{10,98},{18,98}}, color={0,0,127}));
  connect(tang.TAmb, warrenParkins.TAmb) annotation (Line(points={{18,-66},{0,-66},
          {0,94},{18,94}}, color={0,0,127}));
  connect(vdi2078_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,78},
          {10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vdi2078_1.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{58,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(vdi2078_2.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,58},
          {52,58},{52,78},{10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vdi2078_2.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,54},{
          48,54},{48,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(din16798_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-2},
          {10,-2},{10,98},{18,98}}, color={0,0,127}));
  connect(din16798_1.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{58,-6},{0,-6},{0,94},{18,94}}, color={0,0,127}));
  connect(din16798_1.winSpe10, warrenParkins.winSpe10) annotation (Line(points={
          {58,-12},{-10,-12},{-10,88},{18,88}}, color={0,0,127}));
  connect(din4108_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-42},
          {10,-42},{10,98},{18,98}}, color={0,0,127}));
  connect(din4108_1.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,-46},
          {0,-46},{0,94},{18,94}}, color={0,0,127}));
  connect(din4108_1.winSpeLoc, caciolo.winSpeLoc) annotation (Line(points={{58,-52},
          {-30,-52},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(ashrae.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-82},{
          10,-82},{10,98},{18,98}}, color={0,0,127}));
  connect(ashrae.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,-86},{0,
          -86},{0,94},{18,94}}, color={0,0,127}));
  connect(ashrae.winSpeLoc, caciolo.winSpeLoc) annotation (Line(points={{58,-92},
          {-30,-92},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(ashrae.winDir, larsenHeiselberg.winDir) annotation (Line(points={{58,-96},
          {-20,-96},{-20,4},{18,4}}, color={0,0,127}));
  connect(vdi2078_3.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,38},
          {52,38},{52,78},{10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vdi2078_3.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,34},{
          48,34},{48,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(cofSunShaSet.y,vdi2078_3. cofSunSha_in)
    annotation (Line(points={{60.5,15},{70,15},{70,18}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the simple opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"), experiment(
      StopTime=180,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end VentilationFlowRateSimpleOpening;
