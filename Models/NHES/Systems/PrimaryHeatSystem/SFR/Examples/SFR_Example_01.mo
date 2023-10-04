within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_01
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  Nuclear.CoreSubchannels.SFR_Individual_Geometries
                                   coreSubchannel(
    redeclare package Medium =
        Coolant,
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    Q_nominal=400000000,
    rho_input=CR.y,
    dBeta=-0.0034,
    alpha_coolant=0.0,
    p_a_start=120000,
    p_b_start=100000,
    T_a_start=623.15,
    T_b_start=973.15)
             annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Coolant,
    m_flow=2255,
    T=594.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium =
        Coolant,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{106,-10},{86,10}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = Coolant)
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  TRANSFORM.Controls.LimPID CR(k=1e-8, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{6,32},{26,52}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=741.483)
    annotation (Placement(transformation(extent={{-32,32},{-12,52}})));
equation
  connect(boundary.ports[1], coreSubchannel.port_a)
    annotation (Line(points={{-86,0},{-44,0}}, color={0,127,255}));
  connect(boundary1.ports[1], sensor_T.port_b)
    annotation (Line(points={{86,0},{26,0}}, color={0,127,255}));
  connect(sensor_T.port_a, coreSubchannel.port_b)
    annotation (Line(points={{6,0},{-24,0}}, color={0,127,255}));
  connect(sensor_T.T, CR.u_m)
    annotation (Line(points={{16,3.6},{16,30}}, color={0,0,127}));
  connect(CR.u_s, realExpression.y)
    annotation (Line(points={{4,42},{-11,42}}, color={0,0,127}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_01;