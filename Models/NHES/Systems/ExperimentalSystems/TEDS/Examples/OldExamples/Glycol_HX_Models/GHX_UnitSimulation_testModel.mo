within NHES.Systems.ExperimentalSystems.TEDS.Examples.OldExamples.Glycol_HX_Models;
model GHX_UnitSimulation_testModel

  extends
    NHES.Systems.ExperimentalSystems.TEDS.BaseClasses_1.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_GlycolHX_v1 CS,
    redeclare replaceable
      NHES.Systems.ExperimentalSystems.TEDS.ControlSystems.ED_Dummy ED,
    redeclare NHES.Systems.ExperimentalSystems.TEDS.Data.Data_Dummy data);

  SI.Energy Q_HX_Oil;
  SI.Energy Q_HX_Gly;
  SI.Area HeatTransferArea_HX;
  SI.Pressure dP_Shell_HX;
  SI.Pressure dP_Tube_HX;

  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.436347384722,
    T=279.82,
    nPorts=1)
    annotation (Placement(transformation(extent={{-76,12},{-60,28}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=282960,
    T=285.93,
    nPorts=1)
    annotation (Placement(transformation(extent={{64,26},{52,14}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Eth_Gly_OutletT(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{26,14},{40,26}})));
  Modelica.Fluid.Sources.MassFlowSource_T Oil_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=1*1.73696520202777777777,
    T=598.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{64,4},{48,-12}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-74,2},{-62,-10}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_005(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{-22,-12},{-38,4}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Eth_Gly_InletT(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{-38,12},{-24,28}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_004(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{26,-10},{42,2}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
    p_a_start_shell=344738,
    p_b_start_shell=282960,
    T_a_start_shell(displayUnit="degC") = 279.82,
    T_b_start_shell(displayUnit="degC") = 285.93,
    p_b_start_tube=100000,
    counterCurrent=true,
    m_flow_a_start_shell=12,
    redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package Medium_shell =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_o_shell=0.28,
        nV=10,
        nTubes=1,
        nR=3,
        length_shell=94.8864,
        dimension_tube=0.0127,
        length_tube=94.8864,
        th_wall=0.00127),
    p_a_start_tube=101000,
    T_a_start_tube(displayUnit="K") = 540,
    T_b_start_tube(displayUnit="K") = 402,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0),
    tube(heatTransfer(
        A0=1.023*0.025,
        B0=0.79,
        C0=0.42)))
    annotation (Placement(transformation(extent={{20,-14},{-3,6}})));
  Modelica.Blocks.Sources.Sine massflow_sin(
    amplitude=0.6,
    f=1/150,
    phase=0.78539816339745,
    offset=0.8,
    startTime=0)
    annotation (Placement(transformation(extent={{128,-36},{108,-16}})));
  Modelica.Blocks.Noise.UniformNoise massflow_Noise(
    samplePeriod=10,
    y_min=0.04,
    y_max=0.14)
    annotation (Placement(transformation(extent={{128,-70},{108,-50}})));
  Modelica.Blocks.Math.Add pseudo_FM_002
    annotation (Placement(transformation(extent={{94,-52},{74,-32}})));
  Modelica.Blocks.Sources.Sine Temp_sin(
    amplitude=70,
    f=1/4000,
    phase=1.0471975511966,
    offset=433,
    startTime=0)
    annotation (Placement(transformation(extent={{128,38},{108,58}})));
  Modelica.Blocks.Noise.UniformNoise Temp_Noise(
    samplePeriod=10,
    y_min=43,
    y_max=73) annotation (Placement(transformation(extent={{128,2},{108,22}})));
  Modelica.Blocks.Math.Add pseudo_TC_004
    annotation (Placement(transformation(extent={{94,18},{74,38}})));
equation
    HeatTransferArea_HX = (Glycol_HX.geometry.D_o_tube)*Glycol_HX.geometry.length_tube*Modelica.Constants.pi*Glycol_HX.geometry.nTubes;
    Q_HX_Oil    =  (Glycol_HX.tube.port_a.h_outflow-Glycol_HX.tube.port_b.h_outflow)*Oil_Mass_Flow.m_flow_in;
    Q_HX_Gly    =  (Glycol_HX.shell.port_b.h_outflow-Glycol_HX.shell.port_a.h_outflow)*Chiller_Mass_Flow.m_flow_in;
    dP_Shell_HX =   Oil_Mass_Flow.ports[1].p - TC_005.port_a.p;
    dP_Tube_HX  =   Glycol_HX.port_a_tube.p - Glycol_HX.port_b_tube.p;

  connect(Eth_Gly_OutletT.port_b, boundary1.ports[1])
    annotation (Line(points={{40,20},{52,20}}, color={0,127,255}));
  connect(TC_005.port_b,boundary2. ports[1])
    annotation (Line(points={{-38,-4},{-62,-4}},    color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Eth_Gly_InletT.port_a)
    annotation (Line(points={{-60,20},{-38,20}}, color={0,127,255}));
  connect(Oil_Mass_Flow.ports[1],TC_004. port_b)
    annotation (Line(points={{48,-4},{42,-4}},    color={0,127,255}));
  connect(sensorBus.Eth_Gly_OutletT, Eth_Gly_OutletT.T) annotation (Line(
      points={{-30,100},{-30,32},{33,32},{33,22.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Blower_Massflow, Chiller_Mass_Flow.m_flow_in) annotation (
     Line(
      points={{30,100},{-82,100},{-82,26.4},{-76,26.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TC_005.port_a, Glycol_HX.port_b_tube)
    annotation (Line(points={{-22,-4},{-3,-4}}, color={0,127,255}));
  connect(Glycol_HX.port_a_tube, TC_004.port_a)
    annotation (Line(points={{20,-4},{26,-4}}, color={0,127,255}));
  connect(Eth_Gly_OutletT.port_a, Glycol_HX.port_b_shell)
    annotation (Line(points={{26,20},{20,20},{20,0.6}}, color={0,127,255}));
  connect(Eth_Gly_InletT.port_b, Glycol_HX.port_a_shell) annotation (Line(
        points={{-24,20},{-8,20},{-8,0.6},{-3,0.6}}, color={0,127,255}));
  connect(massflow_sin.y, pseudo_FM_002.u1) annotation (Line(points={{107,-26},{
          100,-26},{100,-36},{96,-36}}, color={0,0,127}));
  connect(massflow_Noise.y, pseudo_FM_002.u2) annotation (Line(points={{107,-60},
          {100,-60},{100,-48},{96,-48}}, color={0,0,127}));
  connect(pseudo_FM_002.y, Oil_Mass_Flow.m_flow_in)
    annotation (Line(points={{73,-42},{64,-42},{64,-10.4}}, color={0,0,127}));
  connect(Temp_sin.y, pseudo_TC_004.u1) annotation (Line(points={{107,48},{100,48},
          {100,34},{96,34}}, color={0,0,127}));
  connect(Temp_Noise.y, pseudo_TC_004.u2) annotation (Line(points={{107,12},{100,
          12},{100,22},{96,22}}, color={0,0,127}));
  connect(pseudo_TC_004.y, Oil_Mass_Flow.T_in) annotation (Line(points={{73,28},
          {70,28},{70,-7.2},{65.6,-7.2}}, color={0,0,127}));
  annotation (
    defaultComponentName="changeMe",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=20000,
      __Dymola_NumberOfIntervals=2000,
      __Dymola_Algorithm="Dassl"));
end GHX_UnitSimulation_testModel;
