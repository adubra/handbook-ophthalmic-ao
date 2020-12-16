// Inputs: 
// - elementSelector (string) use to select elements on the page that need to be numbered, 
//   e.g. ".post img", "figure"
// - elementLabel (string) use to specify how the element number will be labeled, 
//   e.g. "Image"
//
// Iterate each element on the page based on the selector and add a data attribute specifying 
// it's label sequence identifier, e.g. "Image 1". 
function autonumberByElement(elementSelector, elementLabel){
    var elements = $(elementSelector);
    $.each(elements, function(index, value){
        $(value).attr('data-sequence', elementLabel + " " + (index + 1));
    })
}

// Wherever there are labels that have a "for" attribute specifying an "id", populate that 
// label with the text of the element sequence identifier, e.g. Image 1. 
function renderLabels(){
    var labels = $('label[for!=""]');
    $.each(labels, function(index, value){
        var id = $(value).attr('for');
        if (id){
            var label = $('#' + id).data('sequence');
            if (label){
                $(this).text(label);
            }
        }
    });
}