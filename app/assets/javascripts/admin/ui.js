$(document).on('turbolinks:load', function(e) {
    $('[data-toggle="popover"]').popover({
        container: 'body'
    });

    $('[data-provider="summernote"]').each(function() {
        $(this).summernote({
            height: 300,
            toolbar: [
                ["main", ["undo", "redo"]],
                ["style", ["bold", "italic", "underline", "clear"]],
                ["font", ["strikethrough", "superscript", "subscript"]],
                ["para", ["ul", "ol", "paragraph"]],
                ["insert", ["link"]],
                ["misc", ["fullscreen"]],
                ["help"]
            ]
        });
    });

    $('[data-provider="datepicker"]').each(function() {
        $(this).datepicker();
    })
});