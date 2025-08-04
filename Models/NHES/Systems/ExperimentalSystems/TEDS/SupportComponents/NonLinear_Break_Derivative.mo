within NHES.Systems.ExperimentalSystems.TEDS.SupportComponents;
model NonLinear_Break_Derivative
  "Oneway non linear break for fuild systems"
  parameter Modelica.Units.SI.Time gain_pressure = 1;
  parameter Modelica.Units.SI.Time gain_mass_flow = 1;
  parameter Modelica.Units.SI.Time gain_enthalpy = 1;

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{76,0},{56,20}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-70,10},{-50,-10}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-90,0},{-70,-20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_h_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
initial equation
  sensor_h.h_out = boundary1.h_in;
  sensor_m_flow.m_flow = boundary1.m_flow_in;
  boundary.p_in = sensor_p.p;
equation
  der(boundary1.h_in) = gain_enthalpy*(sensor_h.h_out - boundary1.h_in);
  der(boundary1.m_flow_in) = gain_mass_flow*(sensor_m_flow.m_flow - boundary1.m_flow_in);
  der(boundary.p_in) = gain_pressure*(sensor_p.p - boundary.p_in);
  connect(boundary1.ports[1], sensor_p.port)
    annotation (Line(points={{40,0},{66,0}}, color={0,127,255}));
  connect(sensor_p.port, port_b)
    annotation (Line(points={{66,0},{100,0}}, color={0,127,255}));
  connect(port_a, sensor_h.port)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(sensor_h.port, sensor_m_flow.port_a)
    annotation (Line(points={{-80,0},{-70,0}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, boundary.ports[1])
    annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{20,-44},{60,-59},{20,-74},{20,-44}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,-49},{50,-59},{20,-69},{20,-49}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,-59},{-60,-59}},
          color={0,128,255},
          visible=showDesignFlowDirection),
        Rectangle(
          extent={{-100,2},{102,-4}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-14,-20},{8,20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-14,-22},{8,18}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-12,-20},{10,20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-12,-22},{10,18}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-12,-24},{10,16}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-10,-22},{12,18}},
          color={28,108,200},
          thickness=1),
        Ellipse(
          extent={{-3.5,2.5},{3.5,-2.5}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={9.5,18.5},
          rotation=90),
        Ellipse(
          extent={{-3,2},{3,-2}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={-12,-21},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-16,8},{2,26}}, color={28,108,200}),
        Line(points={{2,26},{60,10}}, color={28,108,200}),
        Line(points={{-74,-10},{-38,-42}}, color={28,108,200}),
        Line(points={{-38,-42},{18,4}}, color={28,108,200}),
        Line(points={{-34,-24},{18,8}}, color={28,108,200}),
        Line(points={{-60,-4},{-34,-24}}, color={28,108,200})}));
end NonLinear_Break_Derivative;
