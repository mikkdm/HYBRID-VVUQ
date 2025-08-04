within NHES.Utilities.FMI_Templates.Adaptors.ElectricalAdaptors;
model GeneralFrequencyToPowerFlowAdaptor
  "Signal adaptor for an Electrical port with frequency and derivative of frequency as outputs and power as an input (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="freq",
    final Name_pder="dfreq",
    final Name_pder2="d2freq",
    final Name_f="Power",
    final Name_fder="der(Power)",
    final Name_fder2="der2(Power)",
    final use_pder2=false,
    final use_pder=false,
    final use_fder=false,
    final use_fder2=false,
    p(unit="Hz"),
    final pder(unit="Hz/s"),
    final pder2(unit="Hz/s2"),
    final f(unit="W"),
    final fder(unit="W/s"),
    final fder2(unit="W/s2"));
  Electrical.Interfaces.ElectricalPowerPort_a portElec_a
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
equation
  y = portElec_a.W "output = flow = power flow";
  u = portElec_a.f "input = potential = frequency";
  annotation (defaultComponentName="temperatureToHeatFlowAdaptor",
    Documentation(info="<html>
<p>
Adaptor between an electrical connector and a frequency boundary.
This component is used to provide a pure signal interface around an ElectricalPowerPort
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
<p>
Note, the input signals must be consistent to each other
(derf=der(f)).
</p>
</html>"),
    Icon(graphics={
            Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={191,0,0},
          radius=10,
          lineThickness=0.5)}));
end GeneralFrequencyToPowerFlowAdaptor;
