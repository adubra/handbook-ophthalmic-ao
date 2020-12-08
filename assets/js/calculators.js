$(document).ready(function(){


$('#frmSampleCalculation1').submit(function(event){
    event.preventDefault();

    //Get form data
    var formData = new FormData($(this)[0]);
    var x = formData.get('X');
    var m = formData.get('M');

    //Do some validation here if you want
   
    //Do calculation
    var expression = "x^2 + (sqrt(m) * sin(x)) + (m * cos(x/2))"; 
    var result = math.compile(expression).evaluate({x: x, m: m});
    var userInput = {"x": x, "m": m};
    drawPlot(expression, result, userInput);
    $('#calcultionResult').val(result);
});


var chart = '';
function drawPlot(expression, result, userInput){
    try {
        const expr = math.compile(expression);

        // evaluate the expression repeatedly for different values of x
        var startRange = -10;
        var endRange = 10;
        if (result){
            var max = Math.round(result) * 2;
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
                dataset.data = yValuesIfM; //.push(yValuesIfM);
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