$(document).ready(function(){


$('#form_focal_shift_calculator').submit(function(event){
    event.preventDefault();

    // Getting form data in units of meter
    var formData                    = new FormData($(this)[0]);
    var distance_to_geometric_focus = 1e-3 * formData.get('distance_to_geometric_focus_mm');
    var beam_diameter               = 1e-3 * formData.get('beam_diameter_mm');
    var wavelength                  = 1e-9 * formData.get('wavelength_nm')

    // Calculating Fresnel number
    var N_string                    = "pow(a,2) / (lambda*z)"; 
    var N_value                     = math.compile("round(" + N_string  + ",n_digits)").evaluate(
                                            {z               : distance_to_geometric_focus,
                                             a               : beam_diameter/2,
                                             lambda          : wavelength,
                                             n_digits        : 3});
    
    // Calculating F-number
    var F_string                    = "z / (2*a)"; 
    var F_result                    = math.compile("round(" + F_string + ",n_digits)").evaluate(
                                            {z               : distance_to_geometric_focus,
                                             a               : beam_diameter/2,
                                             n_digits        : 3});
        
    // Focal shift calculation using Li's formula
    var focal_shift_Li_string       = "-12 * z * (1 + 1/(8 * pow(" + F_string + ",2))) / pow(pi*" +
                                      N_string + ",2) *" + " (1-exp(-pow(pi*" + N_string +
                                      ",2) /(12*(1+1/(8*pow(" + F_string + ",2)))) / (1+" +
                                      N_string + "*(1-1/(16*pow(" + F_string + ",2))))))";    
    var focal_shift_Li_value_mm = math.compile("round(1e3*" + focal_shift_Li_string + ",n_digits)").evaluate(
                                            {z               : distance_to_geometric_focus,
                                             a               : beam_diameter/2,
                                             lambda          : wavelength,
                                             n_digits        : 3});

    // Focal shift calculation using Sheppard and Török's formula
    var focal_shift_Sheppard_n_Torok        = "- z / (pow(cos(asin(a/z)/2),2) + (pow(pi*" + N_string +
                                              ",2)/12))*pow(sec(asin(a/z)/2),2)";
    var focal_shift_Sheppard_n_Torok_value_mm = math.compile("round(1e3*" + focal_shift_Sheppard_n_Torok +
                                              ",n_digits)").evaluate(
                                            {z               : distance_to_geometric_focus,
                                             a               : beam_diameter/2,
                                             lambda          : wavelength,
                                             n_digits        : 3});

    // focal shifts output in mm
    $('#Fresnel_number').val(N_value);
    $('#F_number').val(F_result);
    $('#Focal_shift_Li').val(focal_shift_Li_value_mm);
    $('#Focal_shift_Sheppard_n_Torok').val(focal_shift_Sheppard_n_Torok_value_mm);
});

//drawPlot(expression, result, userInput);
    
var chart = '';
function drawPlot(expression, result, userInput){
    try {
        const expr = math.compile(expression);

        // evaluate the expression repeatedly for different values of x
        var startRange = -10;
        var endRange = 10;
        if (result){
            var max = Math.round(userInput["x"]) * 2;
            startRange = - max;
            endRange = max;
        }
        const xValues = math.range(startRange, endRange + 1, 0.5).toArray()
        var mUserInput = userInput["m"];
        const yValuesIfM = xValues.map(function (x) {
            return {x, y: expr.evaluate({x: x, m: mUserInput})} 
        })


        // Create or update the chart using chart.js
        if (chart == ''){
            var ctx = document.getElementById('plot').getContext('2d');
            chart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'line',
                // The data for our dataset
                data: {
                    datasets: [{
                        label: expression,
                        data: yValuesIfM,
                        pointRadius: 0,
                        fill: false,
                        borderColor: ''
                    }
                ],
                },
                // Configuration options go here
                options: {
                    hover: {
                        mode: 'nearest',
                        intersect: true
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false,
                    },
                    scales:{
                        xAxes: [{
                            type: 'linear',
                            position: 'bottom',
                            ticks: {
                                min: startRange,
                                max: endRange
                            }
                        }]
                    }
                }
            });
        }
        else {
            chart.options.scales.xAxes[0] = { type: 'linear', position: 'bottom', ticks: {min: startRange, max: endRange}} ; 
            chart.data.labels.pop();
            chart.data.datasets.forEach((dataset) => {
                dataset.data.pop();
            });
            chart.data.labels.push(expression);
            chart.data.datasets.forEach((dataset) => {
                dataset.data = yValuesIfM;
            });
            
            chart.update(0);

        }
        

    }
    catch (err) {
        console.error(err)
        alert(err)
    }
}

});