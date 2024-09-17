within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model CS_GlycolHX_simpleProfile

  extends Templates.SubSystem_Standalone.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression T_Out_set(y=data.T_EthGly_Out)
    annotation (Placement(transformation(extent={{-100,-70},{-72,-50}})));
  Controls.LimOffsetPID Glycol_Pump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=5,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.1,
    offset=14,
    init_output=14)
    annotation (Placement(transformation(extent={{-62,-68},{-46,-52}})));
  replaceable Data.Data_GHX                                         data(
      mdot_total=10) constrainedby BalanceOfPlant.RankineCycle.Data.Data_L3
    annotation (Placement(transformation(extent={{74,76},{94,96}})));
  Modelica.Blocks.Sources.Trapezoid HeatDemand(
    amplitude=200000,
    rising=300,
    width=2000,
    falling=300,
    period=4600,
    offset=50000,
    startTime=2000) "This is a pseudo-heat demand coming from outside. "
    annotation (Placement(transformation(extent={{-94,-14},{-78,2}})));
  TRANSFORM.Controls.LimPID Glycol_byPass(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0004,
    Ti=5,
    yMax=0.999,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-48,-14},{-32,2}})));
equation

  connect(T_Out_set.y, Glycol_Pump.u_s)
    annotation (Line(points={{-70.6,-60},{-63.6,-60}}, color={0,0,127}));
  connect(sensorBus.Eth_Gly_OutletT, Glycol_Pump.u_m) annotation (Line(
      points={{-30,-100},{-54,-100},{-54,-69.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Blower_Massflow, Glycol_Pump.y) annotation (Line(
      points={{30,-100},{30,-60},{-45.2,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HeatDemand.y, Glycol_byPass.u_s)
    annotation (Line(points={{-77.2,-6},{-49.6,-6}}, color={0,0,127}));
  connect(actuatorBus.BypassV_Glycol_Opening, Glycol_byPass.y) annotation (Line(
      points={{30,-100},{30,-6},{-31.2,-6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.DeliveredHeat, Glycol_byPass.u_m) annotation (Line(
      points={{-30,-100},{-30,-15.6},{-40,-15.6}},
      color={239,82,82},
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
end CS_GlycolHX_simpleProfile;
