within NHES.Systems.ExperimentalSystems.TEDS.BaseClasses_1;
partial model Partial_SubSystem_A

  extends Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem;

  extends Templates.SubSystem_Standalone.BaseClasses.Record_SubSystem_A;

  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
