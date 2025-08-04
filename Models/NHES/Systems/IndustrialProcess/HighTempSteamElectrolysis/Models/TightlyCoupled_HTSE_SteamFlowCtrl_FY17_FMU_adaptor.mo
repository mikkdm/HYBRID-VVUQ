within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models;
model TightlyCoupled_HTSE_SteamFlowCtrl_FY17_FMU_adaptor
  import NHES;
  extends Modelica.Icons.Example;
  replaceable package Medium=Modelica.Media.Water.StandardWater;
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(use_port=false,
                                              f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
    massFlowToPressure(redeclare package Medium = Medium, p_atm=HTSE.port_b_nominal.p)
    annotation (Placement(transformation(extent={{10,-26},{-10,26}},
        rotation=90,
        origin={-32,-50})));
  Modelica.Blocks.Interfaces.RealInput C_in_port_a[size(pressureToMassFlow.C_in,
    1)] "Prescribed mass fractions" annotation (Placement(transformation(extent={{-132,
            -82},{-114,-64}}),        iconTransformation(extent={{-118,-100},{-100,
            -82}})));
  Modelica.Blocks.Interfaces.RealInput m_in_port_b "Prescribed pressure"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-92,-90}),  iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-94,-108})));
  Modelica.Blocks.Interfaces.RealInput h_in_port_b "Prescribed pressure"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-72,-90}),  iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-74,-108})));
  Modelica.Blocks.Interfaces.RealInput X_in_port_b[size(massFlowToPressure.X_in,
    1)] "Prescribed mass fractions" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-53,-91}),  iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-56,-108})));
  Modelica.Blocks.Interfaces.RealInput C_in_port_b[size(massFlowToPressure.C_in,
    1)] "Prescribed mass fractions" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-37,-91}),  iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-34,-108})));
  Modelica.Blocks.Interfaces.RealOutput p_out_port_b annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-6,-94}), iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={32,-112})));
  Modelica.Blocks.Interfaces.RealOutput h_out_port_b annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={16,-94}),  iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={4,-112})));
  Modelica.Blocks.Interfaces.RealOutput C_out_port_b[size(massFlowToPressure.C_out,
    1)] "Prescribed Flows" annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={78,-94}),  iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={60,-112})));
  Modelica.Blocks.Interfaces.RealOutput X_out_port_b[size(massFlowToPressure.X_out,
    1)] "Prescribed Traces" annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={46,-94}),  iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={88,-112})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
    pressureToMassFlow(redeclare package Medium = Medium, p_atm=HTSE.port_a_nominal.p)
    annotation (Placement(transformation(extent={{-84,-2},{-64,50}})));
  Modelica.Blocks.Interfaces.RealInput X_in_port_a[size(pressureToMassFlow.X_in,
    1)] "Prescribed mass fractions" annotation (Placement(transformation(extent={{-132,
            -40},{-114,-22}}),       iconTransformation(extent={{-118,-58},{-100,
            -40}})));
  Modelica.Blocks.Interfaces.RealInput p_in_port_a "Prescribed pressure"
    annotation (Placement(transformation(extent={{-132,-20},{-114,-2}}),
        iconTransformation(extent={{-118,-38},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out_port_a annotation (Placement(
        transformation(extent={{-114,60},{-138,84}}), iconTransformation(extent=
           {{-100,42},{-124,66}})));
  Modelica.Blocks.Interfaces.RealOutput X_out_port_a[size(pressureToMassFlow.X_out,
    1)] "Prescribed traces" annotation (Placement(transformation(extent={{-114,88},
            {-138,112}}),    iconTransformation(extent={{-100,70},{-124,94}})));
  Modelica.Blocks.Interfaces.RealOutput h_out_port_a annotation (Placement(
        transformation(extent={{-114,30},{-138,54}}), iconTransformation(extent=
           {{-100,12},{-124,36}})));
  Modelica.Blocks.Interfaces.RealOutput C_out_port_a[size(pressureToMassFlow.C_out,
    1)] "Prescribed Mass Fractions" annotation (Placement(transformation(extent={{-114,14},
            {-138,38}}),           iconTransformation(extent={{-100,-4},{-124,
            20}})));
  Modelica.Blocks.Interfaces.RealInput h_in_port_a "Prescribed pressure"
    annotation (Placement(transformation(extent={{-142,-56},{-124,-38}}),
        iconTransformation(extent={{-118,-38},{-100,-20}})));
  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
    HTSE(
    capacity=70000000,
    port_a_nominal(m_flow=HTSE.capacityScaler_steamFlow*7.311637),
    redeclare
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
      CS(capacityScaler=HTSE.capacityScaler),
    flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
    returnPump(PR0=62.7/51.3042, pstart_out=6270000),
    hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false)))
    annotation (Placement(transformation(extent={{-30,-20},{34,48}})));
equation

  connect(m_in_port_b,massFlowToPressure. m_flow_in) annotation (Line(points={{-92,-90},
          {-92,-80},{-56,-80},{-56,-62}},           color={0,0,127}));
  connect(C_in_port_b,massFlowToPressure. C_in) annotation (Line(points={{-37,-91},
          {-37,-82},{-38,-82},{-38,-62}},   color={0,0,127}));
  connect(X_in_port_b,massFlowToPressure. X_in) annotation (Line(points={{-53,-91},
          {-53,-80},{-44,-80},{-44,-62}}, color={0,0,127}));
  connect(h_in_port_b,massFlowToPressure. h_in) annotation (Line(points={{-72,-90},
          {-72,-82},{-50,-82},{-50,-62}},   color={0,0,127}));
  connect(massFlowToPressure.p_out,p_out_port_b)  annotation (Line(points={{-26,-62},
          {-26,-76},{-6,-76},{-6,-94}},     color={0,0,127}));
  connect(massFlowToPressure.h_out,h_out_port_b)  annotation (Line(points={{-20,-62},
          {-20,-76},{16,-76},{16,-94}},      color={0,0,127}));
  connect(X_out_port_b,massFlowToPressure. X_out) annotation (Line(points={{46,-94},
          {46,-76},{-14,-76},{-14,-62}},   color={0,0,127}));
  connect(C_out_port_b,massFlowToPressure. C_out) annotation (Line(points={{78,-94},
          {78,-76},{-8,-76},{-8,-62}},     color={0,0,127}));
  connect(pressureToMassFlow.p_in,p_in_port_a)  annotation (Line(points={{-86,18},
          {-116,18},{-116,-11},{-123,-11}},color={0,0,127}));
  connect(pressureToMassFlow.h_out,h_out_port_a)
    annotation (Line(points={{-86,42},{-126,42}}, color={0,0,127}));
  connect(X_in_port_a,pressureToMassFlow. X_in) annotation (Line(points={{-123,
          -31},{-110,-31},{-110,6},{-86,6}},   color={0,0,127}));
  connect(pressureToMassFlow.C_out,C_out_port_a)  annotation (Line(points={{-86,30},
          {-100,30},{-100,26},{-126,26}}, color={0,0,127}));
  connect(pressureToMassFlow.m_flow_out,m_flow_out_port_a)  annotation (Line(
        points={{-86,48},{-104,48},{-104,72},{-126,72}},
                                                       color={0,0,127}));
  connect(pressureToMassFlow.X_out,X_out_port_a)  annotation (Line(points={{-86,36},
          {-94,36},{-94,100},{-126,100}},   color={0,0,127}));
  connect(h_in_port_a, pressureToMassFlow.h_in) annotation (Line(points={{-133,
          -47},{-102,-47},{-102,12},{-86,12}}, color={0,0,127}));
  connect(C_in_port_a, pressureToMassFlow.C_in) annotation (Line(points={{-123,
          -73},{-92,-73},{-92,0},{-86,0}}, color={0,0,127}));
  connect(HTSE.portElec_a, sinkElec.port)
    annotation (Line(points={{34,14},{52,14},{52,0},{70,0}}, color={255,0,0}));
  connect(HTSE.port_a, pressureToMassFlow.fluidPort) annotation (Line(points={{
          -30,27.6},{-30,24.2},{-63.8,24.2}}, color={0,127,255}));
  connect(HTSE.port_b, massFlowToPressure.fluidPort) annotation (Line(points={{
          -30,0.4},{-36,0.4},{-36,-34},{-32,-34},{-32,-40}}, color={0,127,255}));
  annotation (experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Created by: Konor Frick </p>
<p>Date: 10/28/2020</p>
<p>Creation of FMU/FMU using the FMI Utility adaptor system.  This unit can be exported as an FMI/FMU in either model exchange or co-simulation mode.</p>
<p>Reference: K Frick, A. Alfonsi, C. Rabiti, S. Bragg-Sitton. &quot;Development of the IES Plug and Play Framework&quot;. Idaho National Laboratory. INL/EXT-21-62050.</p>
</html>"));
end TightlyCoupled_HTSE_SteamFlowCtrl_FY17_FMU_adaptor;
