within NHES.Systems.ExperimentalSystems.TEDS.Models.ThermoclineTank;
model Thermocline_noBeads_Top_UQVV
  "Base Thermocline Using the new updated heat transfer correlation to allow for stagnant flow conditions"
  import TRANSFORM;

  replaceable package Medium =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

//Tank Parameters
parameter SI.Length Radius_Tank=0.438 "Radius of the thermocline tank [m]";
parameter Real Porosity=1 "Porosity in the tank";
parameter SI.Area XS_fluid = Porosity*(Radius_Tank^2.0)*Modelica.Constants.pi "Cross Sectional Area seen by the fluid at each axial location";
parameter SI.Length Height_Tank = 4.435 "Tank Height [m]";

//Discretization
parameter Integer nodes=1 "Number of axial nodes";

parameter SI.Length dz = Height_Tank/nodes "delta height in each node";

//Attempt to input medium package
//SI.Density d_T[nodes]= Medium.density(mediums.state);
SI.Pressure ps[nodes] = fill(1e5,nodes);

//parameter Real userspecificheat= 2474.5 "Should be input in J/kg*K";
SI.SpecificHeatCapacity Cf[nodes] = Medium.specificHeatCapacityCp(mediums.state);

//SI.SpecificHeatCapacity Cf[nodes] = fill(userspecificheat,nodes); //This can be used if the user knows an approximately constant value over their desired operations range, else comment this line and uncomment the one above it.

Medium.BaseProperties mediums[nodes];

SI.Temperature Tf[nodes] "Fluid Temperature up and down the thermocline";
SI.Temperature Tr[nodes] "Filler Temperature up and down the thermocline";

parameter SI.Density filler_density = 2630 "Filler Density (Granite)";
parameter SI.SpecificHeatCapacity Cr = 775.0 "J/kg*K of granite";
parameter SI.ThermalConductivity kr = 2.8 "W/m*K of filler";

SI.ReynoldsNumber Re[nodes] "Unitless";
SI.MassFlowRate mf;  //=-128.74 "kg/s";
SI.Velocity vel[nodes] "meter/s";
SI.CoefficientOfHeatTransfer h_c[nodes] "W/m^2*K";
SI.PrandtlNumber Pr[nodes] "Unitless";
SI.Length r_char "hydraulic radius [m]";
parameter SI.Length dr=0.0001 "nominal diameter of filler material [m]";

SI.ThermalConductivity kf[nodes] = Medium.thermalConductivity(mediums.state) "W/m*K of fluid";
SI.DynamicViscosity mu_f[nodes] = Medium.dynamicViscosity(mediums.state);
SI.Density fluid_density[nodes] = Medium.density(mediums.state);

SI.Length Sr "Heat Transfer Surface Area of rocks per unit length of tank [m]";
parameter Real fs=3.0 "Surface Shape Factor, between 2 and 3 
depending rocks packing scheme";
parameter SI.Temperature T_Init = 40+273.15 "Initial temperature of thermocline medium and wall";

SI.Temperature T_inlet_cold;
SI.Temperature T_inlet_hot;

SI.Temperature Tf_edge[nodes+1] "Boundary Nodes for fluid temperatures";

SI.Length z_star[nodes];

Medium.ThermodynamicState port_a_state "Properties of fluid port a";
Medium.ThermodynamicState port_b_state "Properties of fluid port b";

//Initialization Step **********************************************
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,16},{10,36}}),
        iconTransformation(extent={{-10,16},{10,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare replaceable package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}}),
        iconTransformation(extent={{-10,-36},{10,-16}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow
                                               heatPorts[nodes,1]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-112,-10},{-92,10}})));
initial equation

for i in 1:integer(nodes*1.33/2) loop
  Tf[i]=T_Init;
  Tr[i]=T_Init;
end for;
for i in integer(nodes*1.33/2)+1:nodes loop

  Tf[i]=T_Init;
  Tr[i]=T_Init;

end for;

// Start of the actual Thermocline Equation Set**********************
equation

//Resetting the density, and dynamic viscosity as function of temperature at each node
  mediums.p = ps;
  mediums.T = Tr;

// Port Parameters
  port_a.p = port_b.p;
  port_b.h_outflow = mediums[nodes].h;
  port_a.h_outflow = mediums[1].h;
  0 = port_a.m_flow+port_b.m_flow;
  port_a_state = Medium.setState_ph(port_a.p,inStream(port_a.h_outflow));
  port_b_state = Medium.setState_ph(port_b.p,inStream(port_b.h_outflow));

heatPorts[:,1].T = Tf;
//heatPorts[:,2].T = Tr;

//define ports
T_inlet_cold = port_b_state.T;
T_inlet_hot = port_a_state.T;

mf = port_a.m_flow;

//Ensure there is no divide by zero circumstance.*********************************************
if mf > -0.002 and mf < 0.002 then
  Re = fill(0.0001,nodes); //Simply forces the answer to not be equal to 0
else
  for i in 1:nodes loop
    Re[i] = 4*r_char*(abs(mf)/(Porosity*(Radius_Tank^2.0)*Modelica.Constants.pi))/mu_f[i];
  end for;
end if;

//Pr = Cf*mu_f./kf;
for i in 1:nodes loop
  Pr[i] = Cf[i]*mu_f[i]/kf[i];
end for;

r_char = Porosity*dr/(4.0*(1-Porosity));
for i in 1:nodes loop
  // Eq. (4.2) in Gunn, D. J. "Transfer of heat or mass to particles in fixed and fluidised beds." International Journal of Heat and Mass Transfer 21.4 (1978): 467-476.
  h_c[i] = ((7-10*Porosity + 5*(Porosity^2))*(1+0.7*(Re[i]^0.2)*(Pr[i]^(1/3))) + (1.33-2.4*Porosity+1.2*(Porosity^2.))*(Re[i]^0.7)*(Pr[i]^(1/3)))*kf[i]/(2*r_char);
end for;

Sr = fs*Modelica.Constants.pi*(1-Porosity)*(Radius_Tank^2.0)/(dr/2);

//Fluid Energy Equation**************************************************************
//Will likely need to add in the Q(i) term into the fluid temperature section rather than into both of the energy equations.
//for i in 1:nodes loop
  vel = mf./(fluid_density*XS_fluid);
//end for;

if mf >= 0.0 then
  for i in 2:nodes loop
    (h_c[i]*Sr/(fluid_density[i]*Cf[i]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) + heatPorts[i,1].Q_flow/(fluid_density[i]*Cf[i]*XS_fluid*dz) = der(Tf[i]) + vel[i]* (Tf[i]-Tf[i-1])/dz;
  end for;
//Boundary Condition for positive flow from cold to hot.
(h_c[1]*Sr/(fluid_density[1]*Cf[1]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[1]-Tf[1]) + heatPorts[1,1].Q_flow/(fluid_density[1]*Cf[1]*XS_fluid*dz) = der(Tf[1]) + vel[1]* (Tf[1]-T_inlet_hot)/dz;
else
  for i in 1:nodes-1 loop
    (h_c[i]*Sr/(fluid_density[i]*Cf[i]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) + heatPorts[i,1].Q_flow/(fluid_density[i]*Cf[i]*XS_fluid*dz) = der(Tf[i]) + vel[i]* (Tf[i+1]-Tf[i])/dz;
  end for;
  //Boundary Condition for positive flow from cold to hot.
  (h_c[nodes]*Sr/(fluid_density[nodes]*Cf[nodes]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[nodes]-Tf[nodes])+ heatPorts[nodes,1].Q_flow/(fluid_density[nodes]*Cf[nodes]*XS_fluid*dz) = der(Tf[nodes]) + vel[nodes]* (T_inlet_cold-Tf[nodes])/dz;
end if;

Tf_edge[1]=T_inlet_hot;
Tf_edge[nodes+1]=Tf[nodes];
for i in 2:nodes loop
  Tf_edge[i] = (Tf[i]+Tf[i-1])/2;
end for;

//Rock Energy
for i in 1:nodes loop
    h_c[i]*Sr*(Tr[i]-Tf[i])*dz  = -filler_density*Cr*(1-Porosity)*Modelica.Constants.pi*(Radius_Tank^2.0)*dz*der(Tr[i]);
end for;

for i in 1:nodes loop
  z_star[i] = (i-1)*Height_Tank + dz/2; //Should put it at the halfway point of the tank.
end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,14},{60,-14}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-10,4},{10,-2}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="i=1")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>Author: Konor Frick</p>
<p>Date: March 2, 2020</p>
<p>Description:</p>
<p>The Model Developed here was implemented based upon two papers. </p>
<p>1. Analysis of Heat Storage and Delivery of a Thermocline Tank Having Solid Filler Material </p>
<p>-<span style=\"font-family: Roboto,Arial,sans-serif;\">DOI: 10.1115/1.4003685</span></p>
<p>2. A Versatile one-dimensional numebrical model for packed-bed heat storage systems</p>
<p>-DOI. <span style=\"font-family: NexusSans,Arial,Helvetica,Lucida Sans Unicode,Microsoft Sans Serif,Segoe UI Symbol,STIXGeneral,Cambria Math,Arial Unicode MS,sans-serif;\"><a href=\"https://doi.org/10.1016/j.renene.2018.10.012\">https://doi.org/10.1016/j.renene.2018.10.012</a></span></p>
<p><br>The model backbone is the Schumann equations with additional terms incorporated for thermal conduction when in standby mode. </p>
</html>"));
end Thermocline_noBeads_Top_UQVV;
