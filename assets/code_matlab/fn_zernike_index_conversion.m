% FN_ZERNIKE_INDEX_CONVERSION converts between two notations of Zernike
%              polynomial indexing. 
%              One syntax is
%
%                  J = fn_zernike_index_conversion(N, M);
%
%              where the matrices N and M contain indices that correspond
%              to the radial and azimuthal zernike polynomial orders in the
%              Principles of optics book by M. Born and E. Wolf (any
%              edition) and J is a matrix with the corresponding
%              single-index notation promoted by the OSA Standards for
%              reporting the optical aberrations of eyes
%              (https://doi.org/10.1364/VSIA.2000.SuC1).
%              The alternative syntax, to perform the reverse index 
%              notation conversion is
%
%                  [N, M] = fn_zernike_index_conversion(J);
%
%              Vyas Akondi and Alfredo Dubra, Stanford, 2021.


function [out1, out2] = fn_zernike_index_conversion(arg1, arg2)

    % detecting whether one or two inputs have been provided
    if nargin == 1
        input_one_index_order   = arg1;
    elseif nargin == 2
        % validating input dimensions
        if size(arg1) == size(arg2)
            input_radial_order  = arg1;
            input_angular_order = arg2;
        else
            error('Input matrices have different dimensions.')
        end
    else    
        error('This function takes one or two input arguments.')
    end

    % finding maximun radial order for the lookup vector
    if nargin == 2
        n_max = max(max(input_radial_order));
    else
        one_index_max = max(max(input_one_index_order));
        if one_index_max == 0
            n_max = 0 ;
        else
            n_max = ceil( sqrt(2 * one_index_max) - 1 );
        end        
    end
    
    % generating lookup vectors    
    z_n = 0;
    z_m = 0;
    for i = 1 : n_max        
        z_n = [z_n , ones(1,i+1)*i];
        for j = -i : 2 : i
            z_m = [z_m , j];
        end        
    end        
    
    % converting from one notation to the other
    [ rows , columns ] = size( arg1 );

    if nargin == 1
        % from one index to two
        out1 = zeros(size(arg1));
        out2 = zeros(size(arg1));
        
        for i = 1 : rows
            for j = 1 : columns
                
                out1(i,j) = z_n(input_one_index_order(i,j) + 1);
                out2(i,j) = z_m(input_one_index_order(i,j) + 1);
            end
        end        
    else
        % from two indexes to one
        out1 = zeros(size(arg1));
        for i = 1 : rows
            for j = 1 : columns
                aux_n     = find(z_n == input_radial_order (i,j));
                aux_m     = find(z_m == input_angular_order(i,j));
                out1(i,j) = intersect(aux_n, aux_m) - 1;
            end
        end
    end