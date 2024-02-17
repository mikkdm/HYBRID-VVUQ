within NHES.Systems.HeatTransport.Examples;
model HTtest_Xe100_Refinery
  extends Modelica.Icons.Example;
  TwoWayTransport twoWayTransport(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nominal_m_flow_supply=22.181,
    nominal_P_sink_supply=4500000,
    nominal_h_sink_supply=3134.44e3,
    L_supply=2000,
    v_supply=0.135611,
    nominal_m_flow_return=22.181,
    nominal_P_sink_return=4500000,
    nominal_h_sink_return=675.90e3,
    L_return=2000,
    v_return=0.002437,
    S_use_T_start=true,
    S_T_a_start=523.15,
    S_T_b_start=523.15,
    R_use_T_start=true,
    R_T_a_start=373.15,
    R_T_b_start=373.15,
    Supply(p_a_start=300000, p_b_start=300000),
    Return(p_a_start=250000, p_b_start=250000))
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=22.181,
    T=644.09,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=22.181,
    T=432.7,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-34},{80,-14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=4500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-34},{-80,-14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=4500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,14},{80,34}})));
equation
  connect(boundary.ports[1], twoWayTransport.port_a_supply)
    annotation (Line(points={{-80,24},{-40,24}}, color={0,127,255}));
  connect(twoWayTransport.port_b_supply, boundary3.ports[1])
    annotation (Line(points={{40,24},{80,24}}, color={0,127,255}));
  connect(boundary1.ports[1], twoWayTransport.port_a_return)
    annotation (Line(points={{80,-24},{40,-24}}, color={0,127,255}));
  connect(twoWayTransport.port_b_return, boundary2.ports[1])
    annotation (Line(points={{-40,-24},{-80,-24}}, color={0,127,255}));
  annotation (experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end HTtest_Xe100_Refinery;
