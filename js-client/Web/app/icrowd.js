/*
 * iCrowd
 * Nick Kaye & Chris Luken
 * Mobile Dev Camp NYC 2012
 **/

(function ($) {
    /************************ Public functions ************************/
    $.icrowd = {

        // initialize
        init:function () {
            __initView();
        },

        // handle mouse motion
        touchDidMove:function (e) {
            // if not currently touching, do nothing
            if (!__feedbackIsTouching) return;
            __feedbackUpdate(e.pageX, e.pageY);
        },

        // handle mouse touch / exit
        touchDidStart:function (e) {
            __feedbackUpdate(e.pageX, e.pageY);
            __feedbackTouch();
        },
        touchDidStop:function (e) {
            __feedbackExit();
        },

        // user
        userIdx:function () {
            return __userIdx;
        },

        // user send hello from form
        userHelloSend:function (name,age,gender) {
            __userHelloSend(name,age,gender);
        },

        // user hello receive response
        userHelloRecv:function (p) {
            __userHelloRecv(p);
        },

        // report if feedback is touching
        feedbackIsTouching:function () {
            return __feedbackIsTouching;
        },

        // report current feedback
        feedback:function () {
            return {
                feeling:__feedbackCurrentFeeling,
                intensity:__feedbackCurrentIntensity
            }
        },

        // trigger send feedback to host
        feedbackSendToHost:function () {
            __transmissionSendToHost();
        }

    };

    /************************ Private functions ************************/

        // view initialization
    function __initView() {
        /*
        $('#mainColorBlock').width($(window).width()).height($(window).height());
        $('#mainTouchArea').width($(window).width()).height($(window).height());
        $('#helloForm').width($(window).width()).height($(window).height());
        */
        $('#helloSubmit').click(function(e) {
            $.icrowd.userHelloSend(
                $('#userName').val(),
                $('#userAge').val(),
                $('#userGender').val()
            )
        });
    }

    // view update
    function __viewUpdate(f, i) {
        // algorithm One: linear A>B fade
        /*
         var green = (f + 1) / 2;
         var red = 1 - green;
         */
        // algorithm Two: center is full AB, edges fade to A< or >B
        var green = Math.min(1, f + 1);
        var red = Math.min(1, 1 - f);
        // change the color of DIV#mainColorBlock to color specified by red and green at intensity i
        var redHex = __hexTwoDigitFromRatio(red * i);
        var greenHex = __hexTwoDigitFromRatio(green * i);
        var colorstring = '#' + redHex + greenHex + '00';
        $("#mainColorBlock").css({
            backgroundColor:colorstring
        });
    }

    // view switch off hello form and show main control
    function __viewHelloDone() {
        $('#helloForm').remove();
        __initFeedback();
    }

    var __userIdx;
    var __userName;
    var __userAge;
    var __userGender;
    // user initialization
    function __initUser() {
    }

    // send hello new user to host
    function __userHelloSend(name,age,gender) {
        $.ajax({
            type:'POST',
            url:__baseUrl() + 'hello',
            data:{
                n:name,
                a:age,
                g:gender
            }
        }).done(function (data) {
                $.icrowd.userHelloRecv($.parseJSON(data));
            });
    }

    // recv new user assignment from host
    function __userHelloRecv(p) {
        console.log("trying to hello recv",p);
        __userIdx = p.user.idx;
        __userName = p.user.name
        __userAge = p.user.age;
        __userGender = p.user.gender;
        __viewHelloDone();
    }

    // feedback initialization
    var __feedbackInterval;

    function __initFeedback() {
        // bind function to handle mouse move
        $(document).mousemove(function (e) {
            $.icrowd.touchDidMove(e);
        });
        $(document).mousedown(function (e) {
            $.icrowd.touchDidStart(e);
        });
        $(document).mouseup(function (e) {
            $.icrowd.touchDidStop(e);
        });
        $(document).mouseleave(function (e) {
            $.icrowd.touchDidStop(e);
        });
        document.addEventListener('touchmove', function (e) {
            e.preventDefault();
            $.icrowd.touchDidMove(e.touches[0]);
        }, false);
        document.addEventListener('touchstart', function (e) {
            e.preventDefault();
            $.icrowd.touchDidStart(e.touches[0]);
        }, false);
        // RUN AN INTERVAL
        // to periodically send update to host
        setInterval(function () {
            $.icrowd.feedbackSendToHost();
        }, __transmissionIntervalMilliseconds);
    }

    // feedback update
    function __feedbackUpdate(x, y) {
        // feedback f = range -1 (i hate it) to 0 (indifferent) to +1 (i love it)
        var f = ( ( x / $(window).width() ) - .5 ) * 2;
        // intensity from 0 (indifferent) to 1 (intense)
        var i = 1 - ( y / $(window).height() );
//            console.log('x=' + x + ', y=' + y + ' in window w=' + $(window).width() + ', h=' + $(window).height()  + ' will update view to f=' + f + ', i=' + i);
        // send grain of data to host
        __storeFeedback(f, i);
        // turn on transmission if it isn't already
        __transmissionStart();
        // update the view
        __viewUpdate(f, i);
    }

    // track if user is currently touching screen
    var __feedbackIsTouching = false;

    function __feedbackTouch() {
        __feedbackIsTouching = true;
        __transmissionStart();
    }

    function __feedbackExit() {
        __feedbackIsTouching = false;
    }

    // track current feedback state
    var __feedbackCurrentFeeling = 0;
    var __feedbackCurrentIntensity = 0;

    function __storeFeedback(f, i) {
        __feedbackCurrentFeeling = f;
        __feedbackCurrentIntensity = i;
    }

    // interval of cycle, in milliseconds, to transmit data update to host
    var __transmissionIntervalMilliseconds = 700;

    // track if broadcast is active
    var __transmissionActive = false;

    function __transmissionStart() {
        __transmissionActive = true;
    }

    function __transmissionStop() {
        __transmissionActive = false;
    }

    // if the signal is active, send current feedback state to host
    function __transmissionSendToHost() {
        // if broadcast inactive, skip
        if (!__transmissionActive) return;
        __transmissionStop();
        $.ajax({
            type:'POST',
            url:__baseUrl() + 'grain',
            data:{
                u:__userIdx,
                f:__feedbackCurrentFeeling,
                i:__feedbackCurrentIntensity
            }
        });
    }

    // http
    function __baseUrl() {
        return 'http://' + document.location.hostname + ':' + document.location.port + '/';
    }

    // utilities
    function __hexTwoDigitFromRatio(r) {
        var hex = Math.floor(r * 255).toString(16);
        while (hex.length < 2) {
            hex = '0' + hex;
        }
        return hex;
    }

})(jQuery);
