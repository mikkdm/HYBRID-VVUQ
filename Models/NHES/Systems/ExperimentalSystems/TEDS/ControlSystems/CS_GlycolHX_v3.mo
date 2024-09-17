within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model CS_GlycolHX_v3

  extends Templates.SubSystem_Standalone.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression T_Out_set(y=data.T_EthGly_Out)
    annotation (Placement(transformation(extent={{-100,0},{-72,20}})));
  Controls.LimOffsetPID Pump_Glycol(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=5,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.05,
    offset=10,
    init_output=10)
    annotation (Placement(transformation(extent={{-62,2},{-46,18}})));
  replaceable Data.Data_GHX                                         data(
      mdot_total=10) constrainedby BalanceOfPlant.RankineCycle.Data.Data_L3
    annotation (Placement(transformation(extent={{72,74},{92,94}})));
  Modelica.Blocks.Sources.Trapezoid HeatDemand(
    amplitude=190000,
    rising=300,
    width=2000,
    falling=300,
    period=4600,
    offset=10000,
    startTime=2000) "This is a pseudo-heat demand coming from outside. "
    annotation (Placement(transformation(extent={{-90,64},{-70,84}})));
  TRANSFORM.Controls.LimPID PV009(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0004,
    Ti=5,
    yMax=0.999,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
equation

  connect(T_Out_set.y, Pump_Glycol.u_s)
    annotation (Line(points={{-70.6,10},{-63.6,10}}, color={0,0,127}));
  connect(sensorBus.Eth_Gly_OutletT, Pump_Glycol.u_m) annotation (Line(
      points={{-30,-100},{-54,-100},{-54,0.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Blower_Massflow, Pump_Glycol.y) annotation (Line(
      points={{30,-100},{30,10},{-45.2,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HeatDemand.y, PV009.u_s)
    annotation (Line(points={{-69,74},{-42,74}}, color={0,0,127}));
  connect(sensorBus.RejectedHeat, PV009.u_m) annotation (Line(
      points={{-30,-100},{-30,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PV009_Opening, PV009.y) annotation (Line(
      points={{30,-100},{30,74},{-19,74}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_GlycolHX_v3;
