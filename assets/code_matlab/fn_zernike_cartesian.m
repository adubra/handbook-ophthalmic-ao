% FN_ZERNIKE_CARTESIAN evaluates a desired Zernike polynomial at desired
%              locations expressed in Cartesian coordinates. The polynomial
%              is normalized according to the OSA Standards for reporting
%              the optical aberrations of eyes
%              (https://doi.org/10.1364/VSIA.2000.SuC1), and its order is
%              specified using either the one- or two-index notation
%              promoted by the same standard.
%              The syntax for using this function with the two-index
%              notation is
%
%                  Z = fn_zernike_cartesian(X, Y, n, m);
%
%              where the scalars n and m are radial and azimuthal indices
%              of the polynomial to be evaluated at the points with
%              Cartesian coordinates in the matrices X and Y. Similarly, 
%              the syntax for evaluating a polynomial using the one-index
%              notation is
%
%                  Z = fn_zernike_cartesian(X, Y, j);
%
%              where the scalar j is the polynomial order. 
%              The algorithm used here is based on the article by M. Carpio
%              and D. Malacara, "Closed Cartesian representation of the
%              Zernike polynomials," Opt. Commun. 110 1994, Pages. 514-516
%              (https://doi.org/10.1016/0030-4018(94)90241-0). This
%              implementation avoids the conversion to polar coordinates
%              required for direct implementation of the Zernike polynomial
%              definition as the product of a radial and an azimuthal
%              polynomial.
%              The accuracy of this function is limited among other factors
%              by the factorial function which might not be accurate for
%              numbers much grater than 20.
%              
%              Vyas Akondi and Alfredo Dubra, Stanford, 2021.

function Z = fn_zernike_cartesian(X, Y, varargin)

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

    % evaluating polynomial one monomial at a time
    Z                  = 0;
    n_1                = (n - abs(m))/2;

    for k = 0 : 1 : n_1
        constant_term_k = factorial(n_1+abs(m)+k)/factorial(n_1-k);
        for v = 0 : 1 : k
           constant_term_v = 1/factorial(k-v)/factorial(v);
           if m >= 0
               q_min  = ceil(v/2);
               q_max  = floor((k + abs(m)+ v)/2);
               for q = q_min : 1 : q_max                
                    Z  = Z  + constant_term_v*constant_term_k *  ...
                              (-1)^(n_1 - k + v + q) /           ...
                              factorial(k+abs(m)-2*q + v)/       ...
                              factorial(2*q - v) *               ...
                              X.^(2*k+abs(m)-2*q) .* Y.^(2*q);
               end
           else
                q_min  = ceil((v+1)/2);
                q_max  = floor((k + abs(m)+ v + 1)/2);
                for q = q_min : 1 : q_max            
                    Z  = Z  + constant_term_k*constant_term_v*   ...
                              (-1)^(n_1 - k + v + q - 1) /       ...
                              factorial(k+abs(m)-2*q + 1 + v)/   ...
                              factorial(2*q - 1 - v) *           ...
                              X.^(2*k+abs(m)-2*q+1) .* Y.^(2*q-1);
                end
           end
        end
    end    
    
    % returning normalized polynomial evaluated at the desired coordinates
    Z  = Z * norm_factor;
