within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_OTSG_Power_Control
  extends BaseClasses.Partial_ControlSystem;

  parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
  parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

  parameter SI.Pressure p_overpressure = 100e5 "OverPressure steam turbine pressure";
  parameter SI.Pressure p_nominal = 50e5 "Nominal steam pressure";

  parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
  parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

  input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));
  input SI.Power Reactor_Power "Reactor Power Level" annotation(Dialog(group="Inputs"));
  input SI.Power Nominal_Power "Nominal Power Level" annotation(Dialog(group="Inputs"));
  Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
    annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
  Modelica.Blocks.Logical.Switch switch_BV
    annotation (Placement(transformation(extent={{40,12},{60,32}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
    annotation (Placement(transformation(extent={{-180,-82},{-160,-62}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
  Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
    annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
  TRANSFORM.Controls.LimPID
                       PID_TCV_opening(
    yMax=1 -TCV_openingNominal.k,
    yMin=-TCV_openingNominal.k + 0.0001,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k_s=0.25e-8,
    k_m=0.25e-8)
           annotation (Placement(transformation(extent={{-60,220},{-40,240}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  Modelica.Blocks.Logical.Switch switch_TCV_setpoint
    annotation (Placement(transformation(extent={{40,212},{60,232}})));
  Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
    annotation (Placement(transformation(extent={{0,190},{20,210}})));
  Modelica.Blocks.Math.Add TCV_opening
    annotation (Placement(transformation(extent={{80,170},{100,190}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
    annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
  TRANSFORM.Controls.LimPID PID_BV_opening(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1 - BV_openingNominal.k,
    yMin=-BV_openingNominal.k + 0.0001,
    k=1,
    Ti=10,
    k_s=1/(12.5*160e6),
    k_m=1/(12.5*160e6))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Add BV_opening
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.RealExpression
                                   Power_Nominal(y=Nominal_Power)
    annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
  Modelica.Blocks.Sources.RealExpression Power_Level(y=Reactor_Power)
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
  Modelica.Blocks.Sources.Constant p_Nominal1(k=p_nominal)
    annotation (Placement(transformation(extent={{-138,220},{-118,240}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-12,-254},{8,-234}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-12,-284},{8,-264}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{-10,-134},{10,-114}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{-10,-194},{10,-174}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=3000)
    annotation (Placement(transformation(extent={{-10,-164},{10,-144}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-12,-224},{8,-204}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,-134},{76,-114}})));
  Modelica.Blocks.Sources.Constant TBV_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,-194},{76,-174}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,-164},{76,-144}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{96,-224},{76,-204}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{96,-254},{76,-234}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{96,-284},{76,-264}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-62,-248},{-42,-228}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-62,-234},{-42,-214}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-62,-220},{-42,-200}})));
  TRANSFORM.Blocks.RealExpression Power
    annotation (Placement(transformation(extent={{-62,-204},{-42,-184}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-62,-188},{-42,-168}})));
  TRANSFORM.Blocks.RealExpression Steam_Pressure
    annotation (Placement(transformation(extent={{-62,-172},{-42,-152}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-62,-154},{-42,-134}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-62,-136},{-42,-116}})));
equation

  connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
          200},{-142,200}},
                          color={0,0,127}));
  connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
          {-150,208},{-142,208}},
                                color={0,0,127}));
  connect(greater5.y, switch_P_setpoint_TCV.u2)
    annotation (Line(points={{-119,200},{-102,200}}, color={255,0,255}));
  connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
        points={{21,200},{30,200},{30,214},{38,214}},
                                                  color={0,0,127}));
  connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
    annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
  connect(switch_TCV_setpoint.u2, switch_P_setpoint_TCV.u2) annotation (Line(
        points={{38,222},{-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
        color={255,0,255}));
  connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
          {70,222},{70,186},{78,186}},  color={0,0,127}));
  connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,160},
          {20,160},{20,174},{78,174}},
                                    color={0,0,127}));
  connect(actuatorBus.opening_TCV, TCV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,30},{-146,
          30},{-146,18},{-142,18}}, color={0,0,127}));
  connect(greater1.y, switch_P_setpoint.u2)
    annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
  connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
          10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
  connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
          {-150,200},{-142,200}},
                                color={0,0,127}));
  connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-72},
          {30,-72},{30,-6},{78,-6}}, color={0,0,127}));
  connect(switch_BV.y, BV_opening.u1)
    annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
  connect(PID_BV_opening.y, switch_BV.u1)
    annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
  connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
          -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
  connect(BV_diffopeningNominal.y, switch_BV.u3)
    annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
  connect(actuatorBus.opening_BV, BV_opening.y) annotation (
      Line(
      points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, switch_P_setpoint_TCV.u1) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,208},{-102,208}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(switch_P_setpoint_TCV.y, PID_TCV_opening.u_m)
    annotation (LineW_total(points={{-79,200},{-50,200},{-50,218}}, color={0,0,127}));
  connect(Power_Nominal.y, PID_BV_opening.u_s) annotation (Line(points={{-159,-12},
          {-114,-12},{-114,30},{-62,30}}, color={0,0,127}));
  connect(Power_Level.y, switch_P_setpoint.u1) annotation (Line(points={{-159,
          -30},{-132,-30},{-132,-28},{-108,-28},{-108,18},{-102,18}}, color={0,
          0,127}));
  connect(Power_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,
          -12},{-112,-12},{-112,2},{-102,2}}, color={0,0,127}));
  connect(p_Nominal1.y, PID_TCV_opening.u_s)
    annotation (Line(points={{-117,230},{-62,230}}, color={0,0,127}));
  connect(p_Nominal1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{
          -117,230},{-114,230},{-114,192},{-102,192}}, color={0,0,127}));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-244},{9,-244}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV,BV_TCV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-274},{9,-274}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-214},{9,-214}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,-184},{11,-184}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed,Feed_Pump_Speed. y) annotation (Line(
      points={{30,-100},{30,-154},{11,-154}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-124},{11,-124}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-274},{75,-274}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-244},{75,-244}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-214},{75,-214}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,TBV_Opening. y) annotation (Line(
      points={{30,-100},{30,-184},{75,-184}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-154},{75,-154}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-124},{75,-124}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-104,-100},{-104,-238},{-64,-238}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-224},{-64,-224}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,Feedwater_Temperature. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-210},{-64,-210}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power,Power. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-194},{-64,-194}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-178},{-64,-178}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,Steam_Pressure. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-162},{-64,-162}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,Steam_Temperature. u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-144},{-64,-144}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, W_total_setpoint.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-126},{-64,-126}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation (defaultComponentName="EM_CS",
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
end CS_OTSG_Power_Control;