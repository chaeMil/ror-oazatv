$(document).on('turbolinks:load', function () {
    const player = new Plyr('#plyr-player');
    player.play();

    var canSeek = false;
    var currentTime;

    player.on('ready', function (e) {
        canSeek = true;
        console.log('canSeek', canSeek);
    });

    setTimeout(function () {
        currentTime = player.currentTime;
        canSeek = false;
        console.log('canSeek', canSeek);
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
            console.log('canSeek', canSeek);
            if (canSeek) {
                player.currentTime = currentTime;
                canSeek = false;
                console.log('canSeek', canSeek);
            }
        });
    }, 10 * 1000);
});