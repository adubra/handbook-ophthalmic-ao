%fn_sym_Zernike_Cartesian_Malacara symbolically evaluates the Zernike 
%   polynomial in Cartesian coordinates. The fundamentals of the method can
%   be found in Reference: M. Carpio and D. Malacara, "Closed Cartesian 
%                          representation of the Zernike polynomials," 
%                          Opt. Commun. 110 1994, Pages. 514-516.
%   Syntax:
%      Zernike_polynomial                                               ...
%          = fn_sym_Zernike_Cartesian_Malacara(radial_index,            ...
%                                              azimuthal_index,         ...
%                                              osa_normalization,       ...
%                                              x,                       ...
%                                              y)
% Vyas Akondi and Alfredo Dubra 2020

function Zernike_polynomial                                             ...
         = fn_sym_Zernike_Cartesian_Malacara(radial_index,              ...
                                             azimuthal_index,           ...
                                             osa_normalization,         ...
                                             x,                         ...
                                             y)

if osa_normalization                                         
    if abs(azimuthal_index) == 0

        norm_factor = sqrt(radial_index + 1);

    else

        norm_factor = sqrt(2 * (radial_index + 1));

    end
else
    norm_factor = 1;
end

n1 = (radial_index - abs(azimuthal_index))/2;

Zernike_polynomial = 0;

m  = azimuthal_index;

if m >= 0    
       
    for k = 0 : 1 : n1
        
        constant_term_k = factorial(n1+abs(m)+k)/factorial(n1-k);
        
        for v = 0 : 1 : k
            
           constant_term_v = 1/factorial(k-v)/factorial(v);
            
           q_min = ceil(v/2);
           q_max = floor((k + abs(m)+ v)/2);
            
           for q = q_min : 1 : q_max                
                Zernike_polynomial = Zernike_polynomial  +              ...
                                     constant_term_v*constant_term_k *  ...
                                     (-1)^(n1-k+v+q) /                  ...
                                     factorial(k+abs(m)-2*q+v)/         ...
                                     factorial(2*q-v) *                 ...
                                     x.^(2*k+abs(m)-2*q) * y.^(2*q);
                
           end
        end
    end
else
    
    for k = 0 : 1 : n1
        
        constant_term_k = factorial(n1+abs(m)+k)/factorial(n1-k);
        
        for v = 0 : 1 : k
            
            constant_term_v = 1/factorial(k-v)/factorial(v);
            
            q_min = ceil((v+1)/2);
            q_max = floor((k + abs(m)+ v + 1)/2);
           
            for q = q_min : 1 : q_max            
                            
                Zernike_polynomial = Zernike_polynomial  +              ...
                                     constant_term_k*constant_term_v*   ...
                                     (-1)^(n1-k+v+q-1) /                ...
                                     factorial(k+abs(m)-2*q+1+v)/       ...
                                     factorial(2*q-1-v) *               ...
                                     x.^(2*k+abs(m)-2*q+1) * y.^(2*q-1);
                
                
            end
        end
    end
end

Zernike_polynomial = Zernike_polynomial * norm_factor;