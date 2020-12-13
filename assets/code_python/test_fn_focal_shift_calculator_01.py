# Simple script to illustrate how to use fn_focal_shift_calculator
#
# Vyas Akondi and Alfredo Dubra 2020

import numpy as np
from matplotlib import pylab as plt

# importing custom module
from fn_focal_shift_calculator import *

# User input parameters, with all distances in units of meters
wavelength                     = 850e-9;
beam_diameter                  = 200e-6;
distance_to_geometric_focus    = np.arange(1,11) * 1e-3;

# calculating focal shifts for the input distances to the geometric focus
focal_shifts_Li                = fn_focal_shift_calculator(
                                            wavelength,
                                            beam_diameter,
                                            distance_to_geometric_focus,
                                            'Li')
focal_shifts_Sheppard_n_Torok  = fn_focal_shift_calculator(
                                            wavelength,
                                            beam_diameter,
                                            distance_to_geometric_focus,
                                            'Sheppard_and_Torok');

# plotting results
plt.figure(1)
plt.plot(1e3*distance_to_geometric_focus, 1e3*focal_shifts_Li,
         color     = 'b',
         marker    = 'o',
         linestyle = '-',
         label     = 'Li')
plt.plot(1e3*distance_to_geometric_focus, 1e3*focal_shifts_Sheppard_n_Torok,
         color     = 'r',
         marker    = 'o',
         linestyle = '-',
         label     = 'Sheppard & Török')
plt.xlabel('Distance to geometric focus (mm)')
plt.ylabel('Focal shift (mm)')
plt.legend(loc     = 'lower left')
plt.grid(True)
plt.show()
