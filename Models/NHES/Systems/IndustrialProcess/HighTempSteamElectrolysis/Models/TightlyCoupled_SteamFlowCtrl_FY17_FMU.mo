within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models;
model TightlyCoupled_SteamFlowCtrl_FY17_FMU
  extends BaseClasses.Partial_SubSystem_B(
    allowFlowReversal=system.allowFlowReversal,
    redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    port_a_nominal(
      p=5.8e6,
      T=591,
      m_flow=7.311637*capacityScaler_steamFlow),
    port_b_nominal(p=6.19e6, T=497.15),
    redeclare Data.TightlyCoupled data(IP_Q_totalElec(displayUnit="MW")=
        53303300));

  final parameter Integer numCells_perVessel = 68320
    "Total number of cells per vessel" annotation (Dialog(group="HTSE vessel(s) size"));
  final parameter Integer numVessels = 5 "Number of online vessels per system" annotation (Dialog(group="HTSE vessel(s) size"));
  final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";
  final parameter SI.Power capacity_nom(displayUnit="MW") = 53.3033e6 "Nominal electrical power consumption during electrolysis";
  parameter SI.Power capacity(displayUnit="MW") = capacity_nom "System capacity";
  final parameter Real capacityScaler = capacity/capacity_nom "Scaler that sizes the capacity of the overall system";
  final parameter Real capacityScaler_minThreshhold = 0.85 "Minimum threshhold of a capacity scaler, above which the system is stable";
  final parameter Real capacityScaler_maxThreshhold = 2.4   "Maximum threshhold of a capacity scaler, below which the system is stable";
  final parameter Real capacityScaler_steamFlow = if capacityScaler < capacityScaler_minThreshhold then capacityScaler_minThreshhold elseif capacityScaler > capacityScaler_maxThreshhold then capacityScaler_maxThreshhold else capacityScaler "Scaler that sizes the steam flow rate";

  SI.MassFlowRate mH2_sec "H2 produced during electrolysis per second";
  NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr
    "H2 produced during electrolysis per year";
  SI.MassFlowRate mO2_sec "O2 produced during electrolysis per second";
  NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr
    "O2 produced during electrolysis per year";

  SI.Power Q_nuclearHeatCathodeRecup "Nuclear heat transferred from the hot utility to cathode stream";
  SI.Power Q_nuclearHeatAnodeRecup "Nuclear heat transferred from the hot utility to anode stream";
  SI.Power Q_nuclearHeatRecup "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
  SI.Power Wq_nuclearHeatRecup "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
  SI.Power W_total "Total energy consumption in the HTSE plant";

  Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
  Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";

  inner Modelica.Fluid.System system(allowFlowReversal=false,
    T_ambient=298.15,
    m_flow_start=7.311637)
    annotation (Placement(transformation(extent={{180,120},{200,140}})));

  Electrolysis.Sensors.PowerSensorScalable
                                   W_HTSE(capacityScaler=capacityScaler)
                                          annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={180,20})));
  Modelica.Blocks.Sources.RealExpression mH2(y=capacityScaler*mH2_sec)
    annotation (Placement(transformation(extent={{-170,78},{-190,98}})));
  Modelica.Blocks.Sources.RealExpression mO2(y=capacityScaler*mO2_sec)
    annotation (Placement(transformation(extent={{-170,64},{-190,84}})));
  Modelica.Fluid.Sensors.Pressure pH2O_in(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-172,48},{-188,64}})));
  Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-182,30},{-198,46}})));
  Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium = Medium)
                                            annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-180,0})));
  Modelica.Fluid.Sensors.MassFlowRate mH2O_out(redeclare package Medium =
        Medium)                             annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-170,-124})));
  Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-180,-108},{-196,-92}})));
  Modelica.Fluid.Sensors.Pressure pH2O_out(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-172,-80},{-188,-64}})));
  Electrolysis.Sensors.PowerSensorScalable W_vessel(capacityScaler=
        capacityScaler) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={132,-60})));
  Electrical.Sources.PowerSource W_IP(use_W_in=true, W(displayUnit="MW") = 53303300)
                                                                  annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={180,46})));
  Electrical.Load             load_IP(Wn=0, fn=60) annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=180,
        origin={176,-40})));
  Fluid.Pipes.parallelFlow nFlow_in(redeclare package Medium = Medium,
      nParallel=capacityScaler_steamFlow)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-180,-22})));
  Fluid.Pipes.parallelFlow nFlow_out(redeclare package Medium = Medium,
      nParallel=capacityScaler_steamFlow)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-160,-100})));
  Modelica.Blocks.Math.Gain scaler_IP(k=capacityScaler) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={192,-40})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowSplit(
    V=1,
    use_T_start=true,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    port_2(h_outflow(start=2.95398e6, fixed=true), p(start=5800000, fixed=true)),
    p_start=5800000,
    T_start=591.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-160,-50})));

  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=TCV_anodeGas.m_flow_nominal,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_anodeGas.y_start*((58 - 51.4542)*1e5),
    m_flow_nominal=0.850426,
    dp_start=(58 - 51.4542)*1e5,
    m_flow(start=TCV_anodeGas.m_flow_nominal, fixed=true))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,-180})));
  Electrolysis.HTSE.HTSEvessel_updateLog HTSEvessel(
    numCells_perVessel=numCells_perVessel,
    numVessels=numVessels,
    capacityScaler=capacityScaler)
    annotation (Placement(transformation(extent={{102,-72},{122,-52}})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start*((
        19.23 - 17.307)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_out_start,
    dp_start=((19.23 - 17.307)*1e5))       annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={60,-78})));
  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start*((
        19.6035 - 17.64315)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_out_start,
    dp_start=((19.6035 - 17.64315)*1e5))
                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,-40})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-18})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-102})));
  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_in_start,
    dp_start=((22.72222 - 20.45)*1e5),
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_in_start),
    port_b(h_outflow(start=239570)))      annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-132})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    y_start=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,-156})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start)
                                                       annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,44})));
  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_in_start, fixed=true),
    dp_start=((22.72222 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={60,20})));
  Electrolysis.Electrical.SwitchYard_HTSE      SY_HTSE
    annotation (Placement(transformation(extent={{140,-62},{160,-42}})));
  Electrolysis.Sensors.PowerSensorScalable W_GT(capacityScaler=capacityScaler)
    annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=270,
        origin={158,-100})));
  Electrolysis.HTSE.Intermediate_HTSE.IdealPump returnPump(
    redeclare package Medium = Medium,
    wstart=7.3112,
    PR0=59.02/51.3042,
    pstart_out=5902000,
    Tstart=497.15)
    annotation (Placement(transformation(extent={{-92,-108},{-108,-92}})));
  Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
    TTube_out(start=532.15, fixed=true))
                             annotation (Placement(transformation(
          extent={{-30,-122},{-10,-142}})));
  Electrolysis.Compressor.CompressionSystem_elecPorts
    compressionSystem(
    redeclare package Medium_working =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_utility =
        Modelica.Media.Water.StandardWater,
    comp_1st(Wc(start=3006830)),
    comp_2nd(Wc(start=3426440)),
    comp_3rd(Wc(start=3602150))) annotation (Placement(transformation(
          extent={{-106,-164},{-42,-124}})));
  Modelica.Fluid.Sources.Boundary_pT source_anodeStream(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                 {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    p(displayUnit="bar") = 101325,
    nPorts=1,
    T=288.15) annotation (Placement(transformation(extent={{-132,-142},{-112,-122}})));
  Electrolysis.Sensors.TempSensorWithThermowell      TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{0,-148},{20,-168}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowJoin(
    V=1,
    use_T_start=true,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    p_start=5130420,
    T_start=497.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-50,-100})));
  Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Medium,
    initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
    hTube_out(start=2.97638e6),
    hShell_out(start=962881, fixed=true))
    annotation (Placement(transformation(extent={{-60,16},{-40,36}})));
  Electrolysis.Machines.PumpControlledPressureVessel_elecPort
    feedPump(V=1, redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-100,16},{-80,36}})));
  Modelica.Fluid.Sources.Boundary_pT source_cathodeStream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = system.p_ambient,
    T=system.T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{-132,16},{-112,36}})));
  Electrolysis.Electrical.SwitchYard_auxiliary      SY_aux
    annotation (Placement(transformation(extent={{-92,-62},{-72,-42}})));
  Electrolysis.Fittings.CascadeCtrlIdealVessel_yH2      cascadeCtrl_yH2(
    redeclare package MixtureGas =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Steam = Modelica.Media.Water.StandardWater,
    yH2_setPoint=0.1,
    V=0.125,
    initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
    wH2_start=0.0557585664075,
    pSteam_start=2272222,
    TSteam_start=556.55)
    annotation (Placement(transformation(extent={{-2,32},{22,8}})));
  Electrolysis.Fittings.IdealRecycleVessel_H2      idealRecycle_H2(
      redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-2,-22},{22,2}})));
  Modelica.Fluid.Sources.Boundary_pT H2_sink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,-16})));
  Electrolysis.Separator.Temp_flashDrumVessel      flashDrum(redeclare package
      Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-40})));
  Modelica.Fluid.Sources.Boundary_pT H2O_sink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p=1764315,
    T=618.329,
    nPorts=1)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-56})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_nominal=6.46077,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_cathodeGas.y_start*((58 - 52.2)*1e5),
    m_flow_start=TCV_cathodeGas.m_flow_nominal,
    dp_start=(58 - 52.2)*1e5,
    m_flow(start=TCV_cathodeGas.m_flow_nominal, fixed=true))
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,60})));
  Electrolysis.Sensors.TempSensorWithThermowell      TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Fluid.Sources.Boundary_pT sink_anodeStream(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=system.p_ambient,
    nPorts=1) annotation (Placement(transformation(extent={{-38,-86},{-18,-66}},
                  rotation=0)));
  Electrolysis.Turbine.TurbineShaft_PowerOut_NPT_HTSE      turbine(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    Xstart={0.674729,0.325271},
    phi_start(displayUnit="rad"),
    pstart_out=system.p_ambient,
    phi(
      displayUnit="rad",
      fixed=true,
      start=turbine.phi_start),
    PR0=17.307e5/system.p_ambient,
    w0=PCV_anSOEC.m_flow_nominal,
    Tin0=turbine.Tstart_in,
    pin0=turbine.pstart_in,
    Tstart_in=605.841,
    Tstart_out=308.2712)
    annotation (Placement(transformation(extent={{42,-106},{10,-74}})));
  Electrolysis.Electrical.ElectricGenerator_constSpeed      generator(
      w_fixed=turbine.N0)
    annotation (Placement(transformation(extent={{12,-100},{-8,-80}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-200})));
  Electrolysis.Sensors.PowerSensorScalable W_aux(capacityScaler=capacityScaler)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={132,90})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    T=4,
    y_start=0.9,
    initType=Modelica.Blocks.Types.Init.SteadyState)         annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-60,76})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
    pressureToMassFlow(redeclare package Medium = Medium, p_atm=BOP.port_a_nominal.p)
    annotation (Placement(transformation(extent={{-364,-28},{-246,158}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
    massFlowToPressure(redeclare package Medium = Medium, p_atm=BOP.port_b_nominal.p)
    annotation (Placement(transformation(extent={{-52,-65},{52,65}},
        rotation=180,
        origin={-316,-173})));
equation
  mH2_sec = idealRecycle_H2.H2Produced.m_flow_in;
  mH2_yr =  mH2_sec*60*60*24*365;
  mO2_sec = HTSEvessel.controlledSOEC.SOECstack.deltaM_O2*HTSEvessel.controlledSOEC.numVessels;
  mO2_yr = mO2_sec*60*60*24*365;

  Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
  Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;
  W_total = W_HTSE.W + Wq_nuclearHeatRecup;

  We_HTSE_percent = (W_HTSE.W/W_total)*100;
  Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;

  connect(mH2O_in.port_a, port_a) annotation (Line(points={{-180,8},{-180,20},{-200,
          20}},           color={0,127,255}));
  connect(mH2O_in.port_a, TH2O_in.port) annotation (Line(points={{-180,8},{-180,
          26},{-190,26},{-190,30}},       color={0,0,127}));
  connect(pH2O_in.port, TH2O_in.port) annotation (Line(points={{-180,48},{-180,26},
          {-190,26},{-190,30}},          color={0,0,127}));
  connect(sensorBus.T_out, TH2O_out.T) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,-100},{-193.6,-100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.m_flow_out, mH2O_out.m_flow) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,-124},{-178.8,-124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.p_out, pH2O_out.p) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,-72},{-188.8,-72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_in, mH2O_in.m_flow) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,4.44089e-16},{
          -188.8,4.44089e-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_in, TH2O_in.T) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,38},{-195.6,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_in, pH2O_in.p) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,56},{-188.8,56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.m_flow_O2_prod, mO2.y) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,74},{-191,74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_H2_prod, mH2.y) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-200,100.1},{-200,88},{-191,88}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_HTSE, W_HTSE.W) annotation (Line(
      points={{-29.9,100.1},{-30,100.1},{-30,100},{200,100},{200,20},{187.52,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(W_IP.portElec_a, W_HTSE.port_a) annotation (Line(
      points={{180,40},{180,28}},
      color={255,0,0},
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.W_IP, W_IP.W_in) annotation (Line(
      points={{30,100},{34,100},{34,100},{34,104},{204,104},{204,80},{180,80},{180,
          53.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(nFlow_out.port_a, mH2O_out.port_a) annotation (Line(points={{-170,
          -100},{-170,-100},{-170,-116}},
                                  color={0,127,255}));
  connect(mH2O_in.port_b, nFlow_in.port_a)
    annotation (Line(points={{-180,-8},{-180,-12}},color={0,127,255}));
  connect(load_IP.powerConsumption, scaler_IP.y)
    annotation (Line(points={{180.62,-40},{187.6,-40}},
                                                      color={0,0,127}));
  connect(actuatorBus.subBus_IP.HTSE.W_IP, scaler_IP.u) annotation (Line(
      points={{30,100},{30,100},{34,100},{34,104},{204,104},{204,-40},{196.8,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_b, mH2O_out.port_b) annotation (Line(points={{-200,-140},{-170,-140},
          {-170,-132}}, color={0,127,255}));
  connect(nFlow_in.port_b, flowSplit.port_2) annotation (Line(points={{-180,-32},
          {-180,-32},{-180,-50},{-170,-50}}, color={0,127,255}));
  connect(TCV_anodeGas.port_a, flowSplit.port_1) annotation (Line(points={{-70,-180},
          {-70,-180},{-146,-180},{-146,-50},{-150,-50}}, color={0,127,255}));
  connect(HTSEvessel.c_pCathode, actuator_pCatSOEC.u) annotation (Line(points={{
          103.6,-57.6},{100,-57.6},{100,-18},{92,-18}}, color={0,0,127}));
  connect(HTSEvessel.c_pAnode, actuator_pAnSOEC.u) annotation (Line(points={{103.6,
          -66.4},{100,-66.4},{100,-102},{92,-102}}, color={0,0,127}));
  connect(HTSEvessel.c_wCathode, actuator_wCathode_in.u) annotation (Line(
        points={{115,-51.6},{115,-18},{115,44},{98,44}}, color={0,0,127}));
  connect(HTSEvessel.c_wAnode, actuator_wAnode_in.u) annotation (Line(points={{115,
          -72.4},{115,-120},{115,-156},{98,-156}}, color={0,0,127}));
  connect(HTSEvessel.anodeIn, FCV_anSOEC.port_b) annotation (Line(points={{112,-72},
          {112,-132},{70,-132}}, color={0,127,255}));
  connect(W_vessel.port_a, SY_HTSE.load_SOEC) annotation (Line(
      points={{138,-60},{140,-60},{142,-60}},
      color={255,0,0},
      thickness=0.5));
  connect(HTSEvessel.elecLoad, W_vessel.port_b) annotation (Line(
      points={{120,-60},{126,-60},{126,-60.12}},
      color={255,0,0},
      thickness=0.5));
  connect(sensorBus.W_Vessel, W_vessel.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{200,100.1},{200,-88},{132,-88},{132,
          -65.64}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(SY_HTSE.generation_GT, W_GT.port_b) annotation (Line(
      points={{158,-60},{158,-60},{158,-92},{158.16,-92}},
      color={255,0,0},
      thickness=0.5));
  connect(sensorBus.W_GT, W_GT.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{200,100.1},{200,-100},{165.52,-100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(nFlow_out.port_b, returnPump.outlet)
    annotation (Line(points={{-150,-100},{-108,-100}}, color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out, FCV_anSOEC.port_a)
    annotation (Line(points={{-10,-132},{50,-132}}, color={0,127,255}));
  connect(compressionSystem.anodeOut, hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-43.6,-132},{-30,-132}}, color={0,127,255}));
  connect(source_anodeStream.ports[1], compressionSystem.anodeIn)
    annotation (Line(points={{-112,-132},{-103.6,-132}}, color={0,127,255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-50,-180},{-20,-180},{-20,-142}}, color={0,127,255}));
  connect(flowJoin.port_1, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{-40,-100},{-20,-100},{-20,-122}}, color={0,127,255}));
  connect(returnPump.inlet, flowJoin.port_2) annotation (Line(points={{-92,-100},
          {-92,-100},{-60,-100}}, color={0,127,255}));
  connect(source_cathodeStream.ports[1], feedPump.port_a) annotation (Line(
        points={{-112,26},{-106,26},{-100,26}}, color={0,127,255}));
  connect(feedPump.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-80,26},{-60,26}},          color={0,127,255}));
  connect(compressionSystem.loadElec_comp, SY_aux.load_MSCS) annotation (Line(
      points={{-74,-124},{-74,-60}},
      color={255,0,0},
      thickness=0.5));
  connect(feedPump.loadElecPump, SY_aux.load_GT) annotation (Line(
      points={{-90,16},{-90,-44}},
      color={255,0,0},
      thickness=0.5));
  connect(cascadeCtrl_yH2.mixtureGas_port_3, FCV_catSOEC.port_a)
    annotation (Line(points={{19.6,20},{34,20},{50,20}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out, cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-40,26},{-20,26},{0.4,26}},
                                                 color={0,127,255}));
  connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
    annotation (Line(points={{0.4,-4},{-6,-4},{-6,14},{0.4,14}}, color={0,127,255}));
  connect(idealRecycle_H2.c_yH2, cascadeCtrl_yH2.c_yH2) annotation (Line(points=
         {{14.8,-7.36},{14.8,5.32},{14.8,16.64}}, color={0,0,127}));
  connect(H2_sink.ports[1], idealRecycle_H2.H2_prod)
    annotation (Line(points={{-10,-16},{0.4,-16}}, color={0,127,255}));
  connect(idealRecycle_H2.H2_feed, flashDrum.vaporOutlet) annotation (Line(
        points={{19.6,-10},{30,-10},{30,-31}}, color={0,127,255}));
  connect(flashDrum.feedInlet, PCV_catSOEC.port_b)
    annotation (Line(points={{38,-40},{44,-40},{50,-40}}, color={0,127,255}));
  connect(PCV_catSOEC.opening, actuator_pCatSOEC.y)
    annotation (Line(points={{60,-32},{60,-18},{69,-18}}, color={0,0,127}));
  connect(HTSEvessel.cathodeIn, FCV_catSOEC.port_b) annotation (Line(points={{112,
          -52},{112,-52},{112,20},{70,20}}, color={0,127,255}));
  connect(FCV_catSOEC.opening, actuator_wCathode_in.y)
    annotation (Line(points={{60,28},{60,44},{75,44}}, color={0,0,127}));
  connect(actuator_wAnode_in.y, FCV_anSOEC.opening)
    annotation (Line(points={{75,-156},{60,-156},{60,-140}}, color={0,0,127}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening)
    annotation (Line(points={{69,-102},{60,-102},{60,-86}}, color={0,0,127}));
  connect(HTSEvessel.cathodeOut, PCV_catSOEC.port_a) annotation (Line(points={{104,
          -60},{90,-60},{90,-40},{70,-40}}, color={0,127,255}));
  connect(HTSEvessel.anodeOut, PCV_anSOEC.port_a) annotation (Line(points={{104,
          -64},{90,-64},{90,-78},{70,-78}}, color={0,127,255}));
  connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(points={{-160,
          -40},{-160,-40},{-160,22},{-160,60},{-100,60}}, color={0,127,255}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-80,60},{-64,60},{-50,60},{-50,36}}, color={0,127,
          255}));
  connect(flowJoin.port_3, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{-50,-90},{-50,16}},           color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out, TNOut_cathodeGasSensor.port)
    annotation (Line(points={{-40,26},{-20,26},{-20,40}}, color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out, TNOut_anodeGasSensor.port)
    annotation (Line(points={{-10,-132},{10,-132},{10,-148}}, color={0,127,255}));
  connect(H2O_sink.ports[1], flashDrum.liquidOutlet)
    annotation (Line(points={{10,-56},{30,-56},{30,-49}}, color={0,127,255}));
  connect(sink_anodeStream.ports[1], turbine.outlet) annotation (Line(points={{-18,
          -76},{16.4,-76},{16.4,-77.2}}, color={0,127,255}));
  connect(turbine.inlet, PCV_anSOEC.port_b) annotation (Line(points={{35.6,-77.2},
          {50,-77.2},{50,-78}}, color={0,127,255}));
  connect(generator.W_GT, turbine.W_GT) annotation (Line(points={{2,-83.8},{2,-82.32},
          {20.24,-82.32}}, color={0,0,127}));
  connect(generator.shaft, turbine.shaft_b)
    annotation (Line(points={{10,-90},{16.4,-90}}, color={0,0,0}));
  connect(generator.powerGeneration, W_GT.port_a) annotation (Line(
      points={{-6,-90},{-10,-90},{-10,-114},{158,-114},{158,-108}},
      color={255,0,0},
      thickness=0.5));
  connect(TCV_anodeGas.opening, actuator_TNOut_anodeGas.y) annotation (Line(
        points={{-60,-188},{-60,-200},{-41,-200}}, color={0,0,127}));
  connect(SY_HTSE.totalElecPower, W_HTSE.port_b) annotation (Line(
      points={{158,-44},{158,-20},{180.16,-20},{180.16,12}},
      color={255,0,0},
      thickness=0.5));
  connect(SY_HTSE.load_auxiliary, W_aux.port_a) annotation (Line(
      points={{142,-44},{142,24},{142,90},{140,90}},
      color={255,0,0},
      thickness=0.5));
  connect(W_aux.port_b, SY_aux.load_auxiliary) annotation (Line(
      points={{124,90.16},{-140,90.16},{-140,90},{-140,-60},{-90,-60}},
      color={255,0,0},
      thickness=0.5));
  connect(sensorBus.W_Aux, W_aux.W) annotation (Line(
      points={{-29.9,100.1},{48,100.1},{132,100.1},{132,97.52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_SOEC, HTSEvessel.s_W_SOEC) annotation (
      Line(
      points={{-29.9,100.1},{86,100.1},{200,100.1},{200,-88},{126,-88},{126,-64},
          {120.4,-64}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV_cathodeGas.opening, actuator_TNOut_cathodeGas.y) annotation (Line(
        points={{-90,68},{-90,68},{-90,76},{-71,76}}, color={0,0,127}));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas,
    actuator_TNOut_cathodeGas.u) annotation (Line(
      points={{30,100},{30,100},{30,78},{30,76},{-48,76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, actuator_TNOut_anodeGas.u)
    annotation (Line(
      points={{30,100},{30,104},{204,104},{204,-200},{-18,-200}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.TNOut_anodeGas, TNOut_anodeGasSensor.y)
    annotation (Line(
      points={{-29.9,100.1},{86,100.1},{200,100.1},{200,-196},{10,-196},{10,
          -167}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.TNOut_cathodeGas, TNOut_cathodeGasSensor.y)
    annotation (Line(
      points={{-29.9,100.1},{-20,100.1},{-20,59}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TH2O_out.port, nFlow_out.port_b) annotation (Line(points={{-188,-108},
          {-180,-108},{-180,-100},{-150,-100}}, color={0,127,255}));
  connect(pH2O_out.port, nFlow_out.port_a) annotation (Line(points={{-180,-80},
          {-180,-100},{-170,-100}}, color={0,0,127}));
  connect(load_IP.portElec_a, portElec_a) annotation (Line(points={{176,-51.2},
          {176,-60},{200,-60}}, color={255,0,0}));
  annotation (defaultComponentName="IP",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,140}})),
                                Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={
                  Text(
          extent={{-94,76},{94,68}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="High-Temperature
Steam Electrolysis")}),
    experiment(
      StopTime=4000,
      __Dymola_NumberOfIntervals=4000,
      __Dymola_Algorithm="Esdirk45a"));
end TightlyCoupled_SteamFlowCtrl_FY17_FMU;
