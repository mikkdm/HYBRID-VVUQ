within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model ChargingMain_V2
  parameter Real tableEtaC[6, 4]=[0, 95, 100, 105;
                                  1, 82.5e-2, 81e-2, 80.5e-2;
                                  2, 84e-2, 82.9e-2, 82e-2;
                                  3, 83.2e-2, 82.2e-2, 81.5e-2;
                                  4, 82.5e-2, 81.2e-2, 79e-2;
                                  5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4]=[0, 95, 100, 105;
                                   1, 38.3e-3, 43e-3, 46.8e-3;
                                   2, 39.3e-3, 43.8e-3, 47.9e-3;
                                   3, 40.6e-3, 45.2e-3, 48.4e-3;
                                   4, 41.6e-3, 46.1e-3, 48.9e-3;
                                   5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4]=[0, 95, 100, 105;
                                1, 22.6, 27, 32;
                                2, 22, 26.6, 30.8;
                                3, 20.8, 25.5, 29;
                                4, 19, 24.3, 27.1;
                                5, 17, 21.5, 24.2];

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
      4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
      4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  Components.MainCompressor mainCompressor(
    redeclare package Medium = NHES.Media.Air,
    tablePhic=tablePhicC,
    tableEta=tableEtaC,
    pstart_in=100000,
    pstart_out=200000,
    Tstart_in=298.15,
    tablePR=tablePR,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    Tstart_out=298.15,
    explicitIsentropicEnthalpy=true,
    Tdes_in=298.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-32,-184},{28,-124}}, rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern(
    redeclare package Medium = NHES.Media.Air,
    p_start=mainCompressor.pstart_out,
    T_start=298.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1500000))
    annotation (Placement(transformation(extent={{126,80},{166,40}}, rotation=0)));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SourceP1(
    redeclare package Medium = NHES.Media.Air,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,-120},{-40,-100}}, rotation=0)));
  inner ThermoPower.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{168,170},{188,190}})));
  TRANSFORM.Fluid.Valves.ValveLinear CompValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{52,50},{72,70}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-66,160},{-46,180}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = ThermoPower.Media.Air)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,-34})));
  Modelica.Fluid.Sources.FixedBoundary SinkAtmosphere(redeclare package Medium = ThermoPower.Media.Air,
    p(displayUnit="bar") = 100000,                                                          nPorts=1)
    annotation (Placement(transformation(extent={{-102,-44},{-82,-24}})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{0,-44},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Cavern.medium.p)
    annotation (Placement(transformation(extent={{-280,124},{-260,144}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-126,82},{-106,102}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
                                              annotation (Placement(transformation(extent={{-180,42},{-160,62}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=1)
    annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=5,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-174,122},{-154,142}})));
  Modelica.Blocks.Sources.Constant const1(k=26.5e5)
                                              annotation (Placement(transformation(extent={{-278,40},{-258,60}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(transformation(extent={{-218,82},{-198,102}})));
  Modelica.Blocks.Sources.RealExpression SinkValveValue(y=-1*SinkValve.opening)
    annotation (Placement(transformation(extent={{-66,116},{-46,136}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=157.08)
    annotation (Placement(transformation(extent={{74,-164},{54,-144}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-14,154},{6,174}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{34,154},{54,174}})));
  Modelica.Blocks.Sources.RealExpression PowerValue(y=mainCompressor.tau*constantSpeed.w_fixed*mainCompressor.eta_mech)
    annotation (Placement(transformation(extent={{178,-158},{158,-138}})));
  Modelica.Blocks.Sources.RealExpression RotationalSpeed(y=mainCompressor.CompPower/(mainCompressor.tau*mainCompressor.eta_mech))
    annotation (Placement(transformation(extent={{178,-204},{158,-184}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,1.45e8; 1,1.45e8; 2,1.45e8; 3,1.45e8], timeScale(displayUnit="h")=
         3600)
    annotation (Placement(transformation(extent={{94,-72},{120,-46}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-9,
    yMax=157.08,
    yMin=0)      annotation (Placement(transformation(extent={{296,-102},{316,-82}})));
  Modelica.Blocks.Sources.RealExpression RotationalSpeed1(y=mainCompressor.omega)
    annotation (Placement(transformation(extent={{208,-184},{228,-164}})));
  Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(extent={{424,-32},{444,-12}})));
  Modelica.Blocks.Sources.RealExpression PowerValue1(y=mainCompressor.tau*constantSpeed.w_fixed*mainCompressor.eta_mech)
    annotation (Placement(transformation(extent={{154,96},{174,116}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{164,-102},{184,-82}})));
  Modelica.Blocks.Sources.RealExpression Denominator(y=mainCompressor.tau*mainCompressor.eta_mech)
    annotation (Placement(transformation(extent={{96,-128},{116,-108}})));
equation
  connect(CompValve.port_b, checkValve.port_a) annotation (Line(points={{72,60},{90,60}},   color={0,127,255}));
  connect(CompValve.port_a, teeJunctionIdeal.port_2)
    annotation (Line(points={{52,60},{38,60},{38,-24},{36,-24}},
                                                             color={0,127,255}));
  connect(teeJunctionIdeal.port_1, mainCompressor.outlet)
    annotation (Line(points={{36,-44},{36,-130},{22,-130}}, color={0,127,255}));
  connect(const3.y, switch1.u3) annotation (Line(points={{-159,52},{-138,52},{-138,84},{-128,84}},     color={0,0,127}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-20,-34},{-82,-34}}, color={0,127,255}));
  connect(SinkValve.port_a, teeJunctionIdeal.port_3) annotation (Line(points={{0,-34},{26,-34}}, color={0,127,255}));
  connect(ramp.y, switch1.u1) annotation (Line(points={{-153,132},{-140,132},{-140,100},{-128,100}}, color={0,0,127}));
  connect(switch1.y, delay1.u) annotation (Line(points={{-105,92},{-94,92},{-94,50},{-84,50}}, color={0,0,127}));
  connect(delay1.y, SinkValve.opening) annotation (Line(points={{-60.6,50},{-10,50},{-10,-26}}, color={0,0,127}));
  connect(checkValve.port_b, Cavern.port) annotation (Line(points={{110,60},{134,60}}, color={0,127,255}));
  connect(realExpression.y, greaterEqual.u1)
    annotation (Line(points={{-259,134},{-240,134},{-240,92},{-220,92}}, color={0,0,127}));
  connect(const1.y, greaterEqual.u2) annotation (Line(points={{-257,50},{-238,50},{-238,84},{-220,84}}, color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-197,92},{-128,92}}, color={255,0,255}));
  connect(constantSpeed.flange, mainCompressor.shaft_b) annotation (Line(points={{54,-154},{16,-154}}, color={0,0,0}));
  connect(SourceP1.ports[1], mainCompressor.inlet)
    annotation (Line(points={{-40,-110},{-26,-110},{-26,-130}}, color={0,127,255}));
  connect(const.y, add.u1) annotation (Line(points={{-45,170},{-16,170}},
                                                                        color={0,0,127}));
  connect(SinkValveValue.y, add.u2) annotation (Line(points={{-45,126},{-26,126},{-26,158},{-16,158}},
                                                                                                 color={0,0,127}));
  connect(add.y, delay2.u) annotation (Line(points={{7,164},{32,164}},  color={0,0,127}));
  connect(delay2.y, CompValve.opening)
    annotation (Line(points={{55.4,164},{62,164},{62,68}},                 color={0,0,127}));
  connect(RotationalSpeed1.y, PID.u_m)
    annotation (Line(points={{229,-174},{306,-174},{306,-104}},            color={0,0,127}));
  connect(max1.u2, PID.y) annotation (Line(points={{422,-28},{354,-28},{354,-92},{317,-92}}, color={0,0,127}));
  connect(PowerValue1.y, max1.u1) annotation (Line(points={{175,106},{238,106},{238,-16},{422,-16}}, color={0,0,127}));
  connect(Denominator.y, division.u2)
    annotation (Line(points={{117,-118},{146,-118},{146,-98},{162,-98}}, color={0,0,127}));
  connect(timeTable.y, division.u1) annotation (Line(points={{121.3,-59},{146,-59},{146,-86},{162,-86}}, color={0,0,127}));
  connect(division.y, PID.u_s) annotation (Line(points={{185,-92},{294,-92}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1)),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-140,140},{140,-140}},
          lineColor={170,170,255},
          textString="P")}),
    Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",
      info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"));
end ChargingMain_V2;