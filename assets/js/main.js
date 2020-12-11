$(document).ready(function(){
    $("figure img").on("contextmenu",function(e){
        return false;
   });
   $("figure img").mousedown(function(e){
    e.preventDefault()
    });
});