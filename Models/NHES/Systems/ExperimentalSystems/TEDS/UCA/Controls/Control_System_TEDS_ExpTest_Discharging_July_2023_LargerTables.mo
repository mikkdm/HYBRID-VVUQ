within NHES.Systems.ExperimentalSystems.TEDS.UCA.Controls;
model Control_System_TEDS_ExpTest_Discharging_July_2023_LargerTables
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)."

  parameter Real FV_opening=0.00250;
  parameter Boolean auto_control_heater = true "false means a table needs to be provided for heater values";
  parameter Boolean auto_control_flowvalve = true "false means a table needs to be provided for primary flow valve";
  parameter Boolean auto_control_pv012 = true "false means a table needs to be provided for PV_012";

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
  Modelica.Blocks.Sources.CombiTimeTable T_GHXout(
    tableOnFile=false,
    table=[0,25; 25,25; 50,25; 75,25; 100,25; 125,25; 150,25; 175,25; 200,25;
        225,25; 250,25; 275,25; 300,25; 325,25; 345,25; 370,32; 395,39; 420,46;
        445,53; 470,60; 495,67; 520,74; 545,81; 570,88; 595,95; 620,102; 645,
        109; 670,116; 700,125; 793,125; 886,125; 979,125; 1072,125; 1165,125;
        1258,125; 1351,125; 1444,125; 1537,125; 1630,125; 1723,125; 1816,125;
        1909,125; 2000,125; 2071,127; 2142,129; 2213,131; 2284,133; 2355,135;
        2426,137; 2497,139; 2568,141; 2639,143; 2710,145; 2781,147; 2852,149;
        2923,151; 3000,150; 3071,148; 3142,146; 3213,144; 3284,142; 3355,140;
        3426,138; 3497,136; 3568,134; 3639,132; 3710,130; 3781,128; 3852,126;
        3923,124; 4000,125; 4071,125; 4142,125; 4213,125; 4284,125; 4355,125;
        4426,125; 4497,125; 4568,125; 4639,125; 4710,125; 4781,125; 4852,125;
        4923,125; 4994,125; 5065,125; 5136,125; 5207,125; 5278,125; 5349,125;
        5420,125; 5491,125; 5562,125; 5633,125; 5704,125; 5775,125; 5846,125;
        5917,125; 5988,125; 6059,125],
    tableName="T_GHX",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/T_GHX.txt"),
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
  Modelica.Blocks.Sources.CombiTimeTable Flow(
    tableOnFile=true,
    table=[0,12; 21,12; 42,12; 63,12; 84,12; 105,12; 126,12; 147,12; 168,12;
        189,12; 210,12; 231,12; 252,12; 273,12; 300,12; 314,12; 328,12; 342,12;
        356,12; 370,12; 384,12; 398,12; 412,12; 426,12; 440,12; 454,12; 468,12;
        482,12; 500,10; 607,10; 714,10; 821,10; 928,10; 1035,10; 1142,10; 1249,
        10; 1356,10; 1463,10; 1570,10; 1677,10; 1784,10; 1891,10; 2000,11; 2252,
        11; 2504,11; 2756,11; 3008,11; 3260,11; 3512,11; 3764,11; 4016,11; 4268,
        11; 4520,11; 4772,11; 5024,11; 5276,11; 5534,11; 5548,11; 5562,11; 5576,
        11; 5590,11; 5604,11; 5618,11; 5632,11; 5646,11; 5660,11; 5674,11; 5688,
        11; 5702,11; 5716,11; 5734,13; 5852,13; 5970,13; 6088,13; 6206,13; 6324,
        13; 6442,13; 6560,13; 6678,13; 6796,13; 6914,13; 7032,13; 7150,13; 7268,
        13; 7386,13; 7504,13; 7622,13; 7740,13; 7858,13; 7976,13; 8094,13; 8212,
        13; 8330,13; 8448,13; 8566,13; 8684,13; 8802,13; 8920,13; 9038,13; 9156,
        13],
    tableName="Flow",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/JulyDisRestart/Flow.txt"),
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
  Modelica.Blocks.Sources.CombiTimeTable PV006(
    tableOnFile=true,
    table=[0,0.0001; 20,0.0001; 40,0.0001; 60,0.0001; 80,0.0001; 100,0.0001;
        120,0.0001; 140,0.0001; 160,0.0001; 180,0.0001; 200,0.0001; 220,0.0001;
        240,0.0001; 260,0.0001; 284,0.0001; 284,0.0001; 284,0.0001; 284,0.0001;
        284,0.0001; 284,0.0001; 284,0.0001; 284,0.0001; 284,0.0001; 284,0.0001;
        284,0.0001; 284,0.0001; 284,0.0001; 284,0.0001; 290,1; 369,1; 448,1;
        527,1; 606,1; 685,1; 764,1; 843,1; 922,1; 1001,1; 1080,1; 1159,1; 1238,
        1; 1317,1; 1400,1; 1444,1; 1488,1; 1532,1; 1576,1; 1620,1; 1664,1; 1708,
        1; 1752,1; 1796,1; 1840,1; 1884,1; 1928,1; 1972,1; 2017,1; 2017,1; 2017,
        1; 2017,1; 2017,1; 2017,1; 2017,1; 2017,1; 2017,1; 2017,1; 2017,1; 2017,
        1; 2017,1; 2017,1; 2023,0.0001; 2164,0.0001; 2305,0.0001; 2446,0.0001;
        2587,0.0001; 2728,0.0001; 2869,0.0001; 3010,0.0001; 3151,0.0001; 3292,
        0.0001; 3433,0.0001; 3574,0.0001; 3715,0.0001; 3856,0.0001; 3997,0.0001;
        4138,0.0001; 4279,0.0001; 4420,0.0001; 4561,0.0001; 4702,0.0001; 4843,
        0.0001; 4984,0.0001; 5125,0.0001; 5266,0.0001; 5407,0.0001; 5548,0.0001;
        5689,0.0001; 5830,0.0001; 5971,0.0001; 6112,0.0001],
    tableName="table_006",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/JulyDisRestart/PV006.txt"),
                                       startTime=0)
    annotation (Placement(transformation(extent={{188,84},{160,112}})));
  Modelica.Blocks.Sources.CombiTimeTable PV049_PV052(
    tableOnFile=true,
    table=[0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1; 0,1;
        1,1; 22,1; 43,1; 64,1; 85,1; 106,1; 127,1; 148,1; 169,1; 190,1; 211,1;
        232,1; 253,1; 274,1; 290,1; 291,1; 292,1; 293,1; 294,1; 295,1; 296,1;
        297,1; 298,1; 299,1; 300,1; 301,1; 302,1; 303,1; 310,0; 716,0; 1122,0;
        1528,0; 1934,0; 2340,0; 2746,0; 3152,0; 3558,0; 3964,0; 4370,0; 4776,0;
        5182,0; 5588,0; 6000,0; 9857,0; 13714,0; 17571,0; 21428,0; 25285,0;
        29142,0; 32999,0; 36856,0; 40713,0; 44570,0; 48427,0; 52284,0; 56141,0;
        60000,0; 62143,0; 64286,0; 66429,0; 68572,0; 70715,0; 72858,0; 75001,0;
        77144,0; 79287,0; 81430,0; 83573,0; 85716,0; 87859,0; 90002,0; 92145,0;
        94288,0; 96431,0; 98574,0; 100717,0; 102860,0; 105003,0; 107146,0;
        109289,0; 111432,0; 113575,0; 115718,0; 117861,0; 120004,0; 122147,0],
    tableName="table_049_052",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/JulyDisRestart/PV049_PV052.txt"),
                                                                      startTime=
       0) annotation (Placement(transformation(extent={{196,-32},{172,-8}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{138,-86},{120,-68}})));
  Modelica.Blocks.Sources.CombiTimeTable PV050_PV051(
    tableOnFile=true,
    table=[0,0; 72,0; 144,0; 216,0; 288,0; 360,0; 432,0; 504,0; 576,0; 648,0;
        720,0; 792,0; 864,0; 936,0; 1003,0; 1075,0; 1147,0; 1219,0; 1291,0;
        1363,0; 1435,0; 1507,0; 1579,0; 1651,0; 1723,0; 1795,0; 1867,0; 1939,0;
        2006,0; 2006,0; 2006,0; 2006,0; 2006,0; 2006,0; 2006,0; 2006,0; 2006,0;
        2006,0; 2006,0; 2006,0; 2006,0; 2006,0; 2010,1; 2141,1; 2272,1; 2403,1;
        2534,1; 2665,1; 2796,1; 2927,1; 3058,1; 3189,1; 3320,1; 3451,1; 3582,1;
        3713,1; 3850,1; 3970,1; 4090,1; 4210,1; 4330,1; 4450,1; 4570,1; 4690,1;
        4810,1; 4930,1; 5050,1; 5170,1; 5290,1; 5410,1; 5532,1; 5533,1; 5534,1;
        5535,1; 5536,1; 5537,1; 5538,1; 5539,1; 5540,1; 5541,1; 5542,1; 5543,1;
        5544,1; 5545,1; 5546,1; 5547,1; 5548,1; 5549,1; 5550,1; 5551,1; 5552,1;
        5553,1; 5554,1; 5555,1; 5556,1; 5557,1; 5558,1; 5559,1; 5560,1; 5561,1],
    tableName="table_050_051",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/JulyDisRestart/PV050_PV051.txt"),
      startTime=0)
    annotation (Placement(transformation(extent={{196,-78},{170,-52}})));
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
  Modelica.Blocks.Sources.CombiTimeTable THeater(
    tableOnFile=false,
    table=[0,275; 1,275; 2,275; 3,275; 4,275; 5,275; 6,275; 7,275; 8,275; 9,275;
        10,275; 11,275; 12,275; 13,275; 14,275; 15,275; 16,275; 17,275; 18,275;
        19,275; 20,275; 21,275; 22,275; 23,275; 24,275; 25,275; 26,275; 27,275;
        28,275; 29,275; 30,275; 31,275; 32,275; 33,275; 34,275; 35,275; 36,275;
        37,275; 38,275; 39,275; 40,275; 41,275; 42,275; 43,275; 44,275; 45,275;
        46,275; 47,275; 48,275; 49,275; 50,275; 51,275; 52,275; 53,275; 54,275;
        55,275; 56,275; 57,275; 58,275; 59,275; 60,275; 61,275; 62,275; 63,275;
        64,275; 65,275; 66,275; 67,275; 68,275; 69,275; 70,275; 71,275; 72,275;
        73,275; 74,275; 75,275; 76,275; 77,275; 78,275; 79,275; 80,275; 81,275;
        82,275; 83,275; 84,275; 85,275; 86,275; 87,275; 88,275; 89,275; 90,275;
        91,275; 92,275; 93,275; 94,275; 95,275; 96,275; 97,275; 98,275; 99,275],
    tableName="THeater",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/THeater.txt"),
                                        startTime=0)
    annotation (Placement(transformation(extent={{-198,124},{-182,140}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-94,112},{-76,130}})));
  Modelica.Blocks.Sources.Constant const2(k=2.1) "originall 12.6"
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
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-18,48},{2,68}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        auto_control_flowvalve)
    annotation (Placement(transformation(extent={{-58,48},{-38,68}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-22,-28},{-2,-8}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-4,158},{16,138}})));
  Modelica.Blocks.Sources.CombiTimeTable Qheater(
    tableOnFile=true,
    table=[0,0; 1,0; 2,0; 3,0; 4,0; 5,0; 6,0; 7,0; 8,0; 9,0; 10,0; 11,0; 12,0;
        13,0; 14,0; 15,0; 16,0; 17,0; 18,0; 19,0; 20,0; 21,0; 22,0; 23,0; 24,0;
        25,0; 26,0; 27,0; 28,0; 29,0; 30,0; 31,0; 32,0; 33,0; 34,0; 35,0; 36,0;
        37,0; 38,0; 39,0; 40,0; 41,0; 42,0; 43,0; 44,0; 45,0; 46,0; 47,0; 48,0;
        49,0; 50,0; 51,0; 52,0; 53,0; 54,0; 55,0; 56,0; 57,0; 58,0; 59,0; 60,0;
        61,0; 62,0; 63,0; 64,0; 65,0; 66,0; 67,0; 68,0; 69,0; 70,0; 71,0; 72,0;
        73,0; 74,0; 75,0; 76,0; 77,0; 78,0; 79,0; 80,0; 81,0; 82,0; 83,0; 84,0;
        85,0; 86,0; 87,0; 88,0; 89,0; 90,0; 91,0; 92,0; 93,0; 94,0; 95,0; 96,0;
        97,0; 98,0; 99,0],
    tableName="Q_Heater",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/Q_Heater.txt"),
    startTime=0)
    annotation (Placement(transformation(extent={{-58,154},{-42,170}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        auto_control_heater)
    annotation (Placement(transformation(extent={{-70,134},{-50,154}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=
        auto_control_pv012)
    annotation (Placement(transformation(extent={{-108,-28},{-88,-8}})));
  Modelica.Blocks.Sources.CombiTimeTable Flow_ValvePosition(
    tableOnFile=true,
    table=[0,0; 1,0; 2,0; 3,0; 4,0; 5,0; 6,0; 7,0; 8,0; 9,0; 10,0; 11,0; 12,0;
        13,0; 14,0; 15,0; 16,0; 17,0; 18,0; 19,0; 20,0; 21,0; 22,0; 23,0; 24,0;
        25,0; 26,0; 27,0; 28,0; 29,0; 30,0; 31,0; 32,0; 33,0; 34,0; 35,0; 36,0;
        37,0; 38,0; 39,0; 40,0; 41,0; 42,0; 43,0; 44,0; 45,0; 46,0; 47,0; 48,0;
        49,0; 50,0; 51,0; 52,0; 53,0; 54,0; 55,0; 56,0; 57,0; 58,0; 59,0; 60,0;
        61,0; 62,0; 63,0; 64,0; 65,0; 66,0; 67,0; 68,0; 69,0; 70,0; 71,0; 72,0;
        73,0; 74,0; 75,0; 76,0; 77,0; 78,0; 79,0; 80,0; 81,0; 82,0; 83,0; 84,0;
        85,0; 86,0; 87,0; 88,0; 89,0; 90,0; 91,0; 92,0; 93,0; 94,0; 95,0; 96,0;
        97,0; 98,0; 99,0],
    tableName="Flow_Valve",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/Flow_Valve.txt"),
    startTime=0)
    annotation (Placement(transformation(extent={{-56,28},{-38,46}})));

  Modelica.Blocks.Sources.CombiTimeTable PV_012Position(
    tableOnFile=true,
    table=[0,0; 21,0; 42,0; 63,0; 84,0; 105,0; 126,0; 147,0; 168,0; 189,0; 210,
        0; 231,0; 252,0; 273,0; 287,0; 287,0; 287,0; 287,0; 287,0; 287,0; 287,0;
        287,0; 287,0; 287,0; 287,0; 287,0; 287,0; 287,0; 293,1; 451,1; 609,1;
        767,1; 925,1; 1083,1; 1241,1; 1399,1; 1557,1; 1715,1; 1873,1; 2031,1;
        2189,1; 2347,1; 2500,1; 2717,1; 2934,1; 3151,1; 3368,1; 3585,1; 3802,1;
        4019,1; 4236,1; 4453,1; 4670,1; 4887,1; 5104,1; 5321,1; 5532,1; 5533,1;
        5534,1; 5535,1; 5536,1; 5537,1; 5538,1; 5539,1; 5540,1; 5541,1; 5542,1;
        5543,1; 5544,1; 5545,1; 5540,0; 5557,0; 5574,0; 5591,0; 5608,0; 5625,0;
        5642,0; 5659,0; 5676,0; 5693,0; 5710,0; 5727,0; 5744,0; 5761,0; 5778,0;
        5795,0; 5812,0; 5829,0; 5846,0; 5863,0; 5880,0; 5897,0; 5914,0; 5931,0;
        5948,0; 5965,0; 5982,0; 5999,0; 6016,0; 6033,0],
    tableName="PV_012",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://NHES/Systems/ExperimentalSystems/TEDS/ControlTables/PV012.txt"),
    startTime=0)
    annotation (Placement(transformation(extent={{-98,-50},{-76,-28}})));

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
  connect(PV050_PV051.y[1], firstOrder5.u) annotation (Line(points={{168.7,-65},
          {168.7,-66},{144,-66},{144,-77},{139.8,-77}},     color={0,0,127}));
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
  connect(SensorSubBus.M_dot_glycol, const2.y) annotation (Line(
      points={{40,-99},{40,136},{122.8,136}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV006.y[1], Gain.u) annotation (Line(points={{158.6,98},{148,98},{148,
          100},{137.6,100}},          color={0,0,127}));
  connect(SensorSubBus.PV006, Gain.y) annotation (Line(
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
  connect(SensorSubBus.PV050, Gain1.y) annotation (Line(
      points={{40,-99},{40,-51},{119.1,-51}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV050_PV051.y[1], Gain1.u)
    annotation (Line(points={{168.7,-65},{168.7,-66},{144,-66},{144,-51},{139.8,
          -51}},                                         color={0,0,127}));
  connect(PV012.u_s, add.y)
    annotation (Line(points={{-99.8,-57},{-115.1,-57}}, color={0,0,127}));
  connect(switch2.u2,booleanExpression1. y)
    annotation (Line(points={{-20,58},{-37,58}}, color={255,0,255}));
  connect(switch3.u1, PV012.y) annotation (Line(points={{-24,-10},{-38,-10},{-38,
          -57},{-79.1,-57}},        color={0,0,127}));
  connect(booleanExpression.y,switch1. u2) annotation (Line(points={{-49,144},{-16,
          144},{-16,148},{-6,148}},                      color={255,0,255}));
  connect(Chromolox_Heater_Control.y,switch1. u1) annotation (Line(points={{-25.1,
          121},{-6,121},{-6,140}},             color={0,0,127}));
  connect(switch1.u3, Qheater.y[1]) annotation (Line(points={{-6,156},{-36,156},
          {-36,162},{-41.2,162}}, color={0,0,127}));
  connect(SensorSubBus.W_heater, switch1.y) annotation (Line(
      points={{40,-99},{36,-99},{36,148},{17,148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.Valve_fl, switch2.y) annotation (Line(
      points={{40,-99},{40,-56},{10,-56},{10,58},{3,58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch3.u2, booleanExpression2.y)
    annotation (Line(points={{-24,-18},{-87,-18}}, color={255,0,255}));
  connect(SensorSubBus.PV012, switch3.y) annotation (Line(
      points={{40,-99},{40,-70},{4,-70},{4,-18},{-1,-18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Flow_ValvePosition.y[1], switch2.u3) annotation (Line(points={{-37.1,37},
          {-28,37},{-28,50},{-20,50}}, color={0,0,127}));
  connect(PV_012Position.y[1], switch3.u3) annotation (Line(points={{-74.9,-39},
          {-74.9,-40},{-32,-40},{-32,-26},{-24,-26}}, color={0,0,127}));
  connect(VolFlow_Control.y, switch2.u1) annotation (Line(points={{-77.1,33},{-68,
          33},{-68,66},{-20,66}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})),
    experiment(
      StopTime=6000,
      Interval=10,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"));
end Control_System_TEDS_ExpTest_Discharging_July_2023_LargerTables;
