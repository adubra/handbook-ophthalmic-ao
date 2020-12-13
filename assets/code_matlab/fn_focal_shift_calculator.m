% FOCAL_SHIFT_CALCULATOR returns the separation between the diffraction and
%              geometric focus in a converging beam free of
%              aberrations using the approximate formulae derived by
%              either Li (https://doi.org/10.1364/JOSA.72.000770) or
%              Sheppard & Török (https://doi.org/10.1364/JOSAA.20.002156).
%              The function always returns negative values, as the
%              diffraction focus (point of maximum intensity) is shifted
%              against the direction of the wavefront propagation.
%              The function syntax is 
%
%              focal_shift = fn_focal_shift_calculator(...
%                                           wavelength,...
%                                           beam_diameter,...
%                                           distance_to_geometric_focus,...
%                                           algorithm);
%
%              where wavelength is the wavelength of light, beam_diameter
%              of the converging beam and distance_to_geometric_focus are
%              relative to any plane orthogonal to the beam direction of
%              propagation. All three distances and the output are in units
%              of meters and could be scalars, 1D or 2D matrices. The last
%              input should be a string that starts with the letters "L" or
%              "S" to indicate the use of the Li or the Sheppard and Török
%              algorithm.
%
% Vyas Akondi and Alfredo Dubra 2020

function focal_shift = fn_focal_shift_calculator(wavelength,...
                                                 beam_diameter,...
                                                 distance_to_geometric_focus,...
                                                 algorithm)  
                                          
% calculating the beam Fresnel number
N                  = (beam_diameter / 2).^2 ...
                   ./ (wavelength .* distance_to_geometric_focus);

% calculating F-number
F                  = distance_to_geometric_focus ./ beam_diameter;

% converting input algorithm string to lowercase
algorithm          = lower(algorithm);

% algorithm selection
if algorithm(1) == 'l'             

    if min(N(:)) < 0.5    
        warning(['One or more of the calculated focal shift values is '...
                 'outside the valid range of the approximation N > 0.5'])
    end
         
    if min(F(:)) < 1.0    
        warning(['One or more of the calculated focal shift values is '...
                 'outside the valid range of the approximation F >= 1.'])
    end

    focal_shift    = -12 * distance_to_geometric_focus...
                  .* (1 + 1./(8 * F.^2)) ./ (pi^2 * N.^2)...
                  .* (1-exp(-(pi^2*N.^2) ./ (12*(1+1./(8*F.^2)))...
                      ./ (1+N.*(1-1./(16*F.^2)))));
    
elseif algorithm(1) == 's'
    
    % TODO: Vyas, what are the approximation limitations for this formula?
    alpha          = asin(beam_diameter ./ distance_to_geometric_focus / 2);

    focal_shift    = - distance_to_geometric_focus...
                  ./ (cos(alpha/2).^2 + (pi^2*N.^2/12).*sec(alpha/2).^2);
else
    error(['The algorithm string must start with "L" for Li and "S" ' ...
           'for Sheppard and Török'])
end
                                        
