within NHES.Systems.ExperimentalSystems.TEDS.Examples.OldExamples.Glycol_HX_Models;
model GHX_UnitSimulation_testModelwBypassLine_v2

  extends
    NHES.Systems.ExperimentalSystems.TEDS.BaseClasses_1.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_GlycolHX_v3 CS,
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
    annotation (Placement(transformation(extent={{102,26},{90,14}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Eth_Gly_OutletT(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{20,14},{34,26}})));
  Modelica.Fluid.Sources.MassFlowSource_T Oil_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=1*1.73696520202777777777,
    T=598.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{102,4},{86,-12}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-74,2},{-62,-10}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_005(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{-38,-12},{-54,4}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Eth_Gly_InletT(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{-38,12},{-24,28}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_004(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{32,-10},{48,2}})));
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
  TRANSFORM.Fluid.Valves.ValveLinear PV009(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    dp_nominal=1000,
    m_flow_nominal=2)
    annotation (Placement(transformation(extent={{18,-36},{-2,-56}})));
  Modelica.Blocks.Sources.RealExpression RejectedHeat(y=Q_HX_Gly) annotation (
      Placement(transformation(
        extent={{15,10},{-15,-10}},
        rotation=180,
        origin={-131,100})));
  Modelica.Blocks.Sources.Constant massflow(k=2)
    "Assume pump speed does not change."
    annotation (Placement(transformation(extent={{150,-30},{130,-10}})));
  Modelica.Blocks.Sources.CombiTimeTable Temp_TC004(table=[0,543.25132; 60,
        545.60273; 120,547.942189; 180,549.830341; 240,552.374698; 300,
        554.900775; 360,554.868456; 420,554.127314; 480,555.322564; 540,
        557.485786; 600,557.733797; 660,556.389812; 720,556.899441; 780,
        558.725826; 840,559.787144; 900,555.41411; 960,549.74867; 1020,
        549.987816; 1080,551.194114; 1140,552.089476; 1200,552.447346; 1260,
        552.420669; 1320,552.184009; 1380,551.523858; 1440,548.271088; 1500,
        537.596678; 1560,473.773151; 1620,434.815764; 1680,445.337307; 1740,
        484.239748; 1800,510.924001; 1860,527.920587; 1920,538.241547; 1980,
        544.711898; 2040,548.921764; 2100,551.577568; 2160,553.423628; 2220,
        555.250217; 2280,556.590491; 2340,557.432086; 2400,557.820506; 2460,
        557.968269; 2520,557.871592; 2580,557.729025; 2640,557.500334; 2700,
        557.012026; 2760,556.063499; 2820,554.951027; 2880,553.118381; 2940,
        551.475976; 3000,549.025351; 3060,546.628197; 3120,542.712906; 3180,
        535.112735; 3240,526.564702; 3300,499.456752; 3360,485.094524; 3420,
        501.865887; 3480,518.938908; 3540,531.596656; 3600,539.83496; 3660,
        545.206673; 3720,548.585301; 3780,550.731138; 3840,552.196434; 3900,
        553.036941; 3960,553.482041; 4020,553.695317; 4080,553.677885; 4140,
        553.526226; 4200,553.262423; 4260,552.914839; 4320,552.535452; 4380,
        552.072106; 4440,551.620084; 4500,551.090592; 4560,550.517284; 4620,
        549.841214; 4680,549.089002; 4740,548.272442; 4800,547.267767; 4860,
        546.107573; 4920,544.800938; 4980,543.126251; 5040,541.267193; 5100,
        538.969319; 5160,536.168354; 5220,532.850197; 5280,529.031639; 5340,
        524.749357; 5400,519.931589; 5460,514.544332; 5520,508.403823; 5580,
        501.565621; 5640,494.404071; 5700,487.106457; 5760,479.704471; 5820,
        472.382878; 5880,465.189144; 5940,458.314069; 6000,451.943421; 6060,
        446.197011; 6120,440.863091; 6180,436.226762; 6240,428.066383; 6300,
        417.32231; 6360,409.359697; 6420,404.236162; 6480,394.5497651; 6540,
        390.2038683; 6600,386.1942174; 6660,382.5037498; 6720,379.1164739; 6780,
        376.0174092; 6840,373.1925295; 6900,370.6287105; 6960,368.313679; 7020,
        366.334384; 7080,366.334384; 7140,366.334384; 7200,367.038847; 7260,
        367.076676; 7320,367.114079; 7380,367.095072; 7440,367.13501; 7500,
        367.108826; 7560,367.197491; 7620,367.215915; 7680,367.246105; 7740,
        367.298455; 7800,367.349227; 7860,367.453746; 7920,367.472167; 7980,
        367.532039; 8040,367.527752; 8100,367.668517; 8160,367.776651; 8220,
        367.894318; 8280,368.002728; 8340,368.094873; 8400,368.166366; 8460,
        368.317768; 8520,368.425108; 8580,368.61489; 8640,368.777082; 8700,
        369.029205; 8760,369.230742; 8820,369.516648; 8880,369.758309; 8940,
        370.043793; 9000,370.344149; 9060,370.700149; 9120,371.115421; 9180,
        371.500562; 9240,371.931087; 9300,372.446772; 9360,373.048957; 9420,
        373.728951; 9480,374.440712; 9540,375.206854; 9600,376.123307; 9660,
        377.017157; 9720,378.095554; 9780,379.200603; 9840,380.519936; 9900,
        381.8944; 9960,383.374792; 10020,385.034266; 10080,386.797353; 10140,
        388.835179; 10200,391.123969; 10260,393.671906; 10320,396.339079; 10380,
        399.479658; 10440,402.887727; 10500,406.747529; 10560,410.833928; 10620,
        415.289846; 10680,420.190172; 10740,425.497471; 10800,430.960847; 10860,
        436.835839; 10920,443.034823; 10980,422.884026; 11040,428.226411; 11100,
        448.800352; 11160,471.20591; 11220,492.795506; 11280,510.954483; 11340,
        524.416377; 11400,534.574246; 11460,542.774223; 11520,549.063637; 11580,
        553.425581; 11640,554.284638; 11700,553.776254; 11760,551.151897; 11820,
        547.117444; 11880,544.565439; 11940,545.394994; 12000,547.806832; 12060,
        546.627726; 12120,543.651612; 12180,543.076153; 12240,545.24494; 12300,
        547.700441; 12360,549.430521; 12420,551.970834; 12480,554.643331; 12540,
        555.00766; 12600,554.169082; 12660,554.941034; 12720,557.241465; 12780,
        557.869145; 12840,556.523402; 12900,556.613523; 12960,558.473632; 13020,
        559.821243; 13080,557.47747; 13140,549.725164; 13200,549.897435; 13260,
        551.062856; 13320,552.011641; 13380,552.405643; 13440,552.432437; 13500,
        552.247613; 13560,551.546618; 13620,548.428461; 13680,543.584181; 13740,
        483.971096; 13800,436.822646; 13860,439.336021; 13920,479.067475; 13980,
        507.720128; 14040,525.84604; 14100,536.963532; 14160,543.892933; 14220,
        548.433059; 14280,551.243861; 14340,553.146878; 14400,555.006822; 14460,
        556.414039; 14520,557.271023; 14580,557.741768; 14640,557.903715; 14700,
        557.8884; 14760,557.776724; 14820,557.552794; 14880,557.14134; 14940,
        556.197844; 15000,555.176925; 15060,553.348463; 15120,551.81237; 15180,
        549.368833; 15240,547.003632; 15300,543.519796; 15360,536.394502; 15420,
        528.054317; 15480,505.961823; 15540,479.197953; 15600,499.09259; 15660,
        516.558208; 15720,530.005862; 15780,538.848105; 15840,544.577506; 15900,
        548.186565; 15960,550.578352; 16020,552.048135; 16080,552.947743; 16140,
        553.452533; 16200,553.676171; 16260,553.685246; 16320,553.565151; 16380,
        553.23822; 16440,552.97129; 16500,552.584823; 16560,552.107808; 16620,
        551.668094; 16680,551.090003; 16740,550.675303; 16800,549.950363; 16860,
        549.218147; 16920,548.399556; 16980,547.4269; 17040,546.338478; 17100,
        545.05171; 17160,543.400759; 17220,541.549723; 17280,539.332578; 17340,
        536.598801; 17400,533.360507; 17460,529.63201; 17520,525.447174; 17580,
        520.693363; 17640,515.38323; 17700,509.441296; 17760,502.642309; 17820,
        495.573004; 17880,488.216691; 17940,480.819212; 18000,473.439392; 18060,
        466.262225; 18120,459.239109; 18180,452.861088; 18240,446.958615; 18300,
        441.648412; 18360,436.917138; 18420,429.74064; 18480,418.784192; 18540,
        410.419809; 18600,404.645837; 18660,395.2317603; 18720,390.8338856;
        18780,386.7749125; 18840,383.0376124; 18900,379.6058368; 18960,
        376.4644572], startTime=0)
    "Pseudo TC 004 temperature mimicing discharging - Charcing - Discharging profile"
    annotation (Placement(transformation(extent={{150,0},{130,20}})));
equation
    HeatTransferArea_HX = (Glycol_HX.geometry.D_o_tube)*Glycol_HX.geometry.length_tube*Modelica.Constants.pi*Glycol_HX.geometry.nTubes;
    Q_HX_Oil    =  (Glycol_HX.tube.port_a.h_outflow-Glycol_HX.tube.port_b.h_outflow)*Oil_Mass_Flow.m_flow_in;
    Q_HX_Gly    =  (Glycol_HX.shell.port_b.h_outflow-Glycol_HX.shell.port_a.h_outflow)*Chiller_Mass_Flow.m_flow_in;
    dP_Shell_HX =   Oil_Mass_Flow.ports[1].p - TC_005.port_a.p;
    dP_Tube_HX  =   Glycol_HX.port_a_tube.p - Glycol_HX.port_b_tube.p;

  connect(Eth_Gly_OutletT.port_b, boundary1.ports[1])
    annotation (Line(points={{34,20},{90,20}}, color={0,127,255}));
  connect(TC_005.port_b,boundary2. ports[1])
    annotation (Line(points={{-54,-4},{-62,-4}},    color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Eth_Gly_InletT.port_a)
    annotation (Line(points={{-60,20},{-38,20}}, color={0,127,255}));
  connect(sensorBus.Eth_Gly_OutletT, Eth_Gly_OutletT.T) annotation (Line(
      points={{-30,100},{-100,100},{-100,36},{27,36},{27,22.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Blower_Massflow, Chiller_Mass_Flow.m_flow_in) annotation (
     Line(
      points={{30,100},{160,100},{160,30},{-90,30},{-90,26},{-84,26},{-84,26.4},
          {-76,26.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TC_005.port_a, Glycol_HX.port_b_tube)
    annotation (Line(points={{-38,-4},{-3,-4}}, color={0,127,255}));
  connect(Glycol_HX.port_a_tube, TC_004.port_a)
    annotation (Line(points={{20,-4},{32,-4}}, color={0,127,255}));
  connect(Eth_Gly_OutletT.port_a, Glycol_HX.port_b_shell)
    annotation (Line(points={{20,20},{20,0.6}},         color={0,127,255}));
  connect(Eth_Gly_InletT.port_b, Glycol_HX.port_a_shell) annotation (Line(
        points={{-24,20},{-8,20},{-8,0.6},{-3,0.6}}, color={0,127,255}));
  connect(PV009.port_a, TC_004.port_a)
    annotation (Line(points={{18,-46},{32,-46},{32,-4}}, color={0,127,255}));
  connect(PV009.port_b, TC_005.port_a) annotation (Line(points={{-2,-46},{-12,
          -46},{-12,-4},{-38,-4}},
                              color={0,127,255}));
  connect(Oil_Mass_Flow.ports[1], TC_004.port_b)
    annotation (Line(points={{86,-4},{48,-4}}, color={0,127,255}));
  connect(sensorBus.RejectedHeat, RejectedHeat.y) annotation (Line(
      points={{-30,100},{-114.5,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PV009_Opening, PV009.opening) annotation (Line(
      points={{30,100},{160,100},{160,-66},{8,-66},{8,-54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(massflow.y, Oil_Mass_Flow.m_flow_in) annotation (Line(points={{129,
          -20},{110,-20},{110,-12},{102,-12},{102,-10.4}}, color={0,0,127}));
  connect(Temp_TC004.y[1], Oil_Mass_Flow.T_in) annotation (Line(points={{129,10},
          {110,10},{110,-7.2},{103.6,-7.2}}, color={0,0,127}));
  annotation (
    defaultComponentName="changeMe",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=20000,
      __Dymola_NumberOfIntervals=2000,
      __Dymola_Algorithm="Dassl"));
end GHX_UnitSimulation_testModelwBypassLine_v2;
