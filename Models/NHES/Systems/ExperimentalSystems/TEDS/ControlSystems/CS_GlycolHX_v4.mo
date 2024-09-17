within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model CS_GlycolHX_v4

  extends Templates.SubSystem_Standalone.BaseClasses.Partial_ControlSystem;

  Controls.LimOffsetPID Pump_Glycol(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=5,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.5,
    offset=14,
    init_output=14)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  replaceable Data.Data_GHX                                         data(
      mdot_total=10) constrainedby BalanceOfPlant.RankineCycle.Data.Data_L3
    annotation (Placement(transformation(extent={{72,74},{92,94}})));
  Modelica.Blocks.Sources.Trapezoid HeatDemand(
    amplitude=350000,
    rising=300,
    width=2000,
    falling=300,
    period=4600,
    offset=50000,
    startTime=2000) "This is a pseudo-heat demand coming from outside. "
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Sources.Constant PV009(k=0)
    annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Modelica.Blocks.Sources.RealExpression T_Out_set(y=data.T_EthGly_Out)
    annotation (Placement(transformation(extent={{-128,0},{-100,20}})));
  TRANSFORM.Controls.LimPID BypassV_Glycol(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0004,
    Ti=5,
    yMax=0.999,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation

  connect(actuatorBus.PV009_Opening, PV009.y) annotation (Line(
      points={{30,-100},{30,10},{79,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(T_Out_set.y, Pump_Glycol.u_s)
    annotation (Line(points={{-98.6,10},{-82,10}}, color={0,0,127}));
  connect(sensorBus.Eth_Gly_OutletT, Pump_Glycol.u_m) annotation (Line(
      points={{-30,-100},{-70,-100},{-70,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Chiller_Massflow, Pump_Glycol.y) annotation (Line(
      points={{30,-100},{30,10},{-59,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HeatDemand.y, BypassV_Glycol.u_s)
    annotation (Line(points={{-99,50},{-62,50}}, color={0,0,127}));
  connect(sensorBus.RejectedHeat, BypassV_Glycol.u_m) annotation (Line(
      points={{-30,-100},{-50,-100},{-50,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.BypassV_Glycol_Opening, BypassV_Glycol.y) annotation (
      Line(
      points={{30,-100},{30,50},{-39,50}},
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
end CS_GlycolHX_v4;
