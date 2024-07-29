clear all
close all

% vector plot = quiver3

%%% input stlmesh
obj0 = stlread('untitled.stl');
mplot1 = trimesh(obj0);
mplot1.FaceColor = 'k';
mplot1.EdgeColor = 'b';
%mplot1.LineStyle = 'none';
hold on

%%% extract prop from stlmesh
obj0_point = obj0.Points;
obj0_connecto  = obj0.ConnectivityList;

%%% Euler Rot matrix
% z cost, alpha ang
alpha = deg2rad(180);    % 30deg
R_alpha = [ cos(alpha)      -sin(alpha)    0 ; ...
            sin(alpha)      cos(alpha)     0 ; ...
            0               0              1 ];

% y cost, beta ang
beta = deg2rad(45);    % 30deg
R_beta = [  cos(beta)       0      sin(beta) ; ...
            0               1      0 ; ...
            -sin(beta)      0      cos(beta) ];

% x cost, gam ang
gam = deg2rad(90);    % 30deg
R_gam = [   1       0              0         ; ...
            0       cos(gam)       -sin(gam) ; ...
            0       sin(gam)       cos(gam) ];

% rotation tensor merge
R_tot = R_alpha * R_beta * R_gam;

%%
%ROTATION
meshLenght = length(obj0_point);
for i=1:meshLenght  
    obj0_point_rot(i,:) =  (R_tot * obj0.Points(i,:)')' + [5 7 0];
end

%CHANGE OF REF
meshLenght = length(obj0_point);
for i=1:meshLenght  
    obj0_point_refChange(i,:) =  (R_tot' * obj0.Points(i,:)')' + [5 7 0];
end

a2 = triangulation(obj0_connecto,obj0_point_rot);
mplot2 = trimesh(a2);
mplot2.FaceColor = 'r';
mplot2.EdgeColor = 'k';
%mplot2.LineStyle = 'none';

axis equal
