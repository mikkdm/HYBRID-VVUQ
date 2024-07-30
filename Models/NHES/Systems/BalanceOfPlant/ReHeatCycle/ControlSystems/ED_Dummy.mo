within NHES.Systems.BalanceOfPlant.ReHeatCycle.ControlSystems;
model ED_Dummy

  extends RankineCycle.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
