% Simple script to illustrate how to use fn_focal_shift_calculator
%
% Vyas Akondi and Alfredo Dubra 2020


% User input parameters, with all distances in units of meters
wavelength                     = 850e-9;
beam_diameter                  = 200e-6;
distance_to_geometric_focus    = (1 : 10) * 1e-3;

% calculating focal shifts for the input distances to the geometric focus
focal_shifts_Li                = fn_focal_shift_calculator(...
                                            wavelength,...
                                            beam_diameter,...
                                            distance_to_geometric_focus,...
                                            'Li');
focal_shifts_Sheppard_n_Torok  = fn_focal_shift_calculator(...
                                            wavelength,...
                                            beam_diameter,...
                                            distance_to_geometric_focus,...
                                            'Sheppard_and_Torok');

% plotting results
figure(1), clf
plot(1e3*distance_to_geometric_focus, 1e3*focal_shifts_Li, 'bo-',...
     1e3*distance_to_geometric_focus, 1e3*focal_shifts_Sheppard_n_Torok, 'ro-')
axis square
xlabel('Distance to geometric focus (mm)')
ylabel('Focal shift (mm)')
legend('Li', 'Sheppard & Török', 'Location', 'southwest')
legend boxoff
grid on
zoom on
