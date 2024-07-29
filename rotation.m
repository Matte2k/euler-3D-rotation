close all
clearvars
clc

addpath(genpath('src\'));

%%  Initialization

sysWorld = struct;
    [sysWorld.refWorld]=initTerna();
        sysWorld.refWorld.versor = diag([1 1 1]);
    [sysWorld.refMatlab]=initTerna();

Equipment = struct;
    [Equipment.sysCustom.refCustom]=initTerna();
        Equipment.sysCustom.refCustom.versor = diag([1 1 1]);
    [Equipment.sysCustom.refWorld]=initTerna();
    [Equipment.sysCustom.refMatlab]=initTerna();

    [Equipment.sysAnodo.refAnodo]=initTerna();
        Equipment.sysAnodo.refAnodo.versor = diag([1 1 1]);
    [Equipment.sysAnodo.refCustom]=initTerna();
    [Equipment.sysAnodo.refWorld]=initTerna();
    [Equipment.sysAnodo.refMatlab]=initTerna();

    [Equipment.sysShutter.refShutter]=initTerna();
        Equipment.sysShutter.refShutter.versor = diag([1 1 1]);
    [Equipment.sysShutter.refCustom]=initTerna();
    [Equipment.sysShutter.refWorld]=initTerna();
    [Equipment.sysShutter.refMatlab]=initTerna();

    [Equipment.sysDetettore.refDetettore]=initTerna();
        Equipment.sysDetettore.refDetettore.versor = diag([1 1 1]);
    [Equipment.sysDetettore.refCustom]=initTerna();
    [Equipment.sysDetettore.refWorld]=initTerna();
    [Equipment.sysDetettore.refMatlab]=initTerna();
    
Transformation = struct;
    Transformation.anodo2custom = initTransformation();
    Transformation.shutter2custom = initTransformation();
    Transformation.detettore2custom = initTransformation();
    Transformation.custom2world = initTransformation();
    Transformation.world2matlab = initTransformation();


%%  Define custom system

% world origin expressed wrt matlab reference system
sysWorld.refMatlab.orig = [10 10 0]';                                                                 % [10 10 0] as example
% definition of euler angle and rotation tensor to converto from world to matlab
Transformation.world2matlab.eulerAngle = [0 0 0]';                                                  % [0 0 0] as example
[Transformation.world2matlab.R] = rotationTensor(Transformation.world2matlab.eulerAngle);

% custom origin expressed wrt world reference system
Equipment.sysCustom.refWorld.orig = [20 10 0]';                                                      % [20 10 0] as example
% definition of euler angle and rotation tensor to convert from custom to world
Transformation.custom2world.eulerAngle = [180 0 0]';                                                % [180 0 0] as example
[Transformation.custom2world.R] = rotationTensor(Transformation.custom2world.eulerAngle);

%-----------------------------------------------------------------------------------------
% Note: rotation are CW
% anodo origin expressed wrt custom reference system
Equipment.sysAnodo.refCustom.orig = [20 8 10]';                                                       % [20 8 10] as example
% definition of euler angle and rotation tensor to convert from anodo to custom
Transformation.anodo2custom.eulerAngle = [0 13 180]';                                                 % [0 0 180] as example
[Transformation.anodo2custom.R] = rotationTensor(Transformation.anodo2custom.eulerAngle);

% shutter origin expressed wrt custom reference system
Equipment.sysShutter.refCustom.orig = [20 8 8]';                                                     % [20 8 8] as example
% definition of euler angle and rotation tensor to convert from shutter to custom
Transformation.shutter2custom.eulerAngle = [0 0 180]';                                               % [0 0 180] as example
[Transformation.shutter2custom.R] = rotationTensor(Transformation.shutter2custom.eulerAngle);

% detettore origin expressed wrt custom reference system
Equipment.sysDetettore.refCustom.orig = [20 8 0]';                                                   % [20 8 0] as example
% definition of euler angle and rotation tensor to convert from detettore to custom
Transformation.detettore2custom.eulerAngle = [0 0 0]';                                            % [0 0 0] as example
[Transformation.detettore2custom.R] = rotationTensor(Transformation.detettore2custom.eulerAngle);


%%  Axis transformation

%%% Anodo trasformation
% AnodoVersor in anodo reference INTO custom reference
[Equipment.sysAnodo.refCustom.versor] = changeSysReference(   Equipment.sysAnodo.refCustom.orig, ...
                                                              Transformation.anodo2custom.R,...
                                                              Equipment.sysAnodo.refAnodo.versor );
% AnodoOrig in custom reference is an input

% AnodoVersor in custom reference INTO world reference
[Equipment.sysAnodo.refWorld.versor] = changeSysReference(     Equipment.sysCustom.refWorld.orig, ...
                                                               Transformation.custom2world.R,...
                                                               Equipment.sysAnodo.refCustom.versor );
% AnodoOrig in custom reference INTO world reference
[Equipment.sysAnodo.refWorld.orig] = changeSysReference(    Equipment.sysCustom.refWorld.orig, ...
                                                            Transformation.custom2world.R,...
                                                            Equipment.sysAnodo.refCustom.orig );

% AnodoVersor in world reference INTO matlab reference
[Equipment.sysAnodo.refMatlab.versor] = changeSysReference(    sysWorld.refMatlab.orig, ...
                                                               Transformation.world2matlab.R,...
                                                               Equipment.sysAnodo.refWorld.versor );
% AnodoOrig in world reference INTO matlab reference
[Equipment.sysAnodo.refMatlab.orig] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                            Transformation.world2matlab.R,...
                                                            Equipment.sysAnodo.refWorld.orig );


%%% Shutter trasformation
% ShutterVersor in shutter reference INTO custom reference
[Equipment.sysShutter.refCustom.versor] = changeSysReference(   Equipment.sysShutter.refCustom.orig, ...
                                                                Transformation.shutter2custom.R,...
                                                                Equipment.sysShutter.refShutter.versor );
% ShutterOrig in custom reference is an input

% ShutterVersor in custom reference INTO world reference
[Equipment.sysShutter.refWorld.versor] = changeSysReference(    Equipment.sysCustom.refWorld.orig, ...
                                                                Transformation.custom2world.R,...
                                                                Equipment.sysShutter.refCustom.versor );
% ShutterOrig in custom reference INTO world reference
[Equipment.sysShutter.refWorld.orig] = changeSysReference(   Equipment.sysCustom.refWorld.orig, ...
                                                             Transformation.custom2world.R,...
                                                             Equipment.sysShutter.refCustom.orig );

% ShutterVersor in world reference INTO matlab reference
[Equipment.sysShutter.refMatlab.versor] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                                Transformation.world2matlab.R,...
                                                                Equipment.sysShutter.refWorld.versor );
% ShutterOrig in world reference INTO matlab reference
[Equipment.sysShutter.refMatlab.orig] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                              Transformation.world2matlab.R,...
                                                              Equipment.sysShutter.refWorld.orig );


%%% Detettore transformation
% DetettoreVersor in detettore reference INTO custom reference
[Equipment.sysDetettore.refCustom.versor] = changeSysReference(  Equipment.sysDetettore.refCustom.orig, ...
                                                                    Transformation.detettore2custom.R,...
                                                                    Equipment.sysDetettore.refDetettore.versor );
% DetettoreOrig in custom reference is an input

% DetettoreVersor in custom reference INTO world reference
[Equipment.sysDetettore.refWorld.versor] = changeSysReference(    Equipment.sysCustom.refWorld.orig, ...
                                                                  Transformation.custom2world.R,...
                                                                  Equipment.sysDetettore.refCustom.versor );
% DetettoreOrig in custom reference INTO world reference
[Equipment.sysDetettore.refWorld.orig] = changeSysReference(   Equipment.sysCustom.refWorld.orig, ...
                                                               Transformation.custom2world.R,...
                                                               Equipment.sysDetettore.refCustom.orig );

% DetettoreVersor in world reference INTO matlab reference
[Equipment.sysDetettore.refMatlab.versor] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                                  Transformation.world2matlab.R,...
                                                                  Equipment.sysDetettore.refWorld.versor );
% DetettoreOrig in world reference INTO matlab reference
[Equipment.sysDetettore.refMatlab.orig] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                                Transformation.world2matlab.R,...
                                                                Equipment.sysDetettore.refWorld.orig );


%%% Custom transformation
% CustomVersor in custom reference INTO world reference
[Equipment.sysCustom.refWorld.versor] = changeSysReference(       Equipment.sysCustom.refWorld.orig, ...
                                                                  Transformation.custom2world.R, ...
                                                                  Equipment.sysCustom.refCustom.versor );
% CustomOrig in custom reference INTO world reference
[Equipment.sysCustom.refWorld.orig] = changeSysReference(   Equipment.sysCustom.refWorld.orig, ...
                                                            Transformation.custom2world.R,...
                                                            Equipment.sysCustom.refCustom.orig );

% CustomVersor in world reference INTO matlab reference
[Equipment.sysCustom.refMatlab.versor] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                               Transformation.world2matlab.R,...
                                                               Equipment.sysCustom.refWorld.versor );
% CustomOrig in world reference INTO matlab reference
[Equipment.sysCustom.refMatlab.orig] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                             Transformation.world2matlab.R,...
                                                             Equipment.sysCustom.refWorld.orig );


%%% World transformation
% WorldVersor in world reference INTO matlab reference
[sysWorld.refMatlab.versor] = changeSysReference(   sysWorld.refMatlab.orig, ...
                                                    Transformation.world2matlab.R,...
                                                    sysWorld.refWorld.versor );
% WorldOrig in matlab reference is an input


%%  Plots

%%% Plot everything from the POV of world reference
% Figure initialization
figure('Name','World reference')
view(3)
axis equal
grid on
hold on

% systems plot
sysPlot(sysWorld.refWorld,'k');
sysPlot(Equipment.sysCustom.refWorld,'r');
sysPlot(Equipment.sysAnodo.refWorld,'b');
sysPlot(Equipment.sysShutter.refWorld,'g');
sysPlot(Equipment.sysDetettore.refWorld,'m');
legend('World','','','Custom','','','Anodo','','','Shutter','','','Detettore','','');

%%% Plot everything from the POV of custom reference
% Figure initialization
figure('Name','Custom reference view')
view(3)
axis equal
grid on
hold on

% systems plot
sysPlot(Equipment.sysCustom.refCustom,'r')
sysPlot(Equipment.sysAnodo.refCustom,'b')
sysPlot(Equipment.sysShutter.refCustom,'g')
sysPlot(Equipment.sysDetettore.refCustom,'m')
legend('Custom','','','Anodo','','','Shutter','','','Detettore','','');

% TO ADD ROWS USE COMMAND 'quiver3'

%%  Output File

% save all the data in struct Equipment to a .txt file
diary Equipment.txt         % create a log file
unfold(Equipment);          % display data inside Equipment and append strings to log file
diary off                   % close the log file

% save all the data in struct Equipment to a .txt file
diary Transformation.txt    % create a log file
unfold(Transformation);     % display data inside Equipment and append strings to log file
diary off                   % close the log file