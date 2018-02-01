$(function () {
    $('[data-toggle="popover"]').popover({
        container: 'body'
    });

    $('[data-provider="summernote"]').each(function() {
        $(this).summernote({
            height: 300
        });
    });

});