/*
 * js file used for iCrowd client application
 **/

(function($) {
    /************************ Public functions ************************/
    $.icrowd = {

        init: function(){
            __initView();
            __initFeedback();
        },

        updateCursorMove: function(x,y) {
            // feedback f = range -1 (i hate it) to 0 (indifferent) to +1 (i love it)
            var f = ( ( x / $(window).width ) - .5 ) * 2;
            // intensity from 0 (indifferent) to 1 (intense)
            var i = 1 - ( y / $(window).height );
            __updateFeedback(f,i);
        }

    };

    /************************ Private functions ************************/

    // view initialization
    function __initView() {

    }

    // view update
    function __updateView(f,i) {
        console.log('will update view to f=' + f + ' i=' + i);
        var green = i (f+1)/2;
        var red = 1-green;
        red *= i;
        green *= i;
        // TODO: change the color of DIV#mainColorBlock to color specified by red and green at intensity i
    }

    // feedback initialization
    function __initFeedback() {
        $(document).mousemove(function(e){
            $.icrowd.updateCursorMove(e.pageX,e.pageY)
        });
    }

    // feedback update
    function __updateFeedback(f,i) {
        // TODO: send grain of data to host
        __updateView(f,i);
    }

})(jQuery);
