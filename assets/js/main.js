$(document).ready(function () {
    function ShowOrHideSideNav(){
        if (window.location.pathname == "/ophthalmic-ao-handbook/"){
            $('#colSidenav').addClass('d-none');
            $('#colContent').removeClass('col-lg-9');
            $('#breadcrumbHome').addClass('d-none');
        }
    };
    ShowOrHideSideNav();

});