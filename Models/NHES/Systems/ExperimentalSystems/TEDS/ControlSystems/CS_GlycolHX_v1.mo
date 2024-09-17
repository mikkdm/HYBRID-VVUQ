within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model CS_GlycolHX_v1

  extends Templates.SubSystem_Standalone.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression T_Out_set(y=data.T_EthGly_Out)
    annotation (Placement(transformation(extent={{-100,0},{-72,20}})));
  Controls.LimOffsetPID Pump_Glycol(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=5,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.5,
    offset=14,
    init_output=14)
    annotation (Placement(transformation(extent={{-62,2},{-46,18}})));
  replaceable Data.Data_GHX                                         data(
      mdot_total=10) constrainedby BalanceOfPlant.RankineCycle.Data.Data_L3
    annotation (Placement(transformation(extent={{72,74},{92,94}})));
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
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_GlycolHX_v1;
