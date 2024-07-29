function [sysStruct] = initTerna()
%initTerna
%   INPUT: null
%   OUTPUT: sysStruct with 2 field:
%       - orig: vector (3,1) components of the origin point of the
%               reference system
%       - versor: matrix (3,3), where columns are the versor components

sysStruct = struct;
sysStruct.orig = [0 0 0]';
sysStruct.versor = zeros(3,3);

end