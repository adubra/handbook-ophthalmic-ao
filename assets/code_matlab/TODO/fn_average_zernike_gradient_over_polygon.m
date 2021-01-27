% FN_AVERAGE_ZERNIKE_GRADIENT_OVER_POLYGON calculates the average x- and
%      y-derivative of a Zernike polynomial over a number of polygons with
%      equal number of vertices (this condition is because the algorithm
%      was optimized for matrix operations).
%
%      The algorithm uses the formulae derived in the manuscript: "Average 
%      gradient of Zernike polynomials over polygons" by V. Akondi and A.
%      Dubra 2020 (submitted to Optics Express).
%
%      The syntax  is:
%     [average_x_derivative,                                            ...
%      average_y_derivative] = fn_average_zernike_gradient_over_polygon(...
%                                         radial_index,                 ...
%                                         azimuthal_index,              ...
%                                         sorted_vertices_row_coords,   ...
%                                         sorted_vertices_column_coords,...
%                                         normalization_factor);
%
%      where, radial_index the a non-negative integer radial index of the
%      Zernike polynomial, azimuthal_index is an integer with absolute 
%      value equal or smaller than the radial order and with its difference
%      being a multiple of two (integers), sorted_vertices_row_coords and
%      sorted_vertices_column_coords are 2-dimensional matrices in which
%      each row contains the vertices of one polygon, sorted counter-
%      clockwise. The normalization factor should be either 'N' for Noll's
%      normalization over the unit circle area, or 'B' for Born & Wolf's
%      normalization, in which the radial polynomial of the Zernike has
%      unit amplitude at the boundary of the unit circle.
%
%      NOTE 1: the formulae used here assume that the polygons are 
%      connected and have no holes (i.e., have a continuous perimeter).
%
%      V. Akondi and A. Dubra (adubra@stanford.edu) 2020.

function [average_gradients_x, average_gradients_y]                     ...
                            = fn_average_zernike_gradient_over_polygon( ...
                                          radial_index,                 ...
                                          azimuthal_index,              ...
                                          sorted_vertices_row_coords,   ...
                                          sorted_vertices_column_coords,...
                                          normalization_factor)

                                      
% Hard-coding maximum factorial value to trigger the use of more than the
% default 15 digit precision.
max_factorial_input    = 22;

% Taking absolute value of the azimuthal index
mod_m                  = abs(azimuthal_index);

% Calculating auxiliary integer variable n_prime
n_prime                = (radial_index - mod_m)/2;

% getting the number of poygons and vertices
[n_polygons, n_vertices] = size(sorted_vertices_row_coords);

% Initializing average Zernike x- and y-derivatives
average_gradients_x    = zeros(n_polygons, 1);
average_gradients_y    = zeros(n_polygons, 1);

% creating auxiliary function for cyclic indexing
wrap_q                 = @(x) (1 + mod(x - 1, n_vertices));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: add an if statement to do VPA to increase precision for the
%       combination functions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Note that for simplicity, we calculate the average x- and y-gradients for
% all polygon segments, even when their integral is zero (i.e., zero x-
% gradient for horizontal segments and zero y-gradients for vertical
% segments.

% Summing over all polygon segments
for q = 1 : n_vertices

    % Initializing auxiliary variables
    k_index_summed_y           = zeros(n_polygons, 1);
    k_index_summed_x           = zeros(n_polygons, 1);

    for k = 0 : n_prime

        % Initializing auxiliary variables
        v_index_summed_y       = zeros(n_polygons, 1);
        v_index_summed_x       = zeros(n_polygons, 1);

        for v = 0 : k

            % calculating sum limits
            if azimuthal_index >= 0
                p_min          = ceil(v / 2);
                p_max          = floor((k + mod_m + v) / 2);
            elseif azimuthal_index < 0
                p_min          = ceil((v + 1) / 2);
                p_max          = floor((k + mod_m + v + 1) / 2);
            end

            % Initializing auxiliary variables
            p_index_summed_y   = zeros(n_polygons, 1);
            p_index_summed_x   = zeros(n_polygons, 1);               

            for p = p_min : p_max
                if azimuthal_index >= 0
                    
                    % trying to stay accurate beyond 15 digits
                    if max_factorial_input < k + mod_m
                        temp_y = nchoosek(vpa(k + mod_m), vpa(2*p - v));
                    else                        
                        temp_y = nchoosek(    k + mod_m,      2*p - v);
                    end                         
                         
                    p_index_summed_y =                                  ...
                        p_index_summed_y                                ...
                             + temp_y * (-1)^(n_prime - k + v + p)               ...
                             / (2*p + 1)                                ...
                             *  sorted_vertices_column_coords(:, q          ).^(2*k + mod_m - 2*p)    ...
                            .* (sorted_vertices_row_coords(   :, wrap_q(q+1)).^(2*p + 1)              ...
                             -  sorted_vertices_row_coords(   :, q          ).^(2*p + 1));

                    p_index_summed_x =                                  ...
                        p_index_summed_x                                ...
                             + temp_y * (-1)^(n_prime - k + v + p)      ...
                             / (2*k+mod_m - 2*p + 1)                    ...
                             *  sorted_vertices_row_coords(   :, q            ).^(2*p)                  ...
                            .* (sorted_vertices_column_coords(:, wrap_q(q + 1)).^(2*k + mod_m - 2*p + 1)...
                             -  sorted_vertices_column_coords(:, q            ).^(2*k + mod_m - 2*p + 1));
                         

                elseif azimuthal_index < 0
                    
                    % trying to stay accurate beyond 15 digits
                    if max_factorial_input < k + mod_m                      
                        temp_x = nchoosek(vpa(k + mod_m), vpa(2*p -1 - v));
                    else
                        temp_x = nchoosek(    k + mod_m,      2*p -1 - v);
                    end
                    
                    p_index_summed_y =                                  ...
                        p_index_summed_y                                ...
                             + temp_x * (-1)^(n_prime-k+v+p-1)          ...
                             / (2*p)                                    ...
                             *  sorted_vertices_column_coords(:, q          ).^(2*k + mod_m - 2*p + 1)...
                            .* (sorted_vertices_row_coords(   :, wrap_q(q+1)).^(2*p)                  ...
                             -  sorted_vertices_row_coords(   :, q          ).^(2*p));

                    p_index_summed_x =                                  ...
                        p_index_summed_x                                ...
                             + temp_x * (-1)^(n_prime-k+v+p-1)          ...
                             / (2*k + mod_m - 2*p + 2)                  ...
                             *  sorted_vertices_row_coords(   :, q            ).^(2*p - 1)              ...
                            .* (sorted_vertices_column_coords(:, wrap_q(q + 1)).^(2*k + mod_m - 2*p + 2)...
                             -  sorted_vertices_column_coords(:, q            ).^(2*k + mod_m - 2*p + 2));                
                
                end                    
            end
            v_index_summed_y = v_index_summed_y                         ...
                             + p_index_summed_y * nchoosek(k, v);
            v_index_summed_x = v_index_summed_x                         ...
                             + p_index_summed_x * nchoosek(k, v);
        end
        k_index_summed_y     = k_index_summed_y                         ...
                             + v_index_summed_y * nchoosek(n_prime, k)  ...
                             * nchoosek(n_prime + mod_m + k, n_prime);
        k_index_summed_x     = k_index_summed_x                         ...
                             + v_index_summed_x * nchoosek(n_prime, k)  ...
                             * nchoosek(n_prime + mod_m + k, n_prime);                         
    end
    average_gradients_x      = average_gradients_x + k_index_summed_y;
    average_gradients_y      = average_gradients_y + k_index_summed_x;
end

% polygon area formula given (sorted) vertices coordinates
% See https://www.mathopenref.com/coordpolygonarea.html,
% https://www.geeksforgeeks.org/area-of-a-polygon-with-given-n-ordered-vertices/
% https://en.wikipedia.org/wiki/Shoelace_formula
areas  = abs(sum(sorted_vertices_column_coords(:, 1 : n_vertices) .*     ...
                 sorted_vertices_row_coords(   :, wrap_q(2:n_vertices+1))...
               - sorted_vertices_row_coords(   :, 1 : n_vertices) .*     ...
                 sorted_vertices_column_coords(:, wrap_q(2:n_vertices+1))...
               , 2))/2;

% Evaluating normalization factor
if normalization_factor == 'N'
    if mod_m == 0
        norm_factor          = sqrt(2 * (radial_index + 1)/2);
    else
        norm_factor          = sqrt(2 * (radial_index + 1));
    end
else
    norm_factor              = 1;
end

% Dividing gradients by polygon area and scaling with normalization factor
average_gradients_x =   norm_factor * average_gradients_x ./ areas;
average_gradients_y = - norm_factor * average_gradients_y ./ areas;




