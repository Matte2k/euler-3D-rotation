
function [elementTransformed, iterStop] = changeSysReference(origInitial, R, element2Tranform)
%changeSysReference 
%   INPUT:
%       origInitial -> vector (3,1), origin of initial reference
%       R -> rotation tensor associated to the change of reference of interest 
%       element2Tranform -> matrix 3,n point to change reference         
%
%   OUTPUT:
%       elementTransformed -> matrix 3,n point in the new reference
%
    
   element2Tranform_size = size(element2Tranform);

   if element2Tranform_size(1) ~= 3
       error ('dimension of the item to rotate is incompatible with rotation matrix');
   end

   iterStop = element2Tranform_size(2);
   elementTransformed = zeros(3,iterStop);

   for i=1:iterStop
      elementTransformed(:,i) = R * element2Tranform(:,i) + origInitial; 
   end
    
end
