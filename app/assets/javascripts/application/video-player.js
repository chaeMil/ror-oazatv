$(document).on('turbolinks:load', function () {
    const controls = `
<button type="button" class="plyr__control plyr__control--overlaid" data-plyr="play" aria-pressed="false">
    <svg role="presentation" focusable="false">
        <use xlink:href="#plyr-play"></use>
    </svg>
    <span class="plyr__sr-only">Play</span>
</button>
<div class="plyr__controls">
    <button type="button" class="plyr__control" data-plyr="rewind">
        <svg role="presentation"><use xlink:href="#plyr-rewind"></use></svg>
    </button>
    <button type="button" class="plyr__control" aria-pressed="false" aria-label="Play, {title}" data-plyr="play">
        <svg class="icon--pressed" role="presentation"><use xlink:href="#plyr-pause"></use></svg>
        <svg class="icon--not-pressed" role="presentation"><use xlink:href="#plyr-play"></use></svg>
    </button>
    <button type="button" class="plyr__control" data-plyr="fast-forward">
        <svg role="presentation"><use xlink:href="#plyr-fast-forward"></use></svg>
    </button>
    <div class="plyr__progress">
        <input data-plyr="seek" type="range" min="0" max="100" step="0.01" value="0" id="plyr-seek-{id}">
        <progress class="plyr__progress--buffer" min="0" max="100" value="0">% buffered</progress>
        <span role="tooltip" class="plyr__tooltip">00:00</span>
    </div>
    <div class="plyr__time plyr__time--current" aria-label="Current time">00:00</div>
    <div class="plyr__time plyr__time--duration" aria-label="Duration">00:00</div>
    <div class="plyr__volume">
        <input data-plyr="volume" type="range" min="0" max="1" step="0.05" value="1" autocomplete="off" id="plyr-volume-{id}">
    </div>
    <button type="button" class="plyr__control" aria-pressed="true" aria-label="Enable captions" data-plyr="captions">
        <svg class="icon--pressed" role="presentation"><use xlink:href="#plyr-captions-on"></use></svg>
        <svg class="icon--not-pressed" role="presentation"><use xlink:href="#plyr-captions-off"></use></svg>
    </button>
    <button id="plyr-settings-toggle" aria-haspopup="true" aria-controls="plyr-settings-{id}" aria-expanded="false" type="button" class="plyr__control" data-plyr="settings">
        <svg role="presentation" focusable="false">
            <use xlink:href="#plyr-settings"></use>
        </svg>
    </button>
    <button type="button" class="plyr__control" aria-pressed="false" aria-label="Enter fullscreen" data-plyr="fullscreen">
        <svg class="icon--pressed" role="presentation"><use xlink:href="#plyr-exit-fullscreen"></use></svg>
        <svg class="icon--not-pressed" role="presentation"><use xlink:href="#plyr-enter-fullscreen"></use></svg>
    </button>
</div>
`;

    // Setup the player
    const player = new Plyr('#plyr-player', {controls});
    let audio = $('#audio').get(0);

    $('#play-overlay').on('click', function (e) {
        e.stopPropagation();
        var overlay = $(this);
        if (overlay.hasClass('active')) {
            audio.play();
            setTimeout(function () {
                player.play();
                syncAudioWithVideo();
                $(overlay).removeClass('active');
            }, 500);
        }
    });

    let canSeek = false;
    let currentTime;
    let settingsButton = $('#plyr-settings-toggle');
    let settingsPopOver = settingsButton.popover({
        animation: true,
        title: 'Settings',
        placement: 'top',
        trigger: 'focus',
        container: '.plyr',
        html: true,
        content: '<h1>test</h1>'
    });

    function syncAudioWithVideo() {
        var syncFix = 0;
        switch (bowser.name.toLowerCase()) {
            case 'safari':
                syncFix = 0.3;
                break;
            case 'chrome':
                syncFix = 0.15;
                break;
            default:
                syncFix = 0.25;
        }

        var difference = Math.abs(player.currentTime - audio.currentTime + syncFix);
        console.log('difference', difference);
        audio.muted = false;
        if (difference > syncFix) {
            console.warn('syncAudioWithVideo', 'difference bigger than 0.1 (' + difference + '), syncing');
            audio.currentTime = player.currentTime + syncFix;
        }
    }

    player.on('ready', function (e) {
        canSeek = true;
        if (bowser.mobile) {
            setupMobilePlayer();
        }
    });

    player.on('play', function (e) {
        audio.play();
        syncAudioWithVideo();
    });

    player.on('pause', function (e) {
        audio.pause();
        syncAudioWithVideo();
    });

    player.on('seeking', function (e) {
        audio.pause();
    });

    player.on('seeked', function (e) {
        if (player.playing) {
            audio.play();
        }
        syncAudioWithVideo();
    });

    player.on('progress', function (e) {
        if (player.playing) {
            audio.play();
            syncAudioWithVideo();
        } else {
            audio.pause();
        }
    });

    player.on('controlshidden', function (e) {
        //hidePlayerSettings();
    });

    player.on('volumechange', function (e) {
        if (player.muted) {
            audio.volume = 0;
        } else {
            audio.volume = player.volume;
        }
    });

    function showPlayerSettings() {
        settingsPopOver.popover("show");
        player.toggleControls(true);
    }

    function hidePlayerSettings() {
        settingsPopOver.popover("hide");
    }

    function setupMobilePlayer() {
        $('.plyr__volume').hide();
    }

    settingsButton.on('click', function () {
        showPlayerSettings();
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