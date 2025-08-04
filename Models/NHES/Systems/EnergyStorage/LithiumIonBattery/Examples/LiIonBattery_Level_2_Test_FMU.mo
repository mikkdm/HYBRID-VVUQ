within NHES.Systems.EnergyStorage.LithiumIonBattery.Examples;
model LiIonBattery_Level_2_Test_FMU
  "Example test of the Level_2 battery model."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));

  Electrical.Sources.FrequencySource      boundary(f=60)
    annotation (Placement(transformation(extent={{120,-56},{100,-36}})));
  Modelica.Blocks.Sources.Trapezoid
                                trapezoid(
    amplitude=10,
    rising=1,
    width=5000,
    falling=1,
    period=10000,
    offset=-5,
    startTime=1000)
    annotation (Placement(transformation(extent={{-78,18},{-58,38}})));
  NHES.Utilities.FMI_Templates.Adaptors.ElectricalAdaptors.GeneralPowerFlowTofrequencyAdaptor
    ElectricalFlowtoFrequency
    annotation (Placement(transformation(extent={{90,-56},{70,-36}})));
  LIBattery_Level_2_CoSim_FMU_fmu lIBattery_Level_2_CoSim_FMU_fmu
    annotation (Placement(transformation(extent={{-22,-10},{34,46}})));
equation
  connect(ElectricalFlowtoFrequency.portElec_a, boundary.portElec_b)
    annotation (Line(points={{82,-46},{100,-46}}, color={255,0,0}));
  connect(ElectricalFlowtoFrequency.f, lIBattery_Level_2_CoSim_FMU_fmu.power_out)
    annotation (Line(points={{77,-54},{56,-54},{56,-66},{174,-66},{174,26},{
          39.6,26},{39.6,18}}, color={0,0,127}));
  connect(trapezoid.y, lIBattery_Level_2_CoSim_FMU_fmu.pSetPoint) annotation (
      Line(points={{-57,28},{-56,27.52},{-23.12,27.52}}, color={0,0,127}));
  connect(lIBattery_Level_2_CoSim_FMU_fmu.frequency_in,
    ElectricalFlowtoFrequency.p) annotation (Line(points={{-23.12,8.76},{-82,
          8.76},{-82,-32},{77,-32},{77,-38}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=30000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p><b><span style=\"font-size: 16pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">Simple Litium-Ion Battery model (ver.2)</span></p>
<p><br><b><span style=\"font-size: 16pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">This battery&apos;s EMF is specified by the charging and discharging curve, defined using the E0, K, A, InvB parameters. &apos;_C&apos; is for charging and &apos;_D&apos; is for discharging. The constraints of max charging power and max discharging power can be specified in the battery model. Four protection features are implimented in this model: </span></p>
<p><span style=\"font-size: 12pt;\">1. Over-charge / Over-discharge protection; </span></p>
<p><span style=\"font-size: 12pt;\">2. Over-current protection; </span></p>
<p><span style=\"font-size: 12pt;\">3. Over-voltage protection; </span></p>
<p><span style=\"font-size: 12pt;\">4. Over-power protection. </span></p>
<p><br><b><span style=\"font-size: 16pt;\">What Users Can Do </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 16pt;\">Reference </span></b></p>
<p><span style=\"font-size: 12pt;\">[1] Wang, Haoyu, Roberto Ponciroli, and Richard B. Vilim. Development of Electro-chemical Battery Model for Plug-and-Play Eco-system Library. No. ANL/NSE-21/26. Argonne National Lab.(ANL), Argonne, IL (United States), 2021.</span></p>
<p><br><b><span style=\"font-size: 16pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Haoyu Wang.</span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Haoyu Wang (haoyuwang@anl.gov). </span></p>
</html>"));
end LiIonBattery_Level_2_Test_FMU;
