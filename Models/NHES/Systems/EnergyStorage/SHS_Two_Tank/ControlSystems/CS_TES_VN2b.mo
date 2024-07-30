within NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems;
model CS_TES_VN2b

  extends
    NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

  NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
    annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
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
equation

  connect(one1.y, PID2.u_s)
    annotation (Line(points={{-53.7,-3},{-53.7,-4},{-30,-4},{-30,-7},{-26.6,
          -7}},                                      color={0,0,127}));
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
end CS_TES_VN2b;
