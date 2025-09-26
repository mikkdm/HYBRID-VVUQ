within NHES.Systems.ExperimentalSystems.TEDS.SupportComponents;
model RMSE_Calculator "Calculates RMSE of two values"
  extends Modelica.Blocks.Interfaces.SI2SO;
  Real integral(start = 0);
algorithm
  der(integral) := (u1-u2)*(u1-u2);
equation
  y = sqrt(integral/(time + Modelica.Constants.eps));
end RMSE_Calculator;
