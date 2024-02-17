within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model Control_System_TEDS_ExpTest_Oct2024
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  parameter Real FV_opening=0.00250;

  BaseClasses_1.SignalSubBus_ActuatorInput ActuatorSubBus
    annotation (Placement(transformation(extent={{-58,-122},{-10,-76}})));
  BaseClasses_1.SignalSubBus_SensorOutput SensorSubBus
    annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
  Modelica.Blocks.Sources.RealExpression PV004(y=1)
    annotation (Placement(transformation(extent={{174,56},{120,90}})));

parameter SI.Temperature T_hot_design = 300;

  Modelica.Blocks.Sources.RealExpression PV008(y=1)
    annotation (Placement(transformation(extent={{174,22},{122,60}})));
  TRANSFORM.Controls.LimPID PV012(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0004,
    Ti=5,
    yMax=0.999,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-98,-66},{-80,-48}})));
  Modelica.Blocks.Sources.CombiTimeTable T_GHXout(table=[0,21; 104,21; 105,20;
        9497,20; 9498,21; 9514,21; 9515,22; 9833,40; 9834,41; 10307,48; 10308,
        49; 10514,49; 10515,50; 12254,50; 12255,51; 14125,51; 14126,52; 15046,
        52; 15047,51; 16593,51; 16594,52; 21712,52; 21713,53; 22227,53; 22228,
        54; 22688,54; 22689,55; 22943,55; 22944,56; 23120,56; 23121,57; 23266,
        57; 23267,58; 23360,58; 23361,59; 23423,59; 23424,60; 23480,60; 23481,
        61; 23528,61; 23529,62; 23576,62; 23577,63; 23610,63; 23611,64; 24145,
        84; 24146,85; 24155,85; 24156,84; 24245,80; 24246,81; 24795,115; 24796,
        116; 25000,116],
      startTime=0)
    annotation (Placement(transformation(extent={{-210,-52},{-188,-30}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-134,-66},{-116,-48}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15)      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-198,-74})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand1(y=1 - PV012.y)
    annotation (Placement(transformation(extent={{174,-10},{124,28}})));
  Modelica.Blocks.Sources.RealExpression GPMconversion(y=15850.323140625002)
    annotation (Placement(transformation(extent={{-208,12},{-180,36}})));
  Modelica.Blocks.Math.Product FM_001_gpm
    annotation (Placement(transformation(extent={{-134,-6},{-116,12}})));
  Modelica.Blocks.Sources.CombiTimeTable Flow(table=[0,0.0135; 1059,0.0135;
        1074,41; 1127,41; 1128,36; 1386,36; 3325,40; 3328,45; 3840,45; 3940,50;
        6065,50; 6066,45; 8028,45; 8171,8; 9024,8; 9036,6; 10333,5; 24489,6;
        25000,6],
      startTime=0)
    annotation (Placement(transformation(extent={{-200,48},{-182,66}})));
  TRANSFORM.Controls.LimPID VolFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.04,
    Ti=50,
    yMax=0.99,
    yMin=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-96,24},{-78,42}})));
  Modelica.Blocks.Sources.RealExpression Conversion_lpm(y=1/15850.323140625002*1000
        *60)
    annotation (Placement(transformation(extent={{-208,68},{-180,94}})));
  Modelica.Blocks.Math.Product FM_1
    annotation (Placement(transformation(extent={{-94,60},{-76,78}})));
  Modelica.Blocks.Sources.CombiTimeTable PV006(table=[0,0.0001; 24098,0.0001;
        24099,1; 25000,1],             startTime=0)
    annotation (Placement(transformation(extent={{192,86},{164,114}})));
  Modelica.Blocks.Sources.CombiTimeTable PV049_PV052(table=[0,0.001; 973,0.001;
        974,1; 24106,1; 24107,0; 25000,0],                            startTime=
       0) annotation (Placement(transformation(extent={{196,-32},{172,-8}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{138,-86},{120,-68}})));
  Modelica.Blocks.Sources.CombiTimeTable PV050_PV051(table=[0,0.0001; 25000,
        0.0001],
      startTime=0)
    annotation (Placement(transformation(extent={{198,-78},{172,-52}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=0.03,
    k_s=1,
    k_m=1,
    yMax=225e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-44,112},{-26,130}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15)      annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-190,110})));
  Modelica.Blocks.Sources.CombiTimeTable THeater(table=[0,75; 2900,75; 2901,100;
        11039,100; 11040,300; 12587,300; 12588,285; 12687,285; 12688,275; 12750,
        275; 12751,280; 12979,280; 12980,275; 13215,275; 13216,276; 25000,276],
                                        startTime=0)
    annotation (Placement(transformation(extent={{-198,124},{-182,140}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-94,112},{-76,130}})));
  Modelica.Blocks.Sources.Constant const2(k=12.6)
    annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=0,
        origin={136,136})));
  Modelica.Blocks.Math.Gain Gain(k=1)
    annotation (Placement(transformation(extent={{136,92},{120,108}})));
  Modelica.Blocks.Math.Gain Gain1(k=1)
    annotation (Placement(transformation(extent={{138,-60},{120,-42}})));
  Modelica.Blocks.Math.Gain Gain2(k=1)
    annotation (Placement(transformation(extent={{138,-28},{122,-12}})));
equation

  connect(SensorSubBus.PV008, PV008.y) annotation (Line(
      points={{40,-99},{40,41},{119.4,41}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.PV004, PV004.y) annotation (Line(
      points={{40,-99},{40,73},{117.3,73}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_GHXout.y[1], add.u1) annotation (Line(points={{-186.9,-41},{-156,
          -41},{-156,-51.6},{-135.8,-51.6}},
                        color={0,0,127}));
  connect(const3.y,add. u2) annotation (Line(points={{-187,-74},{-158,-74},{
          -158,-62.4},{-135.8,-62.4}},
                                 color={0,0,127}));
  connect(ActuatorSubBus.TC006, PV012.u_m) annotation (Line(
      points={{-34,-99},{-34,-74},{-89,-74},{-89,-67.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SensorSubBus.PV012, PV012.y) annotation (Line(
      points={{40,-99},{40,-57},{-79.1,-57}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.PV009, Heater_BOP_Demand1.y) annotation (Line(
      points={{40,-99},{40,9},{121.5,9}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(GPMconversion.y,FM_001_gpm. u1) annotation (Line(points={{-178.6,24},
          {-148,24},{-148,8.4},{-135.8,8.4}},
                                    color={0,0,127}));
  connect(Flow.y[1], VolFlow_Control.u_s) annotation (Line(points={{-181.1,57},
          {-104,57},{-104,33},{-97.8,33}},     color={0,0,127}));
  connect(FM_001_gpm.y, VolFlow_Control.u_m) annotation (Line(points={{-115.1,3},
          {-87,3},{-87,22.2}},                   color={0,0,127}));
  connect(Conversion_lpm.y,FM_1. u1) annotation (Line(points={{-178.6,81},{-100,
          81},{-100,74.4},{-95.8,74.4}},
                           color={0,0,127}));
  connect(Flow.y[1],FM_1. u2) annotation (Line(points={{-181.1,57},{-100,57},{
          -100,63.6},{-95.8,63.6}},
                           color={0,0,127}));
  connect(ActuatorSubBus.Volume_flow_rate, FM_001_gpm.u2) annotation (Line(
      points={{-34,-99},{-34,-36},{-146,-36},{-146,-2.4},{-135.8,-2.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SensorSubBus.Valve_fl, VolFlow_Control.y) annotation (Line(
      points={{40,-99},{40,33},{-77.1,33}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV050_PV051.y[1], firstOrder5.u) annotation (Line(points={{170.7,-65},
          {170.7,-66},{144,-66},{144,-77},{139.8,-77}},     color={0,0,127}));
  connect(SensorSubBus.PV051, firstOrder5.y) annotation (Line(
      points={{40,-99},{40,-77},{119.1,-77}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const4.y,add1. u2) annotation (Line(points={{-181.2,110},{-102,110},{
          -102,115.6},{-95.8,115.6}},
                               color={0,0,127}));
  connect(THeater.y[1],add1. u1) annotation (Line(points={{-181.2,132},{-102,
          132},{-102,126.4},{-95.8,126.4}},   color={0,0,127}));
  connect(add1.y,Chromolox_Heater_Control. u_s) annotation (Line(points={{-75.1,
          121},{-45.8,121}},                    color={0,0,127}));
  connect(ActuatorSubBus.TC003, Chromolox_Heater_Control.u_m) annotation (Line(
      points={{-34,-99},{-34,110.2},{-35,110.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SensorSubBus.W_heater, Chromolox_Heater_Control.y) annotation (Line(
      points={{40,-99},{40,121},{-25.1,121}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.M_dot_glycol, const2.y) annotation (Line(
      points={{40,-99},{40,136},{122.8,136}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV006.y[1], Gain.u) annotation (Line(points={{162.6,100},{137.6,100}},
                                      color={0,0,127}));
  connect(SensorSubBus.PV006[1], Gain.y) annotation (Line(
      points={{40,-99},{40,100},{119.2,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV049_PV052.y[1], Gain2.u) annotation (Line(points={{170.8,-20},{
          139.6,-20}},                        color={0,0,127}));
  connect(SensorSubBus.PV049, Gain2.y) annotation (Line(
      points={{40,-99},{40,-20},{121.2,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.PV050[1], Gain1.y) annotation (Line(
      points={{40,-99},{40,-51},{119.1,-51}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV050_PV051.y[1], Gain1.u)
    annotation (Line(points={{170.7,-65},{170.7,-66},{144,-66},{144,-51},{139.8,
          -51}},                                         color={0,0,127}));
  connect(PV012.u_s, add.y)
    annotation (Line(points={{-99.8,-57},{-115.1,-57}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})));
end Control_System_TEDS_ExpTest_Oct2024;
