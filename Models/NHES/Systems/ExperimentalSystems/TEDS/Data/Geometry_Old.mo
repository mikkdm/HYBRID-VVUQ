within NHES.Systems.ExperimentalSystems.TEDS.Data;
model Geometry_Old

parameter SI.Length Radius_Tank = 7.3                            "Radius of the Thermocline Tank";
parameter Real Porosity   = 0.25                                 "Porosity_up";
parameter Real Porosity_2 = 0.50                                 "Porosity_down";
parameter Integer nodesTop = 31                                  "Number of nodes in the thermocline tank Top";
parameter Integer nodes = 146                                    "Number of nodes in the thermocline";
parameter Integer nodesBottom = 1                                "Number of nodes in the thermocline tank Bottom";

parameter SI.Length dr = 0.04                                    "Nominal Diameter of filler material";
parameter SI.Length dr_void = 0.000000000001                     "It should be very close to 0";
parameter SI.Length Insulation_thickness = 0.051*2               "Thickness of the Insulation";
parameter SI.Length Wall_Thickness = 0.051                       "Thickness of the tank";

parameter SI.Length Height_TankTop = 3.55 - 2.92                 "Height of Thermocline Tank bottom";
parameter SI.Length Height_Tank = 2.92                           "Height of Thermocline Tank";
parameter SI.Length Height_TankBottom = 0.19                     "Height of Thermocline Tank";

parameter SI.Area XS_Fluid = Porosity*Modelica.Constants.pi*(Radius_Tank^2.0) "Cross Sectional Area of the Fluid";

parameter SI.Length dzTop = Height_TankTop/nodesTop              "Delta Height of TES Top";
parameter SI.Length dz = Height_Tank/nodes                       "Delta Height";

parameter SI.Temperature T_amb = 293.15 "Temperature of the Ambient Air"
  annotation (Icon(graphics={Bitmap(extent={{-132,-100},{132,100}}, fileName="modelica://NHES/../../../../Desktop/TRANSFORM/TRANSFORM-Library-master/TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}));

end Geometry_Old;
