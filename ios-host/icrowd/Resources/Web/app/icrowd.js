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
//            __initFeedback();
            __initUser();
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
        userId:function () {
            return __userId;
        },

        // user send hello from form
        userHelloSend:function (name,age,gender) {
            __userHelloSend(name,age,gender);
        },

        // user hello receive response
        userHelloRecv:function (p) {
            // TODO: parse payload and save user id
            console.log("received payload for user hello response",p);
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
            __feedbackSendToHost();
        }

    };

    /************************ Private functions ************************/

        // view initialization
    function __initView() {
        $('#helloSubmit').click(function(e) {
            $.icrowd.userHelloSend(
                $('#userName').val(),
                $('#userAge').val(),
                $('#userGender').val()
            )
        });
    }

    // view update
    function __updateView(f, i) {
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

    var __userId;
    // user initialization
    function __initUser() {
        // TODO: set user id assign from host during hello method
        __userId = 5;
    }

    // send current feedback state to host
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
                $.icrowd.userHelloRecv(data);
            });
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
        setInterval(function () {
            $.icrowd.feedbackSendToHost();
        }, 1000);
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
        // update the view
        __updateView(f, i);
    }

    // track if user is currently touching screen
    var __feedbackIsTouching = false;

    function __feedbackTouch(f) {
        __feedbackIsTouching = true;
    }

    function __feedbackExit(f) {
        __feedbackIsTouching = false;
    }

    // track current feedback state
    var __feedbackCurrentFeeling = 0;
    var __feedbackCurrentIntensity = 0;

    function __storeFeedback(f, i) {
        __feedbackCurrentFeeling = f;
        __feedbackCurrentIntensity = i;
    }

    // send current feedback state to host
    function __feedbackSendToHost() {
        $.ajax({
            type:'POST',
            url:__baseUrl() + 'grain',
            data:{
                u:__userId,
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