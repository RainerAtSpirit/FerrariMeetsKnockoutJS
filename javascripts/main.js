/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:02
 */

requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl : 'javascripts',
    paths : {
        jquery : 'jquery.min',
        knockout : 'knockout-2.1.0',
        sammy : 'sammy-0.7.1.min',
        prettyDate : 'app/jquery.prettyDate',
        metrojs : 'app/MetroJs',
        app : 'app/app',
        helper : 'app/helper'
    },
    shim : {
        'prettyDate' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.prettyDate'
        },
        'metrojs' : {
            deps : ['jquery'],
            exports : 'jQuery.fn.metrojs'
        }
    }
});

require(['jquery', 'knockout', 'app', 'sammy', 'prettyDate', 'metrojs' ], function ($, ko) {

    //Things that happen on dom ready
    $(function () {
        var doBind = (typeof (window.bindAppBarKeyboard) == "undefined" || window.bindAppBarKeyboard);

        // apply regular slide universally unless .exclude class is applied
        // NOTE: The default options for each liveTile are being pulled from the 'data-' attributes
        $(".live-tile, .flip-list").not(".exclude").liveTile();

        // showing UTC date as prettyDate
        $('span.prettyDate').prettyDate({ isUTC : true });

    });
});