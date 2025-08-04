within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples;
model HTSE_TightlyCoupled_SteamFlowCtrl_Test_FY17_FMU
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=5800000,
    T=591.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-72,10},{-54,28}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=6270000,
    T=497.457,
    nPorts=1)  annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-65,-28})));

  NHES.Systems.Examples.BaseClasses.Data_Capacity
                            dataCapacity(
                SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
         70000000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
    massFlowToPressure
    annotation (Placement(transformation(extent={{-34,10},{-28,32}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
    pressureToMassFlow
    annotation (Placement(transformation(extent={{-28,-38},{-34,-20}})));
  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models.HTSE_FMU_Cosim
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu(
      _p_in_port_a_start=580000)
    annotation (Placement(transformation(extent={{-12,-24},{30,18}})));
equation
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.m_flow_out_port_a,
    massFlowToPressure.m_flow_in) annotation (Line(points={{34.2,-7.2},{46,-7.2},
          {46,31.1538},{-27.4,31.1538}}, color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.h_out_port_a,
    massFlowToPressure.h_in) annotation (Line(points={{34.2,-15.6},{44,-15.6},{
          44,28.6154},{-27.4,28.6154}}, color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.m_in_port_b,
    pressureToMassFlow.m_flow_out) annotation (Line(points={{-12.84,9.6},{-22,
          9.6},{-22,-22},{-27.4,-22},{-27.4,-20.6923}}, color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.h_in_port_b,
    pressureToMassFlow.h_out) annotation (Line(points={{-12.84,1.2},{-27.4,1.2},
          {-27.4,-22.7692}}, color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.p_in_port_a,
    massFlowToPressure.p_out) annotation (Line(points={{-12.84,-7.2},{-12.84,-6},
          {-20,-6},{-20,18.4615},{-27.4,18.4615}}, color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.h_in_port_a,
    massFlowToPressure.h_out) annotation (Line(points={{-12.84,-15.6},{-12.84,
          -14},{-20,-14},{-20,10},{-22,10},{-22,15.9231},{-27.4,15.9231}},
        color={0,0,127}));
  connect(
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.h_out_port_b,
    pressureToMassFlow.h_in) annotation (Line(points={{34.2,1.2},{34.2,0},{48,0},
          {48,-33.1538},{-27.4,-33.1538}}, color={0,0,127}));
  connect(pressureToMassFlow.p_in,
    nHES_Systems_IndustrialProcess_HighTempSteamElectrolysis_Models_TightlyCoupled_0HTSE_0SteamFlowCtrl_0FY17_0FMU_0adaptor_fmu.p_out_port_b)
    annotation (Line(points={{-27.4,-31.0769},{42,-31.0769},{42,9.6},{34.2,9.6}},
        color={0,0,127}));
  connect(pressureToMassFlow.fluidPort, heatingMedium_out.ports[1]) annotation
    (Line(points={{-34.06,-28.9308},{-45.03,-28.9308},{-45.03,-28},{-56,-28}},
        color={0,0,0}));
  connect(massFlowToPressure.fluidPort, heatingMedium_in.ports[1]) annotation (
      Line(points={{-34,21},{-34,20},{-42,20},{-42,19},{-54,19}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=360,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_TightlyCoupled_SteamFlowCtrl_Test_FY17_FMU;
