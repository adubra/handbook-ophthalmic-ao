%FN_SYMBOLIC_ZERNIKE_POLAR generates a symbolic expression for the defined 
%   Zernike polynomial in polar coordinates. This uses the regular formula
%   for Zernike polynomials:
%       Ref: L. N. Thibos, R. A. Applegate, J. T. Schwiegerling, and 
%            R. Webb, "Standards for reporting the optical aberrations of 
%            eyes," Journal of refractive surgery 18, S652-S660 (2002).
%            Note that in this reference, the denominator in the radial 
%            polynomial is wrong, the bracket should be closed after |m|.
%
%   Example : 
%
%       numeric_radial_index    = 4;
%       numeric_azimuthal_index = 2;
%       sym_Zernike             = fn_symbolic_Zernike(                  ...
%                                                 numeric_radial_index, ...
%                                                 numeric_azimuthal_index);
%
%   See also fn_symbolic_Zernike_cartesian
% 
%   Vyas Akondi and Alfredo Dubra 2020
%--------------------------------------------------------------------------

function sym_Zernike = fn_symbolic_Zernike_polar(numeric_radial_index,        ...
                                                 numeric_azimuthal_index,     ...
                                                 rho,                         ...
                                                 theta)
                                             
if abs(numeric_radial_index) < abs(numeric_azimuthal_index)
    
    error(['The radial index should always be greater than the absolute'...
           'of the azimuthal index'])
end

% Validating radial and azimuthal index
if ceil(numeric_radial_index/2) == numeric_radial_index/2
    
    if ceil(abs(numeric_azimuthal_index)/2) ~= abs(numeric_azimuthal_index)/2
        
        error(['If the radial index is even, the absolute of the '      ...
               'azimuthal should be even as well!'])
        
    end
else
    if ceil(abs(numeric_azimuthal_index)/2) == abs(numeric_azimuthal_index)/2
        
        error(['If the radial index is odd, the absolute of the '       ...
               'azimuthal should be odd as well!'])
        
    end
    
end

% Initialize symbolic variables
syms radial_index azimuthal_index k sym_radial_term real

% Symbolic definition of the normalization constant
sym_norm_factor        = sqrt(2 * (radial_index + 1) /                  ...
                         (1 + kroneckerDelta(azimuthal_index, 0)));

% Symbolic definition of a single radial term in the summation
sym_radial_term_single = (-1)^k *                                       ...
                         factorial(radial_index - k) /                  ...
                         factorial(k) /                                 ...
                         factorial(0.5*(radial_index   +                ...
                                 abs(azimuthal_index)) - k) /           ...
                         factorial(0.5*(radial_index   -                ...
                                 abs(azimuthal_index)) - k) *           ...
                         rho^(radial_index - 2 * k);
% Convert symbolic symbolic single radial term to anonymous function
afn_radial_term        = matlabFunction(sym_radial_term_single);

% Convert symbolic symbolic normalization factor to anonymous function
afn_norm_factor        = matlabFunction(sym_norm_factor);

% Initialize Zernike radial term (result after summation)
sym_radial_term        = rho;

for current_s_value = 0 : 1 : (numeric_radial_index                     ...
                            - abs(numeric_azimuthal_index))/2
    
    sym_radial_term = sym_radial_term                                   ...
                             + afn_radial_term(numeric_azimuthal_index, ...
                                               current_s_value,         ...
                                               numeric_radial_index,rho);
end

% Final radial Zernike term (rho subtracted due to initilization)
sym_radial_term = (sym_radial_term  - rho)                              ...
                    * afn_norm_factor(numeric_azimuthal_index,          ...
                                      numeric_radial_index);

% Symbolic azimuthal term evaluation
if numeric_azimuthal_index < 0
    sym_azimuthal_term = -sin(numeric_azimuthal_index * theta);
elseif numeric_azimuthal_index >= 0
    sym_azimuthal_term =  cos(numeric_azimuthal_index * theta);
end

% Evaluate symbolic Zernike polynomial
sym_Zernike = sym_radial_term * sym_azimuthal_term;