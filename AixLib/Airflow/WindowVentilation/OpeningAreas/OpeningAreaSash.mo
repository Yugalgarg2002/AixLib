﻿within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSash "Window opening with different types of sash"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes
    opnTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward
    "Window opening type";
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes
    opnAreaTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window opening area types for calculation";

  Modelica.Units.SI.Length lenA(min=0)
    "Length A to characterize the hung and pivot window opening:
    length of the hinged axis";
  Modelica.Units.SI.Length lenB(min=0)
    "Length B to characterize the hung and pivot window opening:
    distance from the hinged axis to the frame across the opening area";

  Modelica.Units.SI.Angle opnAngle(
    min=0, max=Modelica.Constants.pi/2, displayUnit="deg")
    "Window sash opening angle";
  Modelica.Units.SI.Area geoOpnArea(min=0) "Geometric opening area";
  Modelica.Units.SI.Area projOpnArea(min=0) "Projective opening area";
  Modelica.Units.SI.Area eqOpnArea(min=0) "Equivalent opening area";
  Modelica.Units.SI.Area effOpnArea(min=0) "Effective opening area";
  Modelica.Blocks.Interfaces.RealInput s(quantity="Length", unit="m", min=0)
    "Window sash opening width"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.Units.SI.Length s90(min=0) "Sash opening width by 90° opening / full sliding opening";
  Modelica.Units.SI.Area geoOpnArea90(min=0) "Geometric opening area by 90° opening";
  Modelica.Units.SI.Area eqOpnArea90(min=0) "Equivalent opening area by 90° opening";
equation
  /*Hinged opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward then
    opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.s_to_alpha(
      lenA, lenB, s);
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      lenA, lenB, s);
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      lenA, lenB, s);
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      lenA, lenB, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      lenA, lenB, s90);
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward then
      /*Side-hung*/
      lenA = winClrH;
      lenB = winClrW;
    else
      /*Top-bottom-hung*/
      lenA = winClrW;
      lenB = winClrH;
    end if;

  /*Pivot opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.s_to_alpha(
      lenA, lenB, s);
    geoOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      lenA, lenB, s)*2;
    projOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.projectiveOpeningArea(
      lenA, lenB, s)*2;
    s90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.alpha_to_s(
      lenA, lenB, Modelica.Constants.pi/2);
    geoOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.geometricOpeningArea(
      lenA, lenB, s90)*2;
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical then
      /*Vertical*/
      lenA = winClrH;
      lenB = winClrW/2;
    else
      /*Horizontal*/
      lenA = winClrW;
      lenB = winClrH/2;
    end if;

  /*Sliding opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    assert(
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric,
      "By opening type 'Sliding', only 'geometric' opening area is applicable.",
      AssertionLevel.warning);
    lenA = 0;
    lenB = 0;
    opnAngle = 0;
    projOpnArea = geoOpnArea;
    /*Define characteristic lengths*/
    if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical then
      /*Vertical*/
      geoOpnArea = winClrW*s;
      s90 = winClrH;
      geoOpnArea90 = winClrW*s90;
    else
      /*Horizontal*/
      geoOpnArea = winClrH*s;
      s90 = winClrW;
      geoOpnArea90 = winClrH*s90;
    end if;

  /*Exceptions*/
  else
    lenA = 0;
    lenB = 0;
    opnAngle = 0;
    geoOpnArea = 0;
    projOpnArea = 0;
    s90 = 0;
    geoOpnArea90 = 0;
  end if;

  /*Calculate the rest area types*/
  eqOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.equivalentOpeningArea(
    clrOpnArea, geoOpnArea);
  eqOpnArea90 = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.equivalentOpeningArea(
    clrOpnArea, geoOpnArea90);
  effOpnArea = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.effectiveOpeningArea(
    clrOpnArea, eqOpnArea, eqOpnArea90);

  /*Export area to port based on choice*/
  A = if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric then
    geoOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective then
    projOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent then
    eqOpnArea else if opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective then
    effOpnArea else 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,90},{70,-50}},
          lineColor={0,0,0},
          fillColor={102,204,255},
          fillPattern=FillPattern.Solid),
        Line(
          points=DynamicSelect({{-70,90},{70,20},{-70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward
              then {{-70,90},{70,20},{-70,-50}} else {{-70,90}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{-70,90},{70,20},{-70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward
              then {{-70,90},{70,20},{-70,-50}} else {{-70,90}}),
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points=DynamicSelect({{-70,90},{0,-50},{70,90}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward
              then {{-70,90},{0,-50},{70,90}} else {{-70,90}}),
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points=DynamicSelect({{-70,-50},{0,90},{70,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward
              then {{-70,-50},{0,90},{70,-50}} else {{-70,-50}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{0,90},{70,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{0,90},{70,20}} else {{0,90}}),
          color={0,0,0},
          thickness=0.5,
          pattern=DynamicSelect(LinePattern.Solid,
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical
              then LinePattern.Solid else LinePattern.Dash)),
        Line(
          points=DynamicSelect({{70,20},{0,-50}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{70,20},{0,-50}} else {{70,20}}),
          color={0,0,0},
          thickness=0.5),
        Line(
          points=DynamicSelect({{0,-50},{-70,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{0,-50},{-70,20}} else {{0,-50}}),
          color={0,0,0},
          thickness=0.5,
          pattern=DynamicSelect(LinePattern.Dash,
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical
              then LinePattern.Dash else LinePattern.Solid)),
        Line(
          points=DynamicSelect({{-70,20},{0,90}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
              opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal
              then {{-70,20},{0,90}} else {{-70,20}}),
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points=DynamicSelect({{0,40},{0,80}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical
              then {{0,40},{0,80}} else {{0,40}}),
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points=DynamicSelect({{20,20},{60,20}},
            if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal
              then {{20,20},{60,20}} else {{20,20}}),
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="%opnAreaTyp")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
end OpeningAreaSash;
