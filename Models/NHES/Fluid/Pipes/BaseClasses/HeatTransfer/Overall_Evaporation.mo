within NHES.Fluid.Pipes.BaseClasses.HeatTransfer;
model Overall_Evaporation
  "Evaporation: Overall evaporation model from single phase liquid to single phase vapor."

  extends
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.Partial_TwoPhaseHeatTransfer;

  parameter SIadd.nonDim[nHT] x_CHF=0.9*ones(nHT)
    "Steam quality corresponding to Critical Heat Flux";

  replaceable function heatTransfer_SinglephaseLiquid =
     NHES.Fluid.ClosureModels.HeatTransfer.alpha_DittusBoelter
    constrainedby NHES.Fluid.ClosureModels.HeatTransfer.alpha_DittusBoelter
     annotation(choicesAllMatching=true);

  replaceable function heatTransfer_TwoPhaseSaturated =
     NHES.Fluid.ClosureModels.HeatTransfer.alpha_Chen_TwoPhase
    constrainedby NHES.Fluid.ClosureModels.HeatTransfer.alpha_Chen_TwoPhase
     annotation(choicesAllMatching=true);

  replaceable function heatTransfer_SinglephaseVapor =
     NHES.Fluid.ClosureModels.HeatTransfer.alpha_DittusBoelter
    constrainedby NHES.Fluid.ClosureModels.HeatTransfer.alpha_DittusBoelter
     annotation(choicesAllMatching=true);

     SI.CoefficientOfHeatTransfer[nHT] alphas_SinglephaseLiquid;
     SI.CoefficientOfHeatTransfer[nHT] alphas_TwoPhaseSaturated;
     SI.CoefficientOfHeatTransfer[nHT] alphas_SinglephaseVapor;

equation

  for i in 1:nHT loop
    alphas_SinglephaseLiquid[i] = heatTransfer_SinglephaseLiquid(
       D=dimensions[i],
       lambda=lambdas[i],
       Re=Res[i],
       Pr=Prs[i]);

    alphas_TwoPhaseSaturated[i] = heatTransfer_TwoPhaseSaturated(
       D=dimensions[i],
       G=m_flows[i]/crossAreas[i],
       x=x_abs[i],
       rho_fsat=rho_fsat[i],
       mu_fsat=mu_fsat[i],
       lambda_fsat=lambda_fsat[i],
       cp_fsat=cp_fsat[i],
       sigma=sigma[i],
       rho_gsat=rho_gsat[i],
       mu_gsat=mu_gsat[i],
       h_fg=h_gsat[i] - h_fsat[i],
       Delta_Tsat=heatPorts[i].T - sat[i].Tsat,
       Delta_psat=Medium.saturationPressure(heatPorts[i].T) - p[i]);

    alphas_SinglephaseVapor[i] = heatTransfer_SinglephaseVapor(
       D=dimensions[i],
       lambda=lambdas[i],
       Re=Res[i],
       Pr=Prs[i]);

    // These perform the same function just using different methods
    //alphas[i] = TRANSFORM.Math.spliceSigmoid(TRANSFORM.Math.spliceSigmoid(alphas_SinglephaseLiquid[i],alphas_TwoPhaseSaturated[i],x_th[i],0,k=200),alphas_SinglephaseVapor[i],x_th[i],x_CHF[i],k=200);
    alphas[i] = NHES.Math.spliceTanh(
                alphas_SinglephaseVapor[i],
                NHES.Math.spliceTanh(
                  alphas_TwoPhaseSaturated[i],
                  alphas_SinglephaseLiquid[i],
                  x_th[i],
                  deltax=0.02),
                x_th[i] - x_CHF[i],
                deltax=0.02);

    Nus[i] = dimensions[i]/lambdas[i]*alphas[i];
  end for;

end Overall_Evaporation;
