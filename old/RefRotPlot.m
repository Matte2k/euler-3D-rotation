close all
clear

%% INPUT
%%% Initial sys ref     [INPUT]
orig_0Ref = [0 0 0]';
eulerAngle_0Ref = [0 0 0]';     % Tait bryan convention

%%% Custom sys ref      [INPUT]
orig_cRef = [1 1 1]';             
eulerAngle_cRef = [0 180 0]';     % Tait bryan convention

%%% define a point in custom reference
P_cRef = [1 1 1]';


%% REFERENCE SYS AXIS

%%% Figure initialization
figure
view(3)
axis equal
grid on
hold on

% local axis versor initialization
x_axis = [1; 0; 0];
y_axis = [0; 1; 0];
z_axis = [0; 0; 1];


%%% Rotation tensor definition
[R_tot_0Ref] = RotationTensor(eulerAngle_0Ref);
[R_tot_cRef] = RotationTensor(eulerAngle_cRef);


%%% 0Ref sys
% sys axis definition
x0_0Ref = R_tot_0Ref * x_axis ;
y0_0Ref = R_tot_0Ref * y_axis ;
z0_0Ref = R_tot_0Ref * z_axis ;

% sys axis PLOT
x0 = quiver3(orig_0Ref(1), orig_0Ref(2) ,orig_0Ref(3), x0_0Ref(1), x0_0Ref(2), x0_0Ref(3), Color='k', AutoScale='off');
y0 = quiver3(orig_0Ref(1), orig_0Ref(2) ,orig_0Ref(3), y0_0Ref(1), y0_0Ref(2), y0_0Ref(3), Color='k', AutoScale='off');
z0 = quiver3(orig_0Ref(1), orig_0Ref(2) ,orig_0Ref(3), z0_0Ref(1), z0_0Ref(2), z0_0Ref(3), Color='k', AutoScale='off');


%%% cRef sys
% sys axis definition
x1_cRef = R_tot_cRef * x_axis ;
y1_cRef = R_tot_cRef * y_axis ;
z1_cRef = R_tot_cRef * z_axis ;

% sys axis PLOT
x1 = quiver3(orig_cRef(1), orig_cRef(2) ,orig_cRef(3), x1_cRef(1), x1_cRef(2), x1_cRef(3), Color='r', AutoScale='off');
y1 = quiver3(orig_cRef(1), orig_cRef(2) ,orig_cRef(3), y1_cRef(1), y1_cRef(2), y1_cRef(3), Color='r', AutoScale='off');
z1 = quiver3(orig_cRef(1), orig_cRef(2) ,orig_cRef(3), z1_cRef(1), z1_cRef(2), z1_cRef(3), Color='r', AutoScale='off');


%% POINT EXAMPLE

% point change of reference and plot
P_0Ref = R_tot_cRef * P_cRef + orig_cRef;
%P = R_tot_0Ref * P_0Ref + orig_0Ref;

plot3(P_0Ref(1), P_0Ref(2), P_0Ref(3),'*', MarkerEdgeColor='k', MarkerSize=8)
legend('x0','y0','z0','x1','y1','z1','P')




