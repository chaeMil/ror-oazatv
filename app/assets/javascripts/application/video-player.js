$(document).on('turbolinks:load', function () {
    const player = new Plyr('#plyr-player');
    player.play();

    var canSeek = false;
    var currentTime;

    player.on('ready', function (e) {
        canSeek = true;
    });

    //just a test
    /*setTimeout(function () {
        currentTime = player.currentTime;
        canSeek = false;
        player.source = {
            type: 'video',
            title: 'Test',
            sources: [
                {
                    src: '/uploads/videos/100/04896809c412.mp4',
                    type: 'video/mp4'
                }
            ]
        };
        player.play();
        player.on('playing', function (e) {
            if (canSeek) {
                player.currentTime = currentTime;
                canSeek = false;
            }
        });
    }, 10 * 1000);*/
});