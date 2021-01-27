%FN_AVERAGE_WAVEFRONT_GRADIENT_QUADRILATERAL calculates the average x- and
%   y-gradients of Zernike polynomials over polygons, inscribed within a 
%   square grid of square-shaped lenlets with a 100% fill factor using the 
%   analytical formula derived in the following manuscript (under review):
%       V. Akondi and A. DUBRA, "Average gradient of Zernike polynomials
%       over polygons".
%
%   Syntax:
%   [average_gradients_x,                                               ...
%    average_gradients_y] = fn_average_wavefront_gradient_quadrilateral(...
%                                     radial_index,                     ...
%                                     azimuthal_index,                  ...
%                                     sorted_vertices_row_coords,       ...
%                                     sorted_vertices_column_coords,    ...
%                                     areas)
%   where, radial_index and azimuthal_index are the radial and azimuthal
%   indices of Zernike polynomials.
%   
%   sorted_vertices_row_coords and sorted_vertices_column_coords are the
%   row and column vertices of the square lenslets, sorted 
%   counterclockwise. The last element in these matrices should contain the
%   first element to complete the cycle. 
%   For example, for a square, we need 4 pairs of coordinates to calculate
%   the average gradients of Zernike polynomials.

function [average_gradients_x,                                          ...
          average_gradients_y]                                          ...
             = fn_average_wavefront_gradient_quadrilateral(             ...
                                      radial_index,                     ...
                                      azimuthal_index,                  ...
                                      sorted_vertices_row_coords,       ...
                                      sorted_vertices_column_coords,    ...
                                      areas)

% Evaluating the absolute value of the azimuthal index %%%%%%%%%%%%%%%%%%%%
mod_m                       = abs(azimuthal_index);

% Evaluating the normalization factor %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if mod_m == 0
    norm_factor             = sqrt(2 * (radial_index + 1)/2);
else
    norm_factor             = sqrt(2 * (radial_index + 1));
end

% Calculating n_prime %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_prime                     = (radial_index - mod_m)/2;

% Initializing the average x- and y- gradients of the Zernike polynomial %%
average_gradients_x         = 0;
average_gradients_y         = 0;

% Summing over all vertices %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for q = 1 : 4
    
    % This below condition checks if the x-coordinates are the same and
    % y-coordinates are different, or in other words, checks if the line is
    % parallel to the y-axis. The line parallel to the x-axis does not 
    % contribute to the average x-gradient of the Zernike polynomial.
    if (sorted_vertices_row_coords(1,1,q+1) ~=                          ...
        sorted_vertices_row_coords(1,1,q)) &&                           ...
       (sorted_vertices_column_coords(1,1,q+1) ==                       ...
        sorted_vertices_column_coords(1,1,q))
        
        % Evaluating x-gradient %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        k_index_summed_y = 0;
        
        for k = 0 : 1 : n_prime

            constant_term_k = nchoosek(n_prime, k) *                    ...
                              nchoosek(n_prime + mod_m + k, n_prime);
            
            v_index_summed_y = 0;            

            for v = 0 : 1 : k

                constant_term_v = nchoosek(k, v);

                if azimuthal_index >= 0
                    p_min = ceil(v/2);
                    p_max = floor((k+mod_m+v)/2);
                elseif azimuthal_index < 0
                    p_min = ceil((v+1)/2);
                    p_max = floor((k+mod_m+v+1)/2);
                end
                
                p_index_summed_y = 0;                

                for p = p_min : 1 : p_max

                    if azimuthal_index >= 0
                    
                        p_index_summed_y = p_index_summed_y             ...
                                           + (-1)^(n_prime-k+v+p)       ...
                                           / (2*p+1)                    ...
                                           * nchoosek(k+mod_m,2*p-v) *  ...
                                         (sorted_vertices_column_coords(...
                                                              :,:,  q)) ...
                                                     .^(2*k+mod_m-2*p)  ...
                                      .*((sorted_vertices_row_coords(   ...
                                            :,:,q+1)).^(2*p+1) -        ...
                                         (sorted_vertices_row_coords(   ...
                                            :,:,q  )).^(2*p+1));
                    elseif azimuthal_index < 0
                        p_index_summed_y = p_index_summed_y             ...
                                           + (-1)^(n_prime-k+v+p-1)     ...
                                           / (2*p)                      ...
                                           * nchoosek(k+mod_m,2*p-1-v) *...
                                         (sorted_vertices_column_coords(...
                                            :,:,  q)).^(2*k+mod_m-2*p+1)...
                                      .*((sorted_vertices_row_coords(   ...
                                            :,:,q+1)).^(2*p) -          ...
                                         (sorted_vertices_row_coords(   ...
                                            :,:,q  )).^(2*p));                        
                    end
                end
                v_index_summed_y = v_index_summed_y                     ...
                                   + p_index_summed_y * constant_term_v;
            end
            
            k_index_summed_y = k_index_summed_y                         ...
                               + v_index_summed_y * constant_term_k;
            
        end
                
        k_index_summed_y    = k_index_summed_y * norm_factor;        
        average_gradients_x = average_gradients_x + k_index_summed_y;
                         
    % This below condition checks if the x-coordinates are different and
    % y-coordinates are the same, or in other words, checks if the line is
    % parallel to the x-axis. The line parallel to the y-axis does not 
    % contribute to the average y-gradient of the Zernike polynomial.
    elseif (sorted_vertices_column_coords(1,1,q+1) ~=                   ...
            sorted_vertices_column_coords(1,1,q)) &&                    ...
           (sorted_vertices_row_coords(1,1,q+1) ==                      ...
            sorted_vertices_row_coords(1,1,q))
            
        % Evaluate the y-gradient of the Zernike polynomial
        k_index_summed_x = 0;
        
        for k = 0 : 1 : n_prime

            constant_term_k = nchoosek(n_prime, k) *                    ...
                              nchoosek(n_prime + mod_m + k, n_prime);
            
            v_index_summed_x = 0;

            for v = 0 : 1 : k

                constant_term_v = nchoosek(k, v);

                if azimuthal_index >= 0
                    p_min = ceil(v/2);
                    p_max = floor((k+mod_m+v)/2);
                elseif azimuthal_index < 0
                    p_min = ceil((v+1)/2);
                    p_max = floor((k+mod_m+v+1)/2);
                end
                
                p_index_summed_x = 0;                

                for p = p_min : 1 : p_max

                    if azimuthal_index >= 0
                    
                        p_index_summed_x = p_index_summed_x             ...
                                           + (-1)^(n_prime-k+v+p)       ...
                                           / (2*k+mod_m-2*p+1)          ...
                                           * nchoosek(k+mod_m,2*p-v) *  ...
                                         (sorted_vertices_row_coords(   ...
                                         :,:,q))  .^(2*p)               ...
                                      .*((sorted_vertices_column_coords(...
                                         :,:,q+1)).^(2*k+mod_m-2*p+1) - ...
                                         (sorted_vertices_column_coords(...
                                         :,:,q  )).^(2*k+mod_m-2*p+1));
                        
                    elseif azimuthal_index < 0
                        p_index_summed_x = p_index_summed_x             ...
                                           + (-1)^(n_prime-k+v+p-1)     ...
                                           / (2*k+mod_m-2*p+2)          ...
                                           * nchoosek(k+mod_m,2*p-1-v) *...
                                         (sorted_vertices_row_coords(   ...
                                         :,:,q))  .^(2*p-1)             ...
                                      .*((sorted_vertices_column_coords(...
                                         :,:,q+1)).^(2*k+mod_m-2*p+2) - ...
                                         (sorted_vertices_column_coords(...
                                         :,:,q  )).^(2*k+mod_m-2*p+2));
                    end
                end
                
                v_index_summed_x = v_index_summed_x                     ...
                                   + p_index_summed_x * constant_term_v;
                
            end
            
            k_index_summed_x = k_index_summed_x                         ...
                               + v_index_summed_x * constant_term_k;
            
        end
        
        k_index_summed_x    = k_index_summed_x * norm_factor;
        average_gradients_y = average_gradients_y + k_index_summed_x;
                
    end

end

% Dividing the average gradients with the area of the lenslets %%%%%%%%%%%%
average_gradients_x =   average_gradients_x ./ areas;
average_gradients_y = - average_gradients_y ./ areas;