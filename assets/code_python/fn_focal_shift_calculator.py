import warnings
import numpy as np

def fn_focal_shift_calculator(wavelength,
                              beam_diameter,
                              distance_to_geometric_focus,
                              algorithm):

    """FOCAL_SHIFT_CALCULATOR returns the separation between the
       diffraction and geometric focus in a converging beam free of
       aberrations using the approximate formulae derived by either Li
       (https://doi.org/10.1364/JOSA.72.000770) or Sheppard & Török
       (https://doi.org/10.1364/JOSAA.20.002156). The function always
       returns negative values, as the diffraction focus (point of maximum
       intensity) is shifted against the direction of the wavefront
       propagation.
       The function syntax is
       
            focal_shift = fn_focal_shift_calculator(
                                            wavelength,
                                            beam_diameter,
                                            distance_to_geometric_focus,
                                            algorithm)

       where wavelength is the wavelength of light, beam_diameter of the
       converging beam and distance_to_geometric_focus are relative to any
       plane orthogonal to the beam direction of propagation. All three
       distances and the output are in units of meters and could be
       scalars, 1D or 2D matrices. The last input should be a string that
       starts with the letters "L" or "S" to indicate the use of the Li or
       the Sheppard and Török algorithm.

       Vyas Akondi and Alfredo Dubra 2020.
    """
                                              
    # calculating the beam Fresnel number
    N                  = (beam_diameter / 2)**2 \
                       / (wavelength * distance_to_geometric_focus)

    # calculating F-number
    F                  = distance_to_geometric_focus / beam_diameter

    # converting input algorithm string to lowercase
    algorithm          = algorithm.lower()

    # algorithm selection
    if algorithm[0] == 'l':

        # coping with N being a scalar or an iterable
        if np.isscalar(N):
            N_min = N
        else:
            N_min = np.min(N)
            
        # TODO: cope with both scalars and numpy arrays
        if N_min < 0.5:
            warnings.warn('One or more of the calculated focal shift values' +\
                          ' is outside the valid range of the approximation' +\
                          ' N > 0.5')

        # coping with F being a scalar or an iterable
        if np.isscalar(F):
            F_min = F
        else:
            F_min = np.min(F)
            
        if F_min < 1.0:
            warnings.warn('One or more of the calculated focal shift values' +\
                          ' is outside the valid range of the approximation' +\
                          'F >= 1.')

        focal_shift    = -12 * distance_to_geometric_focus\
                       * (1 + 1/(8 * F**2)) / (np.pi**2 * N**2)\
                       * (1-np.exp(-(np.pi**2 * N**2) / (12*(1+1/(8*F**2)))\
                       / (1+N*(1-1/(16*F**2)))))
        
    elif algorithm[0] == 's':
        
        # TODO: Vyas, what are the approximation limitations for this formula?
        alpha          = np.arcsin(beam_diameter / distance_to_geometric_focus / 2)

        focal_shift    = - distance_to_geometric_focus \
                       / (np.cos(alpha/2)**2 + (np.pi**2*N**2/12) * 1/np.cos(alpha/2)**2)
    else:
        raise Exception('The algorithm string must start with "L" for Li and' +\
                        '"S" for Sheppard and Török')
                                            
    return focal_shift
