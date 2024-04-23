within NHES.Systems.ExperimentalSystems.TEDS.Data;
model Geometry_singlePoro "Clensed Geometry"

parameter SI.Length Radius_Tank = 7.3                                         "Radius of the Thermocline Tank";
parameter Integer nodes = 146                                                 "Number of nodes in the thermocline";
parameter Real Porosity   = 0.25                                              "Porosity";
parameter SI.Length dr = 0.04                                                 "Nominal Diameter of filler material";
parameter SI.Length Insulation_thickness = 0.051*2                            "Thickness of the Insulation";
parameter SI.Length Wall_Thickness = 0.051                                    "Thickness of the tank";
parameter SI.Length Height_Tank = 2.92                                        "Height of Thermocline Tank section (Oil and Beads)";
parameter SI.Length Height_Tank_OilOnly = 0.44                                "Height of Thermocline Tank section (Oil Only)";
parameter Real weightFactorTop = 0.1                                          "Top TES Weight factor for heat loss through TES head cover";
parameter Real weightFactorBottom = 0.1                                       "Bottom TES Weight factor for heat loss through TES Bottom cover";

parameter SI.Area XS_Fluid = Porosity*Modelica.Constants.pi*(Radius_Tank^2.0) "Cross Sectional Area of the Fluid";

parameter SI.Length dz = Height_Tank/nodes                                    "Delta Height";

parameter SI.Temperature T_amb = 293.15                                       "Temperature of the Ambient Air";
parameter SI.Temperature T_ground = 273.15                                    "Temperature of the ground soil"
  annotation (Icon(graphics={Bitmap(extent={{-132,-100},{132,100}}, fileName="modelica://NHES/../../../../Desktop/TRANSFORM/TRANSFORM-Library-master/TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}));

end Geometry_singlePoro;
