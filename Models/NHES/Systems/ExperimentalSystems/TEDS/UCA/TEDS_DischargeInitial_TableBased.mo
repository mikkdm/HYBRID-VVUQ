within NHES.Systems.ExperimentalSystems.TEDS.UCA;
model TEDS_DischargeInitial_TableBased
  "Test designed to ensure the TEDS loop can operate in all modes."

  parameter Real FV_opening=0.00250;

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Chromolox_Heater(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_a_start=system.p_ambient,
    T_a_start=system.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=3, dimensions=fill(0.076, Chromolox_Heater.nV)),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
    annotation (Placement(transformation(extent={{-66,66},{-50,82}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{46,68},{62,84}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-103,-47})));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    length=0.1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={214,-18})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=0.1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=Chromolox_Heater.h_b_start)
    annotation (Placement(transformation(extent={{-6,72},{10,88}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=298.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{-154,92},{-134,112}})));
  Data.Data_TEDS data(T_hot_side=523.15, T_cold_side=298.15)
    annotation (Placement(transformation(extent={{-154,118},{-134,138}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_002(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-98,62},{-74,84}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-40,62},{-16,86}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=700, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={206,-144})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_thot(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,46})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={214,48})));
  TRANSFORM.Fluid.Sensors.MassFlowRate Chiller_Mass_flow_T66(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{9.5,10.5},{-9.5,-10.5}},
        rotation=90,
        origin={124.5,-199.5})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_049(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={84,66})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_050(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={176,62})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_051(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={56,-106})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_052(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={174,-130})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_006(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840,
    dp(start=100, fixed=true))
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={132,76})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-10},{12,10}},
        rotation=0,
        origin={24,-106})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={160,-105})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_004(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-90,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_003(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{9,-8},{-9,8}},
        rotation=270,
        origin={-103,-98})));
  Controls.Control_System_TEDS_ExpTest_Discharging_July_2023_LargerTables
                                                                    Control_System(
      T_hot_design=523.15)
    annotation (Placement(transformation(extent={{0,154},{40,190}})));
  BaseClasses_1.SignalSubBus_ActuatorInput Sen
    annotation (Placement(transformation(extent={{-72,130},{-50,154}})));
  BaseClasses_1.SignalSubBus_SensorOutput Ac
    annotation (Placement(transformation(extent={{-30,130},{-8,154}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={157,47})));
  Models.ThermoclineTank.Thermocline_Full_Insulation_UQVV_FillerCpVarying_MultiSection_MultiPorosity_v17
    thermocline(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package InsulationMaterial = NHES.Media.Solids.FoamGlass,
    T_Init=(293.15 + 45)*ones(thermocline.TES.nodes),
    geometry(
      Radius_Tank=0.438,
      Porosity=(0.36)*ones(thermocline.TES.nodes),
      dr=0.00317,
      Insulation_thickness=3*0.051,
      Wall_Thickness=0.019,
      Height_Tank=4.435,
      XS_Fluid=(0.36)*ones(thermocline.TES.nodes)*Modelica.Constants.pi*(0.438)))
    annotation (Placement(transformation(extent={{22,-46},{54,-2}})));
  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{30,-248},{50,-228}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{210,-230},{190,-250}})));

  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
    p_b_start_shell=system.p_ambient,
    T_a_start_shell=data.T_hot_side,
    T_b_start_shell=data.T_cold_side,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=Chiller_Mass_Flow.m_flow,
    m_flow_a_start_shell=12.6,
    redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    redeclare package Medium_shell =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_o_shell=0.192,
        nV=10,
        nTubes=113,
        nR=3,
        length_shell=3.0,
        dimension_tube=0.013,
        length_tube=3.0,
        th_wall=0.0001),
    p_a_start_tube=boundary1.p + 100,
    T_a_start_tube=Chiller_Mass_Flow.T,
    T_b_start_tube=boundary1.T,
    p_a_start_shell=system.p_ambient + 100,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0))
    annotation (Placement(transformation(extent={{77,-254},{108,-224}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{140,-252},{170,-228}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_006(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{16,-132},{40,-158}})));
  Modelica.Blocks.Sources.RealExpression realExpression[Chromolox_Heater.geometry.nV](y=fill(
        W_heater.y/Chromolox_Heater.geometry.nV, Chromolox_Heater.geometry.nV))
    annotation (Placement(transformation(extent={{-120,88},{-100,108}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=Chromolox_Heater.geometry.nV, use_port=true)
    annotation (Placement(transformation(extent={{-86,82},{-66,102}})));
  Modelica.Blocks.Math.Sum chromoloxHeater_Power(nin=Chromolox_Heater.geometry.nV)
    annotation (Placement(transformation(extent={{-78,114},{-66,126}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_ch_o(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=180,
        origin={126,-105})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=-90,
        origin={38,21})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_outlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=0,
        origin={124,47})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=90,
        origin={38,-69})));
  TRANSFORM.Fluid.Sensors.MassFlowRate BOP_Mass_flow(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,76})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_004(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-9,12},{9,-12}},
        rotation=90,
        origin={124,-223})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={214,15})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,12},{12,-12}},
        rotation=270,
        origin={214,-64})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003a(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{18,64},{42,88}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{-4,-154},{-20,-138}})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=pump.port_a.p +
        2.0e4)
    annotation (Placement(transformation(extent={{24,-140},{-2,-116}})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_012(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={56,-182})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_009(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={92,-144})));
  SupportComponents.NonLinear_Break
                              nonLinear_Break(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=270,
        origin={56,-226})));
  SupportComponents.NonLinear_Break
                              nonLinear_Break2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={6,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_001(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-24,-154},{-42,-138}})));
  TRANSFORM.Fluid.Valves.ValveLinear ValveFl(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-54,-146})));
  SupportComponents.NonLinear_Break
                              nonLinear_Break1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-62,-106})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand2(y=1/
        FM_001.Medium.density_ph(FM_001.port_b.p, FM_001.port_b.h_outflow))
    annotation (Placement(transformation(extent={{28,12},{-28,-12}},
        rotation=90,
        origin={-36,2})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-50,-76},{-70,-56}})));
  Modelica.Blocks.Sources.RealExpression Q_GHX(y=Glycol_HX.port_a_shell.m_flow*
        (Chiller_Mass_flow_T66.port_b.h_outflow - Glycol_HX.port_b_shell.h_outflow))
    annotation (Placement(transformation(extent={{64,-218},{102,-196}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_005(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=270,
        origin={56,-160})));
  SupportComponents.NonLinear_Break_Derivative
                              nonLinear_Break_Derivative(
                                               redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={112,-144})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=10,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-26,-114},{-10,-98}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=4,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{80,40},{66,54}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe6(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=10,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={68,-88})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_008(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=100,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={190,-176})));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=7,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=10, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={148,-186})));
  Modelica.Fluid.Pipes.DynamicPipe pipe9(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={98,-106})));
  Modelica.Fluid.Pipes.DynamicPipe pipe10(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={100,48})));
  Modelica.Blocks.Math.Gain W_heater(k=1)
    annotation (Placement(transformation(extent={{-114,114},{-100,128}})));
  SupportComponents.NonLinear_Break
                              nonLinear_Break5(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=90,
        origin={214,-102})));
  Modelica.Blocks.Sources.TimeTable Tf_8_Exp(table=[0,522.442328; 60.05,
        522.616847; 120.089,522.800769; 180.096,522.987877; 240.018,523.180212;
        300.059,523.366907; 360.086,523.440908; 420.095,523.363899; 480.085,
        523.09251; 540.102,522.713107; 600.046,522.222899; 660.101,521.677109;
        720.101,521.094385; 780.042,520.560081; 840.045,520.006673; 900.006,
        519.443381; 960.108,518.897772; 1020.01,518.36609; 1080.085,517.867657;
        1140.043,517.369889; 1200.078,516.914995; 1260.105,516.46313; 1320.088,
        516.041708; 1380.002,515.667413; 1440.048,515.311072; 1500.094,
        514.98592; 1560.012,514.697341; 1620.086,514.469408; 1680.022,
        514.282111; 1740.05,514.047262; 1800.018,513.842209; 1860.018,
        513.637132; 1920.003,513.42736; 1980.109,513.19311; 2040.091,513.084817;
        2100.074,514.023522; 2160.112,515.109963; 2220.091,515.892594; 2280.1,
        516.291998; 2340.003,516.587782; 2400.029,516.915407; 2460.055,
        517.146973; 2520.003,517.268395; 2580.11,517.422942; 2640.013,
        517.443297; 2700.015,517.3411; 2779.084,517.240662; 2839.039,517.215772;
        2899.037,517.186118; 2959.097,517.053993; 3019.084,516.906572; 3079.047,
        516.797021; 3139.079,516.669871; 3199.038,516.496625; 3259.045,
        516.387992; 3319.101,516.288763; 3379.057,516.140976; 3439.083,
        516.06858; 3499.093,515.965147; 3559.04,515.847297; 3619.071,515.749722;
        3679.039,515.573634; 3739.103,515.325503; 3799.091,515.011748; 3859.056,
        514.641105; 3919.096,514.229999; 3979.106,513.821206; 4039.042,
        513.460939; 4099.049,513.141625; 4159.062,512.825578; 4219.015,
        512.537159; 4279.115,512.225368; 4339.078,511.870466; 4399.103,
        511.555811; 4459.048,511.202221; 4519.047,510.873187; 4579.006,
        510.53751; 4639.016,510.16387; 4699.083,509.753218; 4759.041,509.391849;
        4819.015,508.966582; 4882.929,508.502477; 4950.629,508.013725; 5013.009,
        507.505352; 5073.067,506.977586; 5133.026,506.401218; 5193.001,
        505.767029; 5253.137,505.136923; 5313.916,504.501805; 5373.03,
        503.861827; 5433.112,503.169904; 5493.1,502.461925; 5553.032,501.767657;
        5613.072,501.300748; 5673.094,500.993908; 5733.002,500.751119; 5793.018,
        500.479838; 5853.105,500.1505; 5913.039,499.816815; 5976.019,499.46846;
        6000,499.46846], offset=-273.15) annotation (Placement(transformation(extent={{-276,
            166},{-256,186}})));
  Modelica.Blocks.Sources.TimeTable Tf_13_Exp(table=[0,521.041116; 60.05,
        521.192191; 120.089,521.323596; 180.096,521.477789; 240.018,521.620507;
        300.059,521.769181; 360.086,521.839858; 420.095,521.836535; 480.085,
        521.822684; 540.102,521.783432; 600.046,521.76162; 660.101,521.748062;
        720.101,521.709468; 780.042,521.686029; 840.045,521.662139; 900.006,
        521.63877; 960.108,521.605981; 1020.01,521.575233; 1080.085,521.547369;
        1140.043,521.521369; 1200.078,521.499403; 1260.105,521.454285; 1320.088,
        521.428149; 1380.002,521.403399; 1440.048,521.350563; 1500.094,
        521.324244; 1560.012,521.282252; 1620.086,521.259555; 1680.022,
        521.207496; 1740.05,521.166299; 1800.018,521.134864; 1860.018,
        521.079215; 1920.003,521.038781; 1980.109,520.997958; 2040.091,
        520.944321; 2100.074,520.829254; 2160.112,520.67306; 2220.091,
        520.491451; 2280.1,520.277014; 2340.003,520.06879; 2400.029,519.821454;
        2460.055,519.561315; 2520.003,519.3187; 2580.11,519.000096; 2640.013,
        518.723145; 2700.015,518.428142; 2779.084,518.04653; 2839.039,
        517.789211; 2899.037,517.520843; 2959.097,517.250225; 3019.084,
        517.021587; 3079.047,516.789008; 3139.079,516.554274; 3199.038,
        516.305103; 3259.045,516.063357; 3319.101,515.804736; 3379.057,
        515.552046; 3439.083,515.285463; 3499.093,515.02089; 3559.04,514.746731;
        3619.071,514.442654; 3679.039,514.133053; 3739.103,513.81824; 3799.091,
        513.460498; 3859.056,513.077894; 3919.096,512.685972; 3979.106,
        512.270347; 4039.042,511.845109; 4099.049,511.353775; 4159.062,
        510.858087; 4219.015,510.33197; 4279.115,509.782824; 4339.078,
        509.175847; 4399.103,508.547356; 4459.048,507.910245; 4519.047,
        507.220129; 4579.006,506.539383; 4639.016,505.815236; 4699.083,
        505.069386; 4759.041,504.315139; 4819.015,503.572845; 4882.929,
        502.71974; 4950.629,501.827337; 5013.009,501.011074; 5073.067,
        500.210953; 5133.026,499.440266; 5193.001,498.66219; 5253.137,
        497.885301; 5313.916,497.110081; 5373.03,496.33363; 5433.112,495.516632;
        5493.1,494.663249; 5553.032,493.78536; 5613.072,493.418429; 5673.094,
        493.291364; 5733.002,493.211802; 5793.018,493.185679; 5853.105,
        493.149418; 5913.039,493.129046; 5976.019,493.126847; 6000,493.126847], offset=
        0.0)          annotation (Placement(transformation(extent={{-252,100},{-232,
            120}})));
  Modelica.Blocks.Sources.TimeTable Tf_18_Exp(table=[0,519.611295; 60.05,
        519.881208; 120.089,520.139787; 180.096,520.41881; 240.018,520.687238;
        300.059,520.953332; 360.086,521.055266; 420.095,521.064046; 480.085,
        521.037427; 540.102,521.019561; 600.046,521.013762; 660.101,520.968471;
        720.101,520.938075; 780.042,520.919252; 840.045,520.89231; 900.006,
        520.854163; 960.108,520.824725; 1020.01,520.788396; 1080.085,520.769412;
        1140.043,520.717958; 1200.078,520.6911; 1260.105,520.654814; 1320.088,
        520.63296; 1380.002,520.595814; 1440.048,520.562077; 1500.094,
        520.517438; 1560.012,520.478423; 1620.086,520.45163; 1680.022,
        520.414384; 1740.05,520.38168; 1800.018,520.337689; 1860.018,520.30304;
        1920.003,520.270751; 1980.109,520.220128; 2040.091,520.156476; 2100.074,
        519.966687; 2160.112,519.728028; 2220.091,519.450557; 2280.1,519.161783;
        2340.003,518.882138; 2400.029,518.625571; 2460.055,518.360879; 2520.003,
        518.102387; 2580.11,517.827681; 2640.013,517.584355; 2700.015,
        517.326726; 2779.084,516.988789; 2839.039,516.746316; 2899.037,
        516.492249; 2959.097,516.209161; 3019.084,515.956952; 3079.047,
        515.687226; 3139.079,515.406635; 3199.038,515.088569; 3259.045,
        514.772113; 3319.101,514.405123; 3379.057,514.037154; 3439.083,
        513.639238; 3499.093,513.193466; 3559.04,512.726211; 3619.071,
        512.241316; 3679.039,511.698601; 3739.103,511.128207; 3799.091,
        510.541109; 3859.056,509.905579; 3919.096,509.25923; 3979.106,
        508.553349; 4039.042,507.85181; 4099.049,507.099174; 4159.062,
        506.324114; 4219.015,505.555999; 4279.115,504.720887; 4339.078,
        503.883827; 4399.103,503.052885; 4459.048,502.205786; 4519.047,
        501.38844; 4579.006,500.581548; 4639.016,499.762221; 4699.083,
        498.954963; 4759.041,498.161518; 4819.015,497.355933; 4882.929,
        496.492315; 4950.629,495.543181; 5013.009,494.604246; 5073.067,
        493.639254; 5133.026,492.599036; 5193.001,491.478297; 5253.137,
        490.250634; 5313.916,488.890137; 5373.03,487.438143; 5433.112,
        485.795097; 5493.1,484.03144; 5553.032,482.149492; 5613.072,481.323619;
        5673.094,481.050156; 5733.002,480.9074; 5793.018,480.834586; 5853.105,
        480.773022; 5913.039,480.752442; 5976.019,480.754652; 6000,480.754652], offset=
        0.0)          annotation (Placement(transformation(extent={{-242,66},{-222,
            86}})));
  Modelica.Blocks.Sources.TimeTable Tf_22pt5_Exp(table=[0,518.961136; 60.05,
        519.1722297; 120.089,519.3638707; 180.096,519.5675267; 240.018,
        519.7518967; 300.059,519.9814223; 360.086,520.0851723; 420.095,
        520.106927; 480.085,520.121305; 540.102,520.1048727; 600.046,520.107392;
        660.101,520.0857063; 720.101,520.0706477; 780.042,520.0494137; 840.045,
        520.036278; 900.006,520.0198973; 960.108,519.9997823; 1020.01,
        519.968967; 1080.085,519.9516263; 1140.043,519.933547; 1200.078,
        519.913648; 1260.105,519.8837627; 1320.088,519.8616363; 1380.002,
        519.855141; 1440.048,519.828844; 1500.094,519.7969723; 1560.012,
        519.7800907; 1620.086,519.7566193; 1680.022,519.746116; 1740.05,
        519.712915; 1800.018,519.7006747; 1860.018,519.6641233; 1920.003,
        519.655082; 1980.109,519.629686; 2040.091,519.6037533; 2100.074,
        519.4943777; 2160.112,519.327152; 2220.091,519.1445043; 2280.1,
        518.9174337; 2340.003,518.7028393; 2400.029,518.4751287; 2460.055,
        518.231914; 2520.003,517.977273; 2580.11,517.701618; 2640.013,
        517.441191; 2700.015,517.1584013; 2779.084,516.765457; 2839.039,
        516.4479183; 2899.037,516.10566; 2959.097,515.7110817; 3019.084,
        515.316086; 3079.047,514.9003817; 3139.079,514.423048; 3199.038,
        513.919832; 3259.045,513.3775833; 3319.101,512.7850313; 3379.057,
        512.14528; 3439.083,511.4518123; 3499.093,510.7296943; 3559.04,
        509.9523083; 3619.071,509.1470237; 3679.039,508.3066807; 3739.103,
        507.450946; 3799.091,506.5710313; 3859.056,505.6731933; 3919.096,
        504.8044457; 3979.106,503.911624; 4039.042,503.0646777; 4099.049,
        502.1957807; 4159.062,501.3578723; 4219.015,500.54844; 4279.115,
        499.7216533; 4339.078,498.8749807; 4399.103,498.0303377; 4459.048,
        497.138812; 4519.047,496.2168633; 4579.006,495.228534; 4639.016,
        494.1492287; 4699.083,492.9479287; 4759.041,491.655054; 4819.015,
        490.2673667; 4882.929,488.5846813; 4950.629,486.6063997; 5013.009,
        484.637245; 5073.067,482.5239187; 5133.026,480.268853; 5193.001,
        477.8168347; 5253.137,475.0982113; 5313.916,472.2060397; 5373.03,
        469.1327683; 5433.112,465.7143143; 5493.1,462.087141; 5553.032,
        458.2732493; 5613.072,456.3848937; 5673.094,455.5991607; 5733.002,
        455.1262367; 5793.018,454.8502033; 5853.105,454.6794547; 5913.039,
        454.571228; 5976.019,454.5028407; 6000,454.5028407], offset=0.0)
    annotation (Placement(transformation(extent={{-278,6},{-258,26}})));
  Modelica.Blocks.Sources.TimeTable Tf_26_Exp(table=[0,516.9828843; 60.05,
        517.2225773; 120.089,517.4466897; 180.096,517.6623687; 240.018,
        517.8623407; 300.059,518.080252; 360.086,518.1818253; 420.095,
        518.1949613; 480.085,518.1971033; 540.102,518.187804; 600.046,
        518.1733473; 660.101,518.1446947; 720.101,518.1201867; 780.042,
        518.1083637; 840.045,518.086955; 900.006,518.054613; 960.108,518.039994;
        1020.01,518.0078103; 1080.085,517.9834137; 1140.043,517.9643123;
        1200.078,517.9358517; 1260.105,517.9083093; 1320.088,517.8891747;
        1380.002,517.871779; 1440.048,517.8365523; 1500.094,517.8127293;
        1560.012,517.7932323; 1620.086,517.771574; 1680.022,517.749711; 1740.05,
        517.7176147; 1800.018,517.6964547; 1860.018,517.675681; 1920.003,
        517.6531517; 1980.109,517.6260147; 2040.091,517.5998907; 2100.074,
        517.4952643; 2160.112,517.331804; 2220.091,517.1241133; 2280.1,
        516.856377; 2340.003,516.5813493; 2400.029,516.2683237; 2460.055,
        515.918111; 2520.003,515.530857; 2580.11,515.0808307; 2640.013,
        514.625918; 2700.015,514.121068; 2779.084,513.3810003; 2839.039,
        512.76545; 2899.037,512.1142953; 2959.097,511.362338; 3019.084,
        510.5961907; 3079.047,509.7804613; 3139.079,508.9224267; 3199.038,
        508.022089; 3259.045,507.0976387; 3319.101,506.132358; 3379.057,
        505.172575; 3439.083,504.2072247; 3499.093,503.264191; 3559.04,
        502.3410087; 3619.071,501.4461113; 3679.039,500.5800403; 3739.103,
        499.7301707; 3799.091,498.882888; 3859.056,498.0257477; 3919.096,
        497.148293; 3979.106,496.2068733; 4039.042,495.234436; 4099.049,
        494.1124407; 4159.062,492.9072583; 4219.015,491.6035027; 4279.115,
        490.096991; 4339.078,488.4443083; 4399.103,486.6245067; 4459.048,
        484.6206843; 4519.047,482.42384; 4579.006,480.0747443; 4639.016,
        477.4746163; 4699.083,474.607423; 4759.041,471.538044; 4819.015,
        468.2603373; 4882.929,464.3900023; 4950.629,459.9089367; 5013.009,
        455.513289; 5073.067,450.8922847; 5133.026,446.1559343; 5193.001,
        441.1014017; 5253.137,435.754781; 5313.916,430.2818063; 5373.03,
        424.724368; 5433.112,418.8296327; 5493.1,412.9886073; 5553.032,
        407.4528387; 5613.072,404.904453; 5673.094,403.9200473; 5733.002,
        403.4145037; 5793.018,403.1422123; 5853.105,402.9958817; 5913.039,
        402.9571627; 5976.019,402.9630133; 6000,402.9630133], offset=0.0)
    annotation (Placement(transformation(extent={{-240,-12},{-220,8}})));
  Modelica.Blocks.Sources.TimeTable Tf_30_Exp(table=[0,513.866171; 60.05,
        514.3398597; 120.089,514.7633743; 180.096,515.1552137; 240.018,
        515.5160867; 300.059,515.865381; 360.086,516.0304673; 420.095,
        516.054232; 480.085,516.0599167; 540.102,516.0448823; 600.046,
        516.0242627; 660.101,515.9963343; 720.101,515.9621243; 780.042,
        515.9412287; 840.045,515.895481; 900.006,515.8697213; 960.108,
        515.8125813; 1020.01,515.7964773; 1080.085,515.7439223; 1140.043,
        515.7087027; 1200.078,515.6665467; 1260.105,515.635012; 1320.088,
        515.5971053; 1380.002,515.5659413; 1440.048,515.509839; 1500.094,
        515.473351; 1560.012,515.4345153; 1620.086,515.388934; 1680.022,
        515.3501603; 1740.05,515.312403; 1800.018,515.2682483; 1860.018,
        515.2336053; 1920.003,515.180885; 1980.109,515.1394107; 2040.091,
        515.0809757; 2100.074,514.871874; 2160.112,514.547105; 2220.091,
        514.115852; 2280.1,513.6177063; 2340.003,513.046423; 2400.029,
        512.409869; 2460.055,511.6950563; 2520.003,510.9310767; 2580.11,
        510.0155933; 2640.013,509.099219; 2700.015,508.1348413; 2779.084,
        506.79076; 2839.039,505.7720313; 2899.037,504.75744; 2959.097,
        503.7355247; 3019.084,502.776666; 3079.047,501.8249083; 3139.079,
        500.940095; 3199.038,500.081978; 3259.045,499.2290113; 3319.101,
        498.374731; 3379.057,497.506686; 3439.083,496.5777613; 3499.093,
        495.5828737; 3559.04,494.4662937; 3619.071,493.24549; 3679.039,
        491.8679897; 3739.103,490.343265; 3799.091,488.6302147; 3859.056,
        486.7330527; 3919.096,484.6573243; 3979.106,482.3828137; 4039.042,
        479.9477627; 4099.049,477.204247; 4159.062,474.2710683; 4219.015,
        471.0960967; 4279.115,467.5413047; 4339.078,463.6888347; 4399.103,
        459.4613757; 4459.048,454.887594; 4519.047,449.949595; 4579.006,
        444.7568323; 4639.016,439.149459; 4699.083,433.2459513; 4759.041,
        427.1469197; 4819.015,420.904755; 4882.929,413.9342357; 4950.629,
        406.5720147; 5013.009,400.4608783; 5073.067,395.5322077; 5133.026,
        392.1224583; 5193.001,390.093023; 5253.137,389.3189323; 5313.916,
        389.492489; 5373.03,390.233467; 5433.112,391.2842303; 5493.1,
        392.4412563; 5553.032,393.5525177; 5613.072,394.1263927; 5673.094,
        394.4210553; 5733.002,394.6181663; 5793.018,394.780265; 5853.105,
        394.9101957; 5913.039,395.0177643; 5976.019,395.1279857; 6000,
        395.1279857], offset=0.0)     annotation (Placement(transformation(extent={{-246,
            -46},{-226,-26}})));
  Modelica.Blocks.Sources.TimeTable Tf_35_Exp(table=[0,495.6569048; 60.05,
        496.817904; 120.089,497.8967055; 180.096,498.8974263; 240.018,
        499.8011245; 300.059,500.6586293; 360.086,501.0656433; 420.095,
        501.2019788; 480.085,501.3019288; 540.102,501.3822373; 600.046,
        501.4553895; 660.101,501.515139; 720.101,501.5669485; 780.042,
        501.6243725; 840.045,501.6642155; 900.006,501.703255; 960.108,
        501.7311725; 1020.01,501.7664838; 1080.085,501.7704305; 1140.043,
        501.8010733; 1200.078,501.8141408; 1260.105,501.8459343; 1320.088,
        501.8656478; 1380.002,501.8847763; 1440.048,501.8960903; 1500.094,
        501.9025473; 1560.012,501.9169223; 1620.086,501.9270305; 1680.022,
        501.9368918; 1740.05,501.9523625; 1800.018,501.960977; 1860.018,
        501.9670693; 1920.003,501.9766108; 1980.109,501.9777005; 2040.091,
        501.9510133; 2100.074,501.472494; 2160.112,500.829618; 2220.091,
        500.0813573; 2280.1,499.2757798; 2340.003,498.4334488; 2400.029,
        497.5605948; 2460.055,496.6543943; 2520.003,495.760765; 2580.11,
        494.8148918; 2640.013,493.9632978; 2700.015,493.162668; 2779.084,
        492.1457848; 2839.039,491.3965388; 2899.037,490.649962; 2959.097,
        489.8202275; 3019.084,488.9386065; 3079.047,487.9524818; 3139.079,
        486.8547293; 3199.038,485.6184133; 3259.045,484.2027673; 3319.101,
        482.5847855; 3379.057,480.7689983; 3439.083,478.7389655; 3499.093,
        476.5636228; 3559.04,474.2422793; 3619.071,471.795724; 3679.039,
        469.1930633; 3739.103,466.3764073; 3799.091,463.2857345; 3859.056,
        459.829003; 3919.096,455.9907665; 3979.106,451.7444503; 4039.042,
        447.168854; 4099.049,442.023292; 4159.062,436.601255; 4219.015,
        430.8387458; 4279.115,424.6788763; 4339.078,418.1595615; 4399.103,
        411.38409; 4459.048,404.8291925; 4519.047,399.3604658; 4579.006,
        395.763345; 4639.016,393.933265; 4699.083,393.4642635; 4759.041,
        393.7202033; 4819.015,394.2733355; 4882.929,394.9420358; 4950.629,
        395.569818; 5013.009,396.0365158; 5073.067,396.400772; 5133.026,
        396.7170843; 5193.001,397.014982; 5253.137,397.3162005; 5313.916,
        397.6020658; 5373.03,397.8850025; 5433.112,398.146936; 5493.1,
        398.385817; 5553.032,398.5766525; 5613.072,398.6659918; 5673.094,
        398.6867908; 5733.002,398.6628115; 5793.018,398.617067; 5853.105,
        398.557852; 5913.039,398.4942345; 5976.019,398.4155088; 6000,
        398.4155088], offset=0.0)     annotation (Placement(transformation(extent={{-242,
            -86},{-222,-66}})));
  Modelica.Blocks.Sources.TimeTable Tf_40_Exp(table=[0,484.0390265; 60.05,
        485.0126423; 120.089,485.9916515; 180.096,487.033179; 240.018,
        488.1397178; 300.059,489.2899055; 360.086,489.953096; 420.095,
        490.2712815; 480.085,490.491009; 540.102,490.6539653; 600.046,
        490.7870388; 660.101,490.9001345; 720.101,490.995964; 780.042,
        491.0982028; 840.045,491.1711653; 900.006,491.2537398; 960.108,
        491.3247738; 1020.01,491.3968178; 1080.085,491.4610243; 1140.043,
        491.519955; 1200.078,491.572652; 1260.105,491.6365385; 1320.088,
        491.6940845; 1380.002,491.743922; 1440.048,491.7916745; 1500.094,
        491.8451588; 1560.012,491.9073245; 1620.086,491.952002; 1680.022,
        492.0033103; 1740.05,492.0536838; 1800.018,492.1019135; 1860.018,
        492.1576555; 1920.003,492.1993218; 1980.109,492.24581; 2040.091,
        492.2484755; 2100.074,491.8205803; 2160.112,491.2996068; 2220.091,
        490.7734413; 2280.1,490.2343528; 2340.003,489.6842838; 2400.029,
        489.1029488; 2460.055,488.4304448; 2520.003,487.6513018; 2580.11,
        486.6751028; 2640.013,485.5694463; 2700.015,484.2978548; 2779.084,
        482.2548068; 2839.039,480.4610815; 2899.037,478.4325338; 2959.097,
        476.1704045; 3019.084,473.7354605; 3079.047,471.0824805; 3139.079,
        468.2769203; 3199.038,465.3296948; 3259.045,462.1755758; 3319.101,
        458.7180885; 3379.057,454.8654093; 3439.083,450.4623695; 3499.093,
        445.4891645; 3559.04,439.9356495; 3619.071,433.8629225; 3679.039,
        427.3764903; 3739.103,420.5122918; 3799.091,413.3720413; 3859.056,
        406.0882075; 3919.096,399.082166; 3979.106,393.09043; 4039.042,
        389.0711775; 4099.049,387.1561528; 4159.062,387.0452578; 4219.015,
        387.9297198; 4279.115,389.1955293; 4339.078,390.473068; 4399.103,
        391.580958; 4459.048,392.5277458; 4519.047,393.371119; 4579.006,
        394.0976465; 4639.016,394.7148313; 4699.083,395.189823; 4759.041,
        395.552319; 4819.015,395.8526293; 4882.929,396.158519; 4950.629,
        396.4569555; 5013.009,396.6943548; 5073.067,396.8813148; 5133.026,
        397.0307348; 5193.001,397.1317953; 5253.137,397.177311; 5313.916,
        397.1789415; 5373.03,397.156665; 5433.112,397.0812315; 5493.1,
        396.9923498; 5553.032,396.8917103; 5613.072,396.829829; 5673.094,
        396.7942135; 5733.002,396.7660385; 5793.018,396.7434825; 5853.105,
        396.7157678; 5913.039,396.6973303; 5976.019,396.6793503; 6000,
        396.6793503], offset=0.0)     annotation (Placement(transformation(extent={{-244,
            -106},{-224,-86}})));
  Modelica.Blocks.Sources.TimeTable Tf_45_Exp(table=[0,484.2035483; 60.05,
        487.864716; 120.089,490.7136147; 180.096,492.8423427; 240.018,
        494.4199117; 300.059,495.6145733; 360.086,496.182311; 420.095,
        496.385902; 480.085,496.4868403; 540.102,496.537256; 600.046,
        496.5597223; 660.101,496.5548907; 720.101,496.5398657; 780.042,
        496.5248177; 840.045,496.4777953; 900.006,496.4407193; 960.108,
        496.3925767; 1020.01,496.3486797; 1080.085,496.290132; 1140.043,
        496.2391267; 1200.078,496.1799027; 1260.105,496.1204913; 1320.088,
        496.060333; 1380.002,496.0071737; 1440.048,495.9322777; 1500.094,
        495.8604217; 1560.012,495.800569; 1620.086,495.7335523; 1680.022,
        495.6578757; 1740.05,495.582759; 1800.018,495.5199557; 1860.018,
        495.452178; 1920.003,495.3687877; 1980.109,495.3078727; 2040.091,
        495.198721; 2100.074,494.6227057; 2160.112,493.6570847; 2220.091,
        492.350394; 2280.1,490.734145; 2340.003,488.8259037; 2400.029,
        486.650911; 2460.055,484.1245957; 2520.003,481.278426; 2580.11,
        478.025965; 2640.013,474.626943; 2700.015,471.1027503; 2779.084,
        465.907965; 2839.039,461.4386707; 2899.037,456.258559; 2959.097,
        450.2616773; 3019.084,443.487279; 3079.047,435.9174133; 3139.079,
        427.7904377; 3199.038,419.271955; 3259.045,410.4180953; 3319.101,
        401.3999377; 3379.057,392.7336183; 3439.083,385.0080887; 3499.093,
        379.2861567; 3559.04,376.5081723; 3619.071,376.6841613; 3679.039,
        378.7896293; 3739.103,381.756837; 3799.091,384.85161; 3859.056,
        387.6811647; 3919.096,390.1282583; 3979.106,392.1391823; 4039.042,
        393.7027373; 4099.049,394.9207897; 4159.062,395.80616; 4219.015,
        396.4730807; 4279.115,396.980699; 4339.078,397.4003553; 4399.103,
        397.7841273; 4459.048,398.1658573; 4519.047,398.5649003; 4579.006,
        398.9481417; 4639.016,399.2930083; 4699.083,399.594864; 4759.041,
        399.8383543; 4819.015,399.9889013; 4882.929,400.0957743; 4950.629,
        400.1243517; 5013.009,400.0802463; 5073.067,400.002649; 5133.026,
        399.8978247; 5193.001,399.786772; 5253.137,399.6825523; 5313.916,
        399.576453; 5373.03,399.5283983; 5433.112,399.512993; 5493.1,
        399.5679423; 5553.032,399.6662097; 5613.072,399.7276917; 5673.094,
        399.7834497; 5733.002,399.845989; 5793.018,399.9119933; 5853.105,
        399.9701067; 5913.039,400.033397; 5976.019,400.0957853; 6000,
        400.0957853], offset=0.0)     annotation (Placement(transformation(extent={{-246,
            -158},{-226,-138}})));
  Modelica.Blocks.Sources.TimeTable Tf_54pt5_Exp(table=[0,422.5466835; 60.05,
        425.4132093; 120.089,428.9804293; 180.096,433.1641308; 240.018,
        437.8423135; 300.059,441.803456; 360.086,443.7828045; 420.095,
        445.1977133; 480.085,445.9238228; 540.102,446.2429143; 600.046,
        446.30691; 660.101,446.1626918; 720.101,445.8684978; 780.042,
        445.4729538; 840.045,444.9410375; 900.006,444.2080795; 960.108,
        443.1475555; 1020.01,441.7929613; 1080.085,440.1239123; 1140.043,
        438.2780885; 1200.078,436.3535848; 1260.105,434.4012783; 1320.088,
        432.4993758; 1380.002,430.6760728; 1440.048,428.8734515; 1500.094,
        427.21899; 1560.012,425.677288; 1620.086,424.1928483; 1680.022,
        422.8504533; 1740.05,421.5666043; 1800.018,420.419833; 1860.018,
        419.33598; 1920.003,418.3532935; 1980.109,417.4218498; 2040.091,
        416.3321738; 2100.074,411.5755098; 2160.112,405.2473675; 2220.091,
        398.975906; 2280.1,393.040592; 2340.003,387.5780755; 2400.029,
        382.3636203; 2460.055,377.4181693; 2520.003,373.0584328; 2580.11,
        369.8631413; 2640.013,368.809855; 2700.015,369.178056; 2779.084,
        370.6109663; 2839.039,371.8712123; 2899.037,373.1050023; 2959.097,
        374.1614545; 3019.084,375.04772; 3079.047,375.9797525; 3139.079,
        377.1160208; 3199.038,378.3352898; 3259.045,379.4907963; 3319.101,
        380.4628155; 3379.057,381.2956515; 3439.083,382.0139713; 3499.093,
        382.6544198; 3559.04,383.2260713; 3619.071,383.747274; 3679.039,
        384.181622; 3739.103,384.5667213; 3799.091,384.891216; 3859.056,
        385.1973813; 3919.096,385.5209238; 3979.106,385.8522008; 4039.042,
        386.191699; 4099.049,386.5356075; 4159.062,386.844383; 4219.015,
        387.1442613; 4279.115,387.428193; 4339.078,387.6515178; 4399.103,
        387.8341183; 4459.048,387.965456; 4519.047,388.0524583; 4579.006,
        388.116767; 4639.016,388.152331; 4699.083,388.178485; 4759.041,
        388.1918003; 4819.015,388.217393; 4882.929,388.2354545; 4950.629,
        388.3194078; 5013.009,388.4372698; 5073.067,388.5798638; 5133.026,
        388.7359845; 5193.001,388.8900273; 5253.137,389.0471328; 5313.916,
        389.1737678; 5373.03,389.280949; 5433.112,389.375033; 5493.1,
        389.4465243; 5553.032,389.4928313; 5613.072,389.468177; 5673.094,
        389.452864; 5733.002,389.457556; 5793.018,389.4773818; 5853.105,
        389.4958103; 5913.039,389.5360788; 5976.019,389.5689705; 6000,
        389.5689705], offset=0.0)     annotation (Placement(transformation(extent={{-252,
            -240},{-232,-220}})));
  Modelica.Blocks.Sources.TimeTable Tf_50_Exp(table=[0,461.5598403; 60.05,
        463.8523158; 120.089,466.069623; 180.096,468.2191513; 240.018,
        470.2589853; 300.059,472.2642473; 360.086,473.075735; 420.095,
        473.1382105; 480.085,472.9684698; 540.102,472.65621; 600.046,
        472.2695643; 660.101,471.8204325; 720.101,471.336868; 780.042,
        470.8598943; 840.045,470.3844288; 900.006,469.9325373; 960.108,
        469.4935118; 1020.01,469.092556; 1080.085,468.7227295; 1140.043,
        468.3813168; 1200.078,468.0814228; 1260.105,467.805451; 1320.088,
        467.5829085; 1380.002,467.3847283; 1440.048,467.2029928; 1500.094,
        467.0600895; 1560.012,466.9387848; 1620.086,466.8490565; 1680.022,
        466.7709778; 1740.05,466.7001465; 1800.018,466.6623005; 1860.018,
        466.6316728; 1920.003,466.609768; 1980.109,466.5918093; 2040.091,
        466.4715385; 2100.074,464.8158348; 2160.112,462.3312483; 2220.091,
        459.3795165; 2280.1,455.905959; 2340.003,451.7856823; 2400.029,
        446.7328103; 2460.055,440.762122; 2520.003,433.927762; 2580.11,
        425.7062603; 2640.013,417.4299268; 2700.015,409.1510945; 2779.084,
        398.8159353; 2839.039,391.9126175; 2899.037,385.7312538; 2959.097,
        380.7876538; 3019.084,377.7129573; 3079.047,376.3022573; 3139.079,
        376.0766965; 3199.038,376.548592; 3259.045,377.4741345; 3319.101,
        378.6457555; 3379.057,379.904383; 3439.083,381.1847125; 3499.093,
        382.4657633; 3559.04,383.6712493; 3619.071,384.7511605; 3679.039,
        385.663049; 3739.103,386.456481; 3799.091,387.1415503; 3859.056,
        387.7452138; 3919.096,388.2883865; 3979.106,388.7377468; 4039.042,
        389.1328943; 4099.049,389.4864533; 4159.062,389.7985705; 4219.015,
        390.1106708; 4279.115,390.4260478; 4339.078,390.7309393; 4399.103,
        391.0308755; 4459.048,391.309596; 4519.047,391.559908; 4579.006,
        391.7850175; 4639.016,391.971843; 4699.083,392.1161165; 4759.041,
        392.2147383; 4819.015,392.2817298; 4882.929,392.298168; 4950.629,
        392.304754; 5013.009,392.295838; 5073.067,392.2751973; 5133.026,
        392.2619708; 5193.001,392.26233; 5253.137,392.2953723; 5313.916,
        392.3546728; 5373.03,392.4341888; 5433.112,392.536132; 5493.1,
        392.641049; 5553.032,392.7222903; 5613.072,392.7322633; 5673.094,
        392.727614; 5733.002,392.7170108; 5793.018,392.728046; 5853.105,
        392.72968; 5913.039,392.7363183; 5976.019,392.740761; 6000,392.740761], offset=
        0.0)          annotation (Placement(transformation(extent={{-252,-194},{
            -232,-174}})));
  Modelica.Blocks.Sources.TimeTable Tf_58_Exp(table=[0,405.1629123; 60.05,
        405.8534753; 120.089,406.5157173; 180.096,407.174206; 240.018,
        407.8131497; 300.059,408.458716; 360.086,408.5160257; 420.095,
        408.0187717; 480.085,407.248958; 540.102,406.0331387; 600.046,
        403.467106; 660.101,399.225151; 720.101,394.291376; 780.042,389.579316;
        840.045,385.458125; 900.006,382.066211; 960.108,379.1893423; 1020.01,
        376.935397; 1080.085,375.0878373; 1140.043,373.6344227; 1200.078,
        372.4775423; 1260.105,371.534072; 1320.088,370.7610537; 1380.002,
        370.1018143; 1440.048,369.4924947; 1500.094,368.9500167; 1560.012,
        368.4424467; 1620.086,367.95767; 1680.022,367.5041103; 1740.05,
        367.036855; 1800.018,366.601168; 1860.018,366.1619033; 1920.003,
        365.7413837; 1980.109,365.3016373; 2040.091,364.7366673; 2100.074,
        362.462963; 2160.112,359.572915; 2220.091,356.5515677; 2280.1,
        354.3485643; 2340.003,354.5005587; 2400.029,356.133411; 2460.055,
        358.0157857; 2520.003,359.6438357; 2580.11,361.0496243; 2640.013,
        362.111246; 2700.015,362.9055133; 2779.084,363.6436047; 2839.039,
        364.489713; 2899.037,365.9797667; 2959.097,367.452317; 3019.084,
        368.555515; 3079.047,369.38795; 3139.079,370.0710753; 3199.038,
        370.6381797; 3259.045,371.1810077; 3319.101,371.648627; 3379.057,
        372.093489; 3439.083,372.504225; 3499.093,372.8639693; 3559.04,
        373.2051823; 3619.071,373.5652273; 3679.039,373.9730853; 3739.103,
        374.4365787; 3799.091,374.887425; 3859.056,375.3119647; 3919.096,
        375.7202293; 3979.106,376.091177; 4039.042,376.451397; 4099.049,
        376.743695; 4159.062,376.978783; 4219.015,377.1854037; 4279.115,
        377.3651387; 4339.078,377.5119943; 4399.103,377.6586507; 4459.048,
        377.7760043; 4519.047,377.892869; 4579.006,378.0072087; 4639.016,
        378.157866; 4699.083,378.3613997; 4759.041,378.6109087; 4819.015,
        378.8652577; 4882.929,379.1448097; 4950.629,379.426479; 5013.009,
        379.6501157; 5073.067,379.852147; 5133.026,380.0200877; 5193.001,
        380.1769127; 5253.137,380.3200487; 5313.916,380.4304597; 5373.03,
        380.5357203; 5433.112,380.623757; 5493.1,380.696926; 5553.032,
        380.7513047; 5613.072,380.7993323; 5673.094,380.8762877; 5733.002,
        380.9451337; 5793.018,381.029605; 5853.105,381.1218593; 5913.039,
        381.212675; 5976.019,381.3196607; 6000,381.3196607], offset=0.0)
    annotation (Placement(transformation(extent={{-278,-254},{-258,-234}})));
  Modelica.Blocks.Sources.TimeTable Tf_62pt5_Exp(table=[0,390.711769; 60.05,
        392.0452008; 120.089,393.4225748; 180.096,394.8506155; 240.018,
        396.284376; 300.059,397.811273; 360.086,396.8330993; 420.095,
        387.1721898; 480.085,378.3382195; 540.102,372.9215945; 600.046,
        369.4465458; 660.101,366.928831; 720.101,364.9356558; 780.042,
        363.267535; 840.045,361.8266783; 900.006,360.5644968; 960.108,
        359.4019495; 1020.01,358.3767815; 1080.085,357.426569; 1140.043,
        356.5449623; 1200.078,355.743829; 1260.105,354.9946105; 1320.088,
        354.3054665; 1380.002,353.6646235; 1440.048,353.0424085; 1500.094,
        352.47379; 1560.012,351.9317833; 1620.086,351.416407; 1680.022,
        350.9331408; 1740.05,350.4472383; 1800.018,350.0042723; 1860.018,
        349.5642185; 1920.003,349.1514653; 1980.109,348.7374383; 2040.091,
        348.2668253; 2100.074,348.461457; 2160.112,352.281181; 2220.091,
        356.4563143; 2280.1,359.933815; 2340.003,362.671207; 2400.029,
        364.9492278; 2460.055,366.847383; 2520.003,368.4342238; 2580.11,
        369.8262533; 2640.013,371.5598883; 2700.015,374.3030328; 2779.084,
        376.9599953; 2839.039,378.5169893; 2899.037,379.858405; 2959.097,
        380.9793273; 3019.084,381.9721943; 3079.047,382.8228528; 3139.079,
        383.556669; 3199.038,384.193496; 3259.045,384.7778965; 3319.101,
        385.2633458; 3379.057,385.7724233; 3439.083,386.3163853; 3499.093,
        386.8970285; 3559.04,387.4786; 3619.071,388.003035; 3679.039,388.462473;
        3739.103,388.9167038; 3799.091,389.3101625; 3859.056,389.612202;
        3919.096,389.8548423; 3979.106,390.0423725; 4039.042,390.1846668;
        4099.049,390.2942855; 4159.062,390.398524; 4219.015,390.4860458;
        4279.115,390.58192; 4339.078,390.6579208; 4399.103,390.8060633;
        4459.048,391.0384995; 4519.047,391.2892888; 4579.006,391.547503;
        4639.016,391.793569; 4699.083,392.0253828; 4759.041,392.208852;
        4819.015,392.370542; 4882.929,392.5097853; 4950.629,392.6609715;
        5013.009,392.7533313; 5073.067,392.8143488; 5133.026,392.8696875;
        5193.001,392.9183605; 5253.137,392.9409373; 5313.916,392.9624625;
        5373.03,392.986014; 5433.112,393.0099558; 5493.1,393.0038083; 5553.032,
        392.9849703; 5613.072,392.8151248; 5673.094,392.5686393; 5733.002,
        392.3011565; 5793.018,392.0209813; 5853.105,391.6531683; 5913.039,
        391.193189; 5976.019,390.5794823; 6000,390.5794823], offset=-273.15)
    annotation (Placement(transformation(extent={{-282,-296},{-262,-276}})));
  Modelica.Blocks.Sources.RealExpression Tf8(y=thermocline.TES.Tf[8])
    annotation (Placement(transformation(extent={{-302,148},{-282,168}})));
  Modelica.Blocks.Sources.RealExpression Tf13(y=thermocline.TES.Tf[13])
    annotation (Placement(transformation(extent={{-278,96},{-258,116}})));
  Modelica.Blocks.Sources.RealExpression Tf18(y=thermocline.TES.Tf[18])
    annotation (Placement(transformation(extent={{-264,52},{-244,72}})));
  Modelica.Blocks.Sources.RealExpression Tf22pt5(y=0.5*(thermocline.TES.Tf[22]
         + thermocline.TES.Tf[23]))
    annotation (Placement(transformation(extent={{-286,28},{-266,48}})));
  Modelica.Blocks.Sources.RealExpression Tf26(y=thermocline.TES.Tf[26])
    annotation (Placement(transformation(extent={{-262,-22},{-242,-2}})));
  Modelica.Blocks.Sources.RealExpression Tf30pt5(y=0.5*(thermocline.TES.Tf[30]
         + thermocline.TES.Tf[31]))
    annotation (Placement(transformation(extent={{-266,-56},{-246,-36}})));
  Modelica.Blocks.Sources.RealExpression Tf35(y=thermocline.TES.Tf[35])
    annotation (Placement(transformation(extent={{-290,-78},{-270,-58}})));
  Modelica.Blocks.Sources.RealExpression Tf40(y=thermocline.TES.Tf[40])
    annotation (Placement(transformation(extent={{-260,-122},{-240,-102}})));
  Modelica.Blocks.Sources.RealExpression Tf45(y=thermocline.TES.Tf[45])
    annotation (Placement(transformation(extent={{-276,-170},{-256,-150}})));
  Modelica.Blocks.Sources.RealExpression Tf50(y=thermocline.TES.Tf[50])
    annotation (Placement(transformation(extent={{-278,-202},{-258,-182}})));
  Modelica.Blocks.Sources.RealExpression Tf54pt5(y=0.5*(thermocline.TES.Tf[54]
         + thermocline.TES.Tf[55]))
    annotation (Placement(transformation(extent={{-276,-222},{-256,-202}})));
  Modelica.Blocks.Sources.RealExpression Tf58(y=thermocline.TES.Tf[58])
    annotation (Placement(transformation(extent={{-276,-272},{-256,-252}})));
  Modelica.Blocks.Sources.RealExpression Tf62pt5(y=0.5*(thermocline.TES.Tf[62]
         + thermocline.TES.Tf[63]))
    annotation (Placement(transformation(extent={{-282,-322},{-262,-302}})));
  SupportComponents.RMSE_Calculator RMSE8 annotation (Placement(transformation(extent={{-232,
            152},{-212,172}})));
  SupportComponents.RMSE_Calculator RMSE13 annotation (Placement(transformation(extent={{-220,96},
            {-200,116}})));
  SupportComponents.RMSE_Calculator RMSE18 annotation (Placement(transformation(extent={{-210,58},
            {-190,78}})));
  SupportComponents.RMSE_Calculator RMSE22 annotation (Placement(transformation(extent={{-208,12},
            {-188,32}})));
  SupportComponents.RMSE_Calculator RMSE26 annotation (Placement(transformation(extent={{-208,
            -22},{-188,-2}})));
  SupportComponents.RMSE_Calculator RMSE30 annotation (Placement(transformation(extent={{-208,
            -50},{-188,-30}})));
  SupportComponents.RMSE_Calculator RMSE35 annotation (Placement(transformation(extent={{-208,
            -82},{-188,-62}})));
  SupportComponents.RMSE_Calculator RMSE40 annotation (Placement(transformation(extent={{-206,
            -120},{-186,-100}})));
  SupportComponents.RMSE_Calculator RMSE45 annotation (Placement(transformation(extent={{-206,
            -166},{-184,-144}})));
  SupportComponents.RMSE_Calculator RMSE50 annotation (Placement(transformation(extent={{-206,
            -196},{-184,-174}})));
  SupportComponents.RMSE_Calculator RMSE55 annotation (Placement(transformation(extent={{-206,
            -228},{-186,-208}})));
  SupportComponents.RMSE_Calculator RMSE58 annotation (Placement(transformation(extent={{-216,
            -270},{-196,-250}})));
  SupportComponents.RMSE_Calculator RMSE63 annotation (Placement(transformation(extent={{-228,
            -306},{-208,-286}})));
equation
  connect(pipe4.port_b, TC_002.port_a)
    annotation (Line(points={{-103,-38},{-104,-38},{-104,74},{-102,74},{-102,73},
          {-98,73}},                                       color={0,127,255}));
  connect(TC_002.port_b, Chromolox_Heater.port_a)
    annotation (Line(points={{-74,73},{-74,74},{-66,74}}, color={0,127,255}));
  connect(Chromolox_Heater.port_b, TC_003.port_a)
    annotation (Line(points={{-50,74},{-40,74}}, color={0,127,255}));
  connect(TC_003.port_b, tank1.port_a) annotation (Line(points={{-16,74},{-16,
          75.2},{-3.6,75.2}},
                        color={0,127,255}));
  connect(pipe2.port_b,PV_049. port_a)
    annotation (Line(points={{62,76},{84,76},{84,72}}, color={0,127,255}));
  connect(PV_050.port_a, sensor_m_flow2.port_a) annotation (Line(points={{176,68},
          {176,76},{214,76},{214,58}}, color={0,127,255}));
  connect(PV_006.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{138,76},{214,76},{214,58}}, color={0,127,255}));
  connect(PV_052.port_a, FM_202.port_b) annotation (Line(points={{174,-124},{
          174,-105},{171,-105}},        color={0,127,255}));
  connect(PV_004.port_a, FM_003.port_a) annotation (Line(points={{-96,-146},{
          -103,-146},{-103,-107}},        color={0,127,255}));
  connect(PV_050.port_b, sensor_m_flow3.port_b)
    annotation (Line(points={{176,56},{176,47},{168,47}},
                                                 color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Glycol_HX.port_a_tube) annotation (Line(
        points={{50,-238},{50,-239},{77,-239}},           color={0,127,255}));
  connect(Glycol_HX.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{108,-239},{108,-240},{140,-240}},           color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b, boundary1.ports[1])
    annotation (Line(points={{170,-240},{190,-240}}, color={0,127,255}));
  connect(realExpression.y, boundary3.Q_flow_ext)
    annotation (Line(points={{-99,98},{-92,98},{-92,92},{-80,92}},
                                                 color={0,0,127}));
  connect(boundary3.port, Chromolox_Heater.heatPorts[:, 1])
    annotation (Line(points={{-66,92},{-58,92},{-58,78}}, color={191,0,0}));
  connect(realExpression.y, chromoloxHeater_Power.u) annotation (Line(points={{-99,98},
          {-92,98},{-92,120},{-79.2,120}},                         color={0,0,
          127}));
  connect(sensor_m_flow3.port_a, T_discharge_outlet.port_b)
    annotation (Line(points={{146,47},{136,47}}, color={0,127,255}));
  connect(m_thot.port_b, TC_201.port_a)
    annotation (Line(points={{40,46},{38,46},{38,33}},
                                               color={0,127,255}));
  connect(TC_201.port_b, thermocline.port_a)
    annotation (Line(points={{38,9},{38,-2}}, color={0,127,255}));
  connect(FM_202.port_a, T_ch_o.port_a)
    annotation (Line(points={{149,-105},{138,-105}},
                                                   color={0,127,255}));
  connect(TC_202.port_b, thermocline.port_b)
    annotation (Line(points={{38,-57},{38,-46}}, color={0,127,255}));
  connect(pipe2.port_b, BOP_Mass_flow.port_a)
    annotation (Line(points={{62,76},{96,76}}, color={0,127,255}));
  connect(BOP_Mass_flow.port_b,PV_006. port_a)
    annotation (Line(points={{116,76},{126,76}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, T_chiller_before.port_a)
    annotation (Line(points={{214,38},{214,28}}, color={0,127,255}));
  connect(T_chiller_before.port_b, pipe7.port_a)
    annotation (Line(points={{214,2},{214,-10}}, color={0,127,255}));
  connect(pipe7.port_b, T_chiller_after.port_a) annotation (Line(points={{214,-26},
          {214,-52}},                color={0,127,255}));
  connect(tank1.port_b, TC_003a.port_a)
    annotation (Line(points={{7.6,75.2},{7.6,76},{18,76}}, color={0,127,255}));
  connect(TC_003a.port_b, pipe2.port_a)
    annotation (Line(points={{42,76},{46,76}}, color={0,127,255}));
  connect(Heater_BOP_Demand.y, pump.in_p) annotation (Line(points={{-3.3,-128},
          {-12,-128},{-12,-140.16}},
                                 color={0,0,127}));
  connect(Glycol_HX.port_b_shell, nonLinear_Break.port_a) annotation (Line(
        points={{77,-232.1},{56,-232.1},{56,-232}}, color={0,127,255}));
  connect(nonLinear_Break.port_b, PV_012.port_a)
    annotation (Line(points={{56,-220},{56,-188}}, color={0,127,255}));
  connect(TC_006.port_a, nonLinear_Break2.port_a) annotation (Line(points={{16,-145},
          {16,-146},{12,-146}}, color={0,127,255}));
  connect(nonLinear_Break2.port_b, pump.port_a) annotation (Line(points={{0,-146},
          {-4,-146}},                color={0,127,255}));
  connect(PV_009.port_b, TC_006.port_b)
    annotation (Line(points={{86,-144},{40,-145}}, color={0,127,255}));
  connect(FM_001.port_a, pump.port_b)
    annotation (Line(points={{-24,-146},{-20,-146}}, color={0,127,255}));
  connect(PV_004.port_b, ValveFl.port_b)
    annotation (Line(points={{-84,-146},{-60,-146}}, color={0,127,255}));
  connect(ValveFl.port_a, FM_001.port_b)
    annotation (Line(points={{-48,-146},{-42,-146}}, color={0,127,255}));
  connect(nonLinear_Break1.port_a,PV_004. port_b) annotation (Line(points={{-68,
          -106},{-78,-106},{-78,-146},{-84,-146}}, color={0,127,255}));
  connect(FM_001.m_flow, product1.u2) annotation (Line(points={{-33,-143.12},{
          -36,-143.12},{-36,-72},{-48,-72}},
                  color={0,0,127}));
  connect(Heater_BOP_Demand2.y, product1.u1) annotation (Line(points={{-36,
          -28.8},{-36,-60},{-48,-60}},
                       color={0,0,127}));
  connect(Glycol_HX.port_a_shell, TC_004.port_a) annotation (Line(points={{108,
          -232.1},{124,-232.1},{124,-232}},
                                    color={0,127,255}));
  connect(PV_012.port_b, TC_005.port_b)
    annotation (Line(points={{56,-176},{56,-170}}, color={0,127,255}));
  connect(TC_005.port_a, TC_006.port_b) annotation (Line(points={{56,-150},{56,
          -145},{40,-145}},
                      color={0,127,255}));
  connect(Chiller_Mass_flow_T66.port_b, TC_004.port_b) annotation (Line(points={
          {124.5,-209},{126,-209},{126,-212},{124,-212},{124,-214}}, color={0,127,
          255}));
  connect(nonLinear_Break_Derivative.port_b, PV_009.port_a)
    annotation (Line(points={{106,-144},{98,-144}}, color={0,127,255}));
  connect(pipe1.port_a, nonLinear_Break1.port_b) annotation (Line(points={{-26,
          -106},{-56,-106}},                     color={0,127,255}));
  connect(pipe1.port_b, FM_201.port_a)
    annotation (Line(points={{-10,-106},{12,-106}},color={0,127,255}));
  connect(FM_201.port_b, PV_051.port_b)
    annotation (Line(points={{36,-106},{50,-106}}, color={0,127,255}));
  connect(TC_202.port_a, pipe6.port_b)
    annotation (Line(points={{38,-81},{38,-88},{62,-88}},
                                                 color={0,127,255}));
  connect(pipe6.port_a,PV_051. port_a)
    annotation (Line(points={{74,-88},{74,-106},{62,-106}},
                                                  color={0,127,255}));
  connect(pipe3.port_b, nonLinear_Break_Derivative.port_a)
    annotation (Line(points={{200,-144},{118,-144}}, color={0,127,255}));
  connect(pipe8.port_b, Chiller_Mass_flow_T66.port_a) annotation (Line(points={{142,
          -186},{124.5,-186},{124.5,-190}},     color={0,127,255}));
  connect(PV_052.port_b, pipe8.port_a) annotation (Line(points={{174,-136},{174,
          -186},{154,-186}}, color={0,127,255}));
  connect(PV_008.port_b, pipe8.port_a) annotation (Line(points={{190,-182},{190,
          -186},{154,-186}}, color={0,127,255}));
  connect(PV_051.port_a, pipe9.port_a) annotation (Line(points={{62,-106},{92,
          -106}},     color={0,127,255}));
  connect(pipe9.port_b, T_ch_o.port_b) annotation (Line(points={{104,-106},{114,
          -106},{114,-105}},              color={0,127,255}));
  connect(pipe5.port_b, m_thot.port_a)
    annotation (Line(points={{66,47},{66,46},{60,46}}, color={0,127,255}));
  connect(PV_049.port_b, pipe5.port_a) annotation (Line(points={{84,60},{84,47},
          {80,47}},                    color={0,127,255}));
  connect(T_discharge_outlet.port_a, pipe10.port_b) annotation (Line(points={{112,47},
          {112,48},{106,48}},                    color={0,127,255}));
  connect(pipe10.port_a, pipe5.port_a) annotation (Line(points={{94,48},{94,47},
          {80,47}},           color={0,127,255}));
  connect(Ac, Control_System.SensorSubBus) annotation (Line(
      points={{-19,142},{29.3333,142},{29.3333,154.15}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Sen, Control_System.ActuatorSubBus) annotation (Line(
      points={{-61,142},{19.4667,142},{19.4667,154.15}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.PV008, PV_008.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-176},{194.8,-176}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(Ac.PV004, PV_004.opening) annotation (Line(
      points={{-19,142},{-164,142},{-164,-254},{-90,-254},{-90,-150.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Sen.TC006, TC_006.T) annotation (Line(
      points={{-61,142},{-164,142},{-164,-204},{28,-204},{28,-149.68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.PV012, PV_012.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-260},{-18,-260},{-18,-182},{51.2,-182}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(Ac.PV009, PV_009.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-158},{92,-158},{92,-148.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(Sen.Volume_flow_rate, product1.y) annotation (Line(
      points={{-61,142},{-160,142},{-160,-66},{-71,-66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.Valve_fl, ValveFl.opening) annotation (Line(
      points={{-19,142},{-164,142},{-164,-254},{-54,-254},{-54,-150.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.PV006, PV_006.opening) annotation (Line(
      points={{-19,142},{132,142},{132,80.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.PV049, PV_049.opening) annotation (Line(
      points={{-19,142},{74,142},{74,66},{79.2,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.PV049, PV_052.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-130},{178.8,-130}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Ac.PV050, PV_050.opening) annotation (Line(
      points={{-19,142},{208,142},{208,62},{180.8,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Ac.PV051, PV_051.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-120},{56,-120},{56,-110.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Sen.TC003, TC_003.T) annotation (Line(
      points={{-61,142},{-28,142},{-28,78.32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Ac.W_heater, W_heater.u) annotation (Line(
      points={{-19,142},{-128,142},{-128,121},{-115.4,121}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Ac.M_dot_glycol, Chiller_Mass_Flow.m_flow_in) annotation (Line(
      points={{-19,142},{240,142},{240,-260},{-18,-260},{-18,-230},{30,-230}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(FM_003.port_b, pipe4.port_a)
    annotation (Line(points={{-103,-89},{-103,-56}}, color={0,127,255}));
  connect(T_chiller_after.port_b, nonLinear_Break5.port_a)
    annotation (Line(points={{214,-76},{214,-96}}, color={0,127,255}));
  connect(nonLinear_Break5.port_b, pipe3.port_a) annotation (Line(points={{214,
          -108},{214,-144},{212,-144}}, color={0,127,255}));
  connect(PV_008.port_a, pipe3.port_b) annotation (Line(points={{190,-170},{190,
          -144},{200,-144}}, color={0,127,255}));

  connect(Tf_62pt5_Exp.y, RMSE63.u1) annotation (Line(points={{-261,-286},{-261,
          -290},{-230,-290}}, color={0,0,127}));
  connect(Tf62pt5.y, RMSE63.u2) annotation (Line(points={{-261,-312},{-244,-312},
          {-244,-302},{-230,-302}}, color={0,0,127}));
  connect(Tf_58_Exp.y, RMSE58.u1) annotation (Line(points={{-257,-244},{-248,
          -244},{-248,-254},{-218,-254}}, color={0,0,127}));
  connect(Tf58.y, RMSE58.u2) annotation (Line(points={{-255,-262},{-255,-266},{
          -218,-266}}, color={0,0,127}));
  connect(Tf_54pt5_Exp.y, RMSE55.u2) annotation (Line(points={{-231,-230},{-231,
          -224},{-208,-224}}, color={0,0,127}));
  connect(Tf54pt5.y, RMSE55.u1)
    annotation (Line(points={{-255,-212},{-208,-212}}, color={0,0,127}));
  connect(Tf50.y, RMSE50.u2) annotation (Line(points={{-257,-192},{-232.6,-192},
          {-232.6,-191.6},{-208.2,-191.6}}, color={0,0,127}));
  connect(Tf_50_Exp.y, RMSE50.u1) annotation (Line(points={{-231,-184},{-231,
          -178.4},{-208.2,-178.4}}, color={0,0,127}));
  connect(Tf45.y, RMSE45.u2) annotation (Line(points={{-255,-160},{-255,-132},{
          -216,-132},{-216,-161.6},{-208.2,-161.6}}, color={0,0,127}));
  connect(Tf_45_Exp.y, RMSE45.u1) annotation (Line(points={{-225,-148},{-216.6,
          -148},{-216.6,-148.4},{-208.2,-148.4}}, color={0,0,127}));
  connect(Tf40.y, RMSE40.u2) annotation (Line(points={{-239,-112},{-239,-116},{
          -208,-116}}, color={0,0,127}));
  connect(Tf_40_Exp.y, RMSE40.u1) annotation (Line(points={{-223,-96},{-220,-96},
          {-220,-104},{-208,-104}}, color={0,0,127}));
  connect(Tf_35_Exp.y, RMSE35.u2) annotation (Line(points={{-221,-76},{-215.5,
          -76},{-215.5,-78},{-210,-78}}, color={0,0,127}));
  connect(Tf35.y, RMSE35.u1) annotation (Line(points={{-269,-68},{-252,-68},{
          -252,-66},{-210,-66}}, color={0,0,127}));
  connect(Tf30pt5.y, RMSE30.u2)
    annotation (Line(points={{-245,-46},{-210,-46}}, color={0,0,127}));
  connect(Tf_30_Exp.y, RMSE30.u1) annotation (Line(points={{-225,-36},{-225,-34},
          {-210,-34}}, color={0,0,127}));
  connect(Tf_26_Exp.y, RMSE26.u1)
    annotation (Line(points={{-219,-2},{-219,-6},{-210,-6}}, color={0,0,127}));
  connect(Tf26.y, RMSE26.u2) annotation (Line(points={{-241,-12},{-241,-18},{
          -210,-18}}, color={0,0,127}));
  connect(Tf_22pt5_Exp.y, RMSE22.u2)
    annotation (Line(points={{-257,16},{-210,16}}, color={0,0,127}));
  connect(Tf22pt5.y, RMSE22.u1) annotation (Line(points={{-265,38},{-220,38},{
          -220,28},{-210,28}}, color={0,0,127}));
  connect(Tf18.y, RMSE18.u2)
    annotation (Line(points={{-243,62},{-212,62}}, color={0,0,127}));
  connect(Tf_18_Exp.y, RMSE18.u1) annotation (Line(points={{-221,76},{-216.5,76},
          {-216.5,74},{-212,74}}, color={0,0,127}));
  connect(Tf13.y, RMSE13.u2) annotation (Line(points={{-257,106},{-257,128},{
          -222,128},{-222,100}}, color={0,0,127}));
  connect(Tf_13_Exp.y, RMSE13.u1) annotation (Line(points={{-231,110},{-226.5,
          110},{-226.5,112},{-222,112}}, color={0,0,127}));
  connect(Tf8.y, RMSE8.u2) annotation (Line(points={{-281,158},{-276,158},{-276,
          156},{-234,156}}, color={0,0,127}));
  connect(Tf_8_Exp.y, RMSE8.u1) annotation (Line(points={{-255,176},{-248,176},
          {-248,168},{-234,168}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-260},{240,140}}),
                    graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-156,-208},{232,138}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-24,68},{176,-30},{-24,-150},{-24,68}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-260},{240,
            140}})),
    experiment(
      StopTime=1e-05,
      Interval=10,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_Commands(file="../../TEDS/Basic_TEDS_setup.mos" "Basic_TEDS_setup",
        file="../../TEDS/M3_TEDS.mos" "M3_TEDS"),
    conversion(noneFromVersion=""));
end TEDS_DischargeInitial_TableBased;
