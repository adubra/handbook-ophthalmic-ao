% FN_ZERNIKE_POLAR evaluates a Zernike polynomial at locations
%              expressed in polar coordinates. The polynomial is
%              normalized according to the OSA Standards for reporting the
%              optical aberrations of eyes
%              (https://doi.org/10.1364/VSIA.2000.SuC1), and its order is
%              specified using either the one- or two-index notation
%              promoted by the same standard.
%              The syntax for using this function with the two-index
%              notation is
%
%                  Z = fn_zernike_polar(Rho, Theta, n, m);
%
%              where the scalars n and m are radial and azimuthal indices
%              of the polynomial to be evaluated at the points with polar
%              coordinates in the matrices Rho and Theta. Similarly, the
%              syntax for evaluating a polynomial using the one-index
%              notation is
%
%                  Z = fn_zernike_polar(Rho, Theta, j);
%
%              where the scalar j is the polynomial order.
%              The accuracy of this function is limited among other factors
%              by the factorial function which might not be accurate for
%              numbers much grater than 20.
%              
%              Vyas Akondi and Alfredo Dubra, Stanford, 2021.

function output = fn_zernike_polar(Rho, Theta, varargin)

    % detecting whether the one- or two-index notation is used
    if nargin == 3
        % converting single-index Zernike polynomial to two-index notation
        [n, m]         = fn_zernike_index_conversion(varargin{1});
        
    elseif nargin == 4
        % two index validation
        n              = varargin{1};
        m              = varargin{2};        
        if (n < abs(m))
            error(['The second (scalar) argument must be smaller than '...
                   'the first.'])
        end
        if mod(n - abs(m),2)
            error(['The first input argument minus the absolute value '...
                   'of the second must be an even number'])
        end
    else    
        error('This function takes three or four input arguments.')
    end

    % calculating normalization factor
    if abs(m) == 0
        norm_factor    = sqrt(n + 1);
    else
        norm_factor    = sqrt(2 * (n + 1));
    end
    
    % evaluating angular factor
    if m >=0
        angular_factor = cos(m*Theta); 
    else
        angular_factor = sin(m*Theta);
    end
    
    % evaluating radial polynomial one monomial at a time
    radial_polynomial  = zeros(size(Rho));

    % evaluating the radial polynomial
    for s = 0 : (n-m)/2
       radial_polynomial   = radial_polynomial...
                           + (-1)^s * factorial(n-s) / factorial(s)...
                           / factorial((n+m)/2-s)    / factorial((n-m)/2-s)...
                           * Rho.^(n-2*s);
    end
    
% generating output    
output = norm_factor * radial_polynomial .* angular_factor;

