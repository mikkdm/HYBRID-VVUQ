within NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems;
model CS_TES_VN2

  extends
    NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

  NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
    annotation (Placement(transformation(extent={{76,78},{96,98}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-2,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-50,
    rising=500,
    width=1500,
    falling=500,
    period=3000,
    offset=200,
    startTime=5e3)
    annotation (Placement(transformation(extent={{-110,50},{-98,62}})));
  BalanceOfPlant.ReHeatCycle.SupportComponent.MinMaxFilter
    Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={12,64})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-18,74},{-10,82}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
  Modelica.Blocks.Sources.Constant one3(k=-0.25)
    annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
  Modelica.Blocks.Sources.Constant one2(k=20)
    annotation (Placement(transformation(extent={{-88,36},{-82,42}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2.5e-2,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-26,-10},{-20,-4}})));
  Modelica.Blocks.Sources.Constant one1(k=500 + 273.15)
    annotation (Placement(transformation(extent={{-60,-6},{-54,0}})));
  Modelica.Blocks.Sources.Constant one4(k=-0.25)
    annotation (Placement(transformation(extent={{-80,70},{-74,76}})));
equation

  connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},
          {-24,80.4},{-18.8,80.4}},                    color={0,0,127}));
  connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
          74.8},{-36.6,74.8}},                                    color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
          -36.6,71.2}},                                      color={0,0,127}));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
    annotation (Line(
      points={{30,-100},{30,64},{23.4,64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one1.y, PID2.u_s)
    annotation (Line(points={{-53.7,-3},{-53.7,-4},{-30,-4},{-30,-7},{-26.6,
          -7}},                                      color={0,0,127}));
  connect(PID3.y, Discharging_Valve_Position.u) annotation (Line(points={{
          -27.6,58},{-10,58},{-10,64},{0,64}}, color={0,0,127}));
  connect(sensorBus.discharge_m_flow, PID3.u_m) annotation (Line(
      points={{-30,-100},{-36,-100},{-36,53.2},{-32,53.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product1.u2, add1.u1) annotation (Line(points={{-18.8,75.6},{-40,
          78},{-40,74.8},{-36.6,74.8}}, color={0,0,127}));
  connect(trapezoid.y, min1.u2) annotation (Line(points={{-97.4,56},{-64,56},
          {-64,63.6},{-56.8,63.6}}, color={0,0,127}));
  connect(one4.y, min1.u1) annotation (Line(points={{-73.7,73},{-65.85,73},
          {-65.85,68.4},{-56.8,68.4}}, color={0,0,127}));
  connect(PID3.u_s, trapezoid.y) annotation (Line(points={{-36.8,58},{-64,
          58},{-64,56},{-97.4,56}}, color={0,0,127}));
  connect(sensorBus.Charge_Temp, PID2.u_m) annotation (Line(
      points={{-30,-100},{-30,-10.6},{-23,-10.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Charge_Valve_Position, PID2.y) annotation (Line(
      points={{30,-100},{30,-7},{-19.7,-7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_TES_VN2;
