within NHES.Systems.ExperimentalSystems.TEDS.Data;
model Geometry_multiplePoro "Clensed Geometry"

parameter SI.Length Radius_Tank = 7.3                            "Radius of the Thermocline Tank";
parameter Integer nodes = 146                                    "Number of nodes in the thermocline";
parameter Real Porosity[nodes] = fill(0.25, nodes)               "Porosity";
//parameter Real Porosity[nodes] = {
//poro_1, poro_2, poro_3, poro_4, poro_5, poro_6, poro_7, poro_8, poro_9, poro_10,
//poro_11,poro_12,poro_13,poro_14,poro_15,poro_16,poro_17,poro_18,poro_19,poro_20,
//poro_21,poro_22,poro_23,poro_24,poro_25,poro_26,poro_27,poro_28,poro_29,poro_30,
//poro_31,poro_32,poro_33,poro_34,poro_35,poro_36,poro_37,poro_38,poro_39,poro_40,
//poro_41,poro_42,poro_43,poro_44,poro_45,poro_46,poro_47,poro_48,poro_49,poro_50,
//poro_51,poro_52,poro_53,poro_54,poro_55,poro_56,poro_57,poro_58,poro_59,poro_60,
//poro_61,poro_62,poro_63,poro_64,poro_65,poro_66,poro_67,poro_68,poro_69,poro_70, poro_71}               "Porosity";
//parameter Real Porosity   = 0.25                               "Porosity";
parameter SI.Length dr = 0.04                                    "Nominal Diameter of filler material";
parameter SI.Length Insulation_thickness = 0.051*2               "Thickness of the Insulation";
parameter SI.Length Wall_Thickness = 0.051                       "Thickness of the tank";
parameter SI.Length Height_Tank = 2.92                           "Height of Thermocline Tank section (Oil and Beads)";
parameter SI.Length Height_Tank_OilOnly = 0.44                   "Height of Thermocline Tank section (Oil Only)";
parameter Real weightFactorTop = 0.1                             "Top TES Weight factor for heat loss through TES head cover";
parameter Real weightFactorBottom = 0.1                          "Bottom TES Weight factor for heat loss through TES Bottom cover";

parameter SI.Area XS_Fluid[nodes] = Porosity*Modelica.Constants.pi*(Radius_Tank^2.0) "Cross Sectional Area of the Fluid";

parameter SI.Length dz = Height_Tank/nodes                       "Delta Height";

parameter SI.Temperature T_amb = 293.15                          "Temperature of the Ambient Air";
parameter SI.Temperature T_ground = 273.15                       "Temperature of the ground soil"
  annotation (Icon(graphics={Bitmap(extent={{-132,-100},{132,100}}, fileName="modelica://NHES/../../../../Desktop/TRANSFORM/TRANSFORM-Library-master/TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}));

end Geometry_multiplePoro;
