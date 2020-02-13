clear all
clc


syms T S_1 N S_2 alpha_1 alpha_2 beta_1 beta_2 gamma_1 gamma_2 mu_1 mu_2 mu_3 mu_4 omega D C b mu_1 mu_2 mu_3 mu_4 xi 


%f1=alpha_1*gamma_1*S_1*N+alpha_2*gamma_2*N*S_2-mu_1*T;
%f2=(omega*T*S_2)-(xi+S_2)*beta_1*S_1*N-(xi+S_2)*mu_2*S_1;
%f3=b*N*(D-N)-D*gamma_1*N*S_1-D*gamma_2*N*S_2-D*mu_3*N;
%f4=C-beta_2*N*S_2-mu_4*S_2;
f1=omega* (alpha_1 * gamma_1 * S_1 + alpha_2 * gamma_2 * S_2) * S_2 * (C - mu_4 * S_2) - beta_1 * S_1 * (C - mu_4 * S_2) * mu_1 * (xi + S_2) - mu_2 * S_1 * mu_1 * (xi + S_2) * beta_2 * S_2;
f2=b*(C-mu_4*S_2)*(beta_2*S_2*D - C + mu_4*S_2) - gamma_1*(C - mu_4*S_2)*S_1*beta_2*S_2*D - gamma_2*(C - mu_4*S_2)*beta_2*(S_2^2)*D - mu_3*(C - mu_4*S_2)*beta_2*S_2*D;

Sol=solve(f1,f2,S_1,S_2)
%Sol=solve(f1,f2,f3,f4,T,S_1,N,S_2)
%Sol.T
%Sol.S_1
%Sol.N
%Sol.S_2
