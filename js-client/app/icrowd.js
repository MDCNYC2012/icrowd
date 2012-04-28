/*
 * js file used for iCrowd client application
 **/

(function($) {
    /************************ Public functions ************************/
    $.icrowd = {

        // initialize
        init: function(){
            __initView();
            __initFeedback();
        },

        // handle mouse motion
        mouseDidMove: function(e) {
            // if not currently touching, do nothing
            if (!__feedbackIsTouching) return;
            // stash ints of pageX, pageY
            var x = e.pageX.valueOf();
            var y = e.pageY.valueOf();
            // feedback f = range -1 (i hate it) to 0 (indifferent) to +1 (i love it)
            var f = ( ( x / $(window).width() ) - .5 ) * 2;
            // intensity from 0 (indifferent) to 1 (intense)
            var i = 1 - ( y / $(window).height() );
            // update feedback with f,i
            console.log('x=' + x + ', y=' + y + ' in window w=' + $(window).width() + ', h=' + $(window).height()  + ' will update view to f=' + f + ', i=' + i);
            __updateFeedback(f,i);
        },

        // handle mouse touch / exit
        mouseDidTouch:function(e) {
            __feedbackTouch();
        },
        mouseDidExit:function(e) {
            __feedbackExit();
        },

        // report if feedback is touching
        feedbackIsTouching : function() {
            return __feedbackIsTouching;
        }

    };

    /************************ Private functions ************************/

    // view initialization
    function __initView() {

    }

    // view update
    function __updateView(f,i) {
        var green = (f+1)/2;
        var red = 1-green;
        red *= i;
        green *= i;
        // TODO: change the color of DIV#mainColorBlock to color specified by red and green at intensity i
    }

    // feedback initialization
    function __initFeedback() {
        // bind function to handle mouse move
        $(document).mousemove(function(e){ $.icrowd.mouseDidMove(e); });
        $(document).mousedown(function(e){ $.icrowd.mouseDidTouch(e); });
        $(document).mouseup(function(e){ $.icrowd.mouseDidExit(e); });
        $(document).mouseleave(function(e){ $.icrowd.mouseDidExit(e); });
    }

    // feedback update
    function __updateFeedback(f,i) {
        // TODO: send grain of data to host
        __updateView(f,i);
    }

    // track if user is currently touching screen
    __feedbackIsTouching = false;
    function __feedbackTouch(f) {
        __feedbackIsTouching = true;
    }
    function __feedbackExit(f) {
        __feedbackIsTouching = false;
    }

})(jQuery);
