function [R_tot] = rotationTensor(eulerAngle)
%ROTATIONTENSOR Summary of this function goes here
%   WIP

%%% Euler Rot matrix
% z cost, alpha ang
alpha = deg2rad(eulerAngle(1));
R_alpha = [ cos(alpha)      -sin(alpha)    0 ; ...
            sin(alpha)      cos(alpha)     0 ; ...
            0               0              1 ];

% y cost, beta ang
beta = deg2rad(eulerAngle(2));
R_beta = [  cos(beta)       0      sin(beta) ; ...
            0               1      0 ; ...
            -sin(beta)      0      cos(beta) ];

% x cost, gam ang
gam = deg2rad(eulerAngle(3));
R_gam = [   1       0              0         ; ...
            0       cos(gam)       -sin(gam) ; ...
            0       sin(gam)       cos(gam) ];

% rotation tensor merge
R_tot = R_alpha * R_beta * R_gam;   % notation R_(0->c)


end

