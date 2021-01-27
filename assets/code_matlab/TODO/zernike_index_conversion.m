% ZERNIKE_INDEX_CONVERSION  converts from Born & Wolf two index notation for Zernike
%                           polynomials to and from the one index notation described in the
%                           Standards for Reporting the Optical Aberrations of Eyes by
%                           L.N. Thibos, R.A. Applegate, J.T. Schwiegerling, R. Webb and VSIA
%                           Standars Taskforce Members (OSA 2000). The syntax is
%
%                           J = ZERNIKE_INDEX_CONVERSION( N , M )
%
%                           where N and M are matrices containing the radial and angular orders
%                           to be converted to the one index notation.
%
%                           [n,m] = ZERNIKE_INDEX_CONVERSION( J )
%
%                           where J is a matrix containing the single indices to be converted to
%                           the one index notation.
%
%                           The numbering in the one index notation starts at 0, and this is not
%                           the only disagreement between the one index notation from the OSA
%                           standard and Noll's one index notation.

function [ out1 , out2 ] = zernike_index_conversion( arg1 , arg2 )


% input size validation

    if     ( nargin == 1 )
    
        input_one_index_order    = arg1;
    
    elseif ( nargin == 2 )
    
        if ( size(arg1) == size(arg2) )
            
            input_radial_order  = arg1;
            input_angular_order = arg2;
            
        else
            error('the input matrices should be of equal dimensions')
        end

    else
    
        error('the number of input arguments should be one or two')
        
    end


% finding maximun radial order for the lookup vector
    
    if ( nargin == 2 )

        n_max = max(max(input_radial_order));
        
    else

        one_index_max = max(max(input_one_index_order));
        
        if ( one_index_max == 0 )
            n_max = 0 ;
        else
            n_max = ceil( sqrt(2 * one_index_max) - 1 );
        end
        
    end
    
% generating lookup vectors    
    
    z_n = [ 0 ] ;
    z_m = [ 0 ] ;

    for i = 1 : n_max,
        
        z_n = [ z_n , ones(1,i+1)*i ];
        
        for j = -i : 2 : i
        
            z_m = [ z_m , j ];
            
        end
        
    end
        
    n_zernikes = length(z_n);
   

% converting from one notation to the other

    [ rows , columns ] = size( arg1 );

    if ( nargin == 1)
        
        % from one index to two

        out1 = zeros(size(arg1));
        out2 = zeros(size(arg1));
        
        for i = 1 : rows
            for j = 1 : columns
                
                out1(i,j) = z_n( input_one_index_order(i,j) + 1 );
                out2(i,j) = z_m( input_one_index_order(i,j) + 1 );
            end
        end
        
    else

        % from two indexes to one
        
        out1 = zeros(size(arg1));        
        
        for i = 1 : rows
            for j = 1 : columns
                aux_n = find ( z_n == input_radial_order (i,j) );
                aux_m = find ( z_m == input_angular_order(i,j) );
                out1(i,j) = intersect(aux_n,aux_m) - 1;
            end
        end
    end
