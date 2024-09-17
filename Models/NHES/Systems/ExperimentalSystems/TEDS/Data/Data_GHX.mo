within NHES.Systems.ExperimentalSystems.TEDS.Data;
record Data_GHX

  extends BaseClasses_2.Record_Data;

parameter SI.Temperature T_EthGly_Out = 12.78 + 273.15;

parameter Modelica.Units.SI.MassFlowRate mdot_total=5.5 "Nominal Total Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));



  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="Eth_Gly HX")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_GHX;
