function [] = sysPlot(sysRef,color)
%UNTITLED6 Summary of this function goes here
%   sysRef: struct with two fields
%       - orig: vector (3,1)
%       - versor: matrix (3,3), where columns are the versor components
%   color: string that define the line color

% xNorm = norm(sysRef.versor(:,1));
% yNorm = norm(sysRef.versor(:,2));
% zNorm = norm(sysRef.versor(:,3));

% x = quiver3(sysRef.orig(1), sysRef.orig(2) ,sysRef.orig(3), ...
%             sysRef.versor(1,1)/xNorm, sysRef.versor(2,1)/xNorm, sysRef.versor(3,1)/xNorm, Color=color, AutoScale='off');
% 
% y = quiver3(sysRef.orig(1), sysRef.orig(2) ,sysRef.orig(3), ...
%             sysRef.versor(1,2)/yNorm, sysRef.versor(2,2)/yNorm, sysRef.versor(3,2)/yNorm, Color=color, AutoScale='off');
% 
% z = quiver3(sysRef.orig(1), sysRef.orig(2) ,sysRef.orig(3), ...
%             sysRef.versor(1,3)/zNorm, sysRef.versor(2,3)/zNorm, sysRef.versor(3,3)/zNorm, Color=color, AutoScale='off');

x = plot3([sysRef.orig(1) sysRef.versor(1,1)], [sysRef.orig(2) sysRef.versor(2,1)] , [sysRef.orig(3) sysRef.versor(3,1)], ...
          Color=color);

y = plot3([sysRef.orig(1) sysRef.versor(1,2)], [sysRef.orig(2) sysRef.versor(2,2)] , [sysRef.orig(3) sysRef.versor(3,2)], ...
          Color=color);

z = plot3([sysRef.orig(1) sysRef.versor(1,3)], [sysRef.orig(2) sysRef.versor(2,3)] , [sysRef.orig(3) sysRef.versor(3,3)], ...
          Color=color);

end