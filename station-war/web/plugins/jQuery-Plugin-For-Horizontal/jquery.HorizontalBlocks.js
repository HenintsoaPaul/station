/*
 * jQuery HorizontalBlocks v1.0 -
 *
 * Open source under the BSD License.
 *
 * Copyright © 2013 Kakurezatou
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 *
 * Neither the name of the author nor the names of contributors may be used to endorse
 * or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

;
(function($) {
    $.fn.HorizontalBlocks = function(config) {
        var param = {
            parentBox: "#box",
            block: "#blocks li",
            firstBlock: 1,
            scrollOption: "swing",
            scrollSpeed: "normal",
            horizontalMenu: "nav a",
            nextId: "#nextBlock",
            prevId: "#prevBlock"
        };
        var wh;
        var ww;
        var TpageX;
        var TpageY;
        var Xpos;
        var options = $.extend(param, config);
        var mobile = false;
        var curpage = options.firstBlock - 1;
        var ag = navigator.userAgent;
        if (ag.search(/iPhone/) != -1 || ag.search(/iPad/) != -1 || ag.search(/iPod/) != -1 || ag.search(/Android/) != -1) {
            mobile = true;
            if (ag.search(/iPhone/) != -1 || ag.search(/Android/) != -1) {
                // $('meta[name=viewport]').remove();
                // var meta = document.createElement('meta');
                // meta.setAttribute('name', 'viewport');
                // meta.setAttribute('content', '');
                // document.getElementsByTagName('head')[0].appendChild(meta);
            };
        }
        return this.each(function(i) {
            $(window).load(function() {
                wh = new $(window).height();
                ww = new $(window).width();
                $(options.block).each(function() {
                    $(this).css({
                        "height": wh + "px",
                        "width": ww + "px"
                    });
                });
                curnum = $('.current').index();
                if (mobile == false) {
                    $(options.parentBox).css({
                        "width": ww * $(options.block).length + "px",
                        "margin-left": -curnum * ww + "px"
                    });
                } else {
                    $(options.parentBox).css({
                        "width": ww * $(options.block).length + "px",
                        "-webkit-transform": "translate3d(" + -ww * curnum + "px,0,0)"
                    });
                };
            });

            // adapt css
            $(options.block).css({
                "overflow": "visible",
                "float": "left",
                "list-style-type": "none",
                "position": "relative"
            });
            $(options.block).eq(options.firstBlock - 1).addClass("current");
            $(options.horizontalMenu).eq(options.firstBlock - 1).addClass("menuCurrent").css({
                "z-index": 1000
            });
            $(options.nextId).css({
                "z-index": 1000
            });
            $(options.prevId).css({
                "z-index": 1000
            });
            $("body").css({
                "overflow": "hidden"
            });

            if (mobile == true) {
                $(options.parentBox).css({
                    "overflow": "hidden",
                    "width": ww * $(options.block).length + "px",
                    "-webkit-transform": "translate3d(" + -ww * (options.firstBlock - 1) + "px,0,0)",
                    "-webkit-transition-duration": ".4s",
                    "-webkit-transition-timing-function": "ease",
                    "-webkit-transform-style": "preserve-3d"
                });
            } else {
                $(options.parentBox).css({
                    "overflow": "hidden",
                    "margin-left": -ww * (options.firstBlock - 1) + "px",
                    "width": ww * $(options.block).length + "px"
                });
            };

            //Resize Window Function
            $(window).resize(function() {
                wh = new $(window).height();
                ww = new $(window).width();
                $(options.block).each(function() {
                    $(this).css({
                        "height": wh + "px",
                        "width": ww + "px"
                    });
                });
                var curnum = $('.current').index();
                if (mobile == false) {
                    $(options.parentBox).css({
                        "width": ww * $(options.block).length + "px",
                        "margin-left": -curnum * ww + "px"
                    });
                } else {
                    $(options.parentBox).css({
                        "width": ww * $(options.block).length + "px",
                        "-webkit-transform": "translate3d(" + -ww * curnum + "px,0,0)"
                    });
                };
            });

            //Next & Prev Function
            var n_func = function() {
                    if ($(options.block + ':last').hasClass('current')) {
                        return false;
                    } else {
                        if (mobile == false) {
                            $(options.parentBox + ":not(:animated)").animate({
                                "margin-left": "+=" + (-ww)
                            }, options.scrollSpeed, options.scrollOption, function() {
                                $('.current').next(options.block).addClass('current').end().removeClass('current');
                                $('.menuCurrent').next(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                            });
                        } else {
                            curnum = $('.current').index();
                            $(options.parentBox).css({
                                "-webkit-transform": "translate3d(" + -ww * (curnum + 1) + "px,0,0)"
                            });
                            $('.current').next(options.block).addClass('current').end().removeClass('current');
                            $('.menuCurrent').next(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                        };
                    };
                };

            var p_func = function() {
                    if ($(options.block + ':first').hasClass('current')) {
                        return false;
                    } else {
                        if (mobile == false) {
                            $(options.parentBox + ":not(:animated)").animate({
                                "margin-left": "-=" + (-ww)
                            }, options.scrollSpeed, options.scrollOption, function() {
                                $('.current').prev(options.block).addClass('current').end().removeClass('current');
                                $('.menuCurrent').prev(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                            });
                        } else {
                            curnum = $('.current').index();
                            $(options.parentBox).css({
                                "-webkit-transform": "translate3d(" + -ww * (curnum - 1) + "px,0,0)"
                            });
                            $('.current').prev(options.block).addClass('current').end().removeClass('current');
                            $('.menuCurrent').prev(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                        };
                    };
                };

            //Nav Buttons
            $(options.nextId).click(function(e) {
                n_func();
                e.preventDefault();
            });

            $(options.prevId).click(function(e) {
                p_func();
                e.preventDefault();
            });

            //Press Key Event
            $('html').keydown(function(e) {
                switch (e.which) {
                case 39:
                    // Key→
                    n_func();
                    e.preventDefault();
                    break;

                case 37:
                    // Key←
                    p_func();
                    e.preventDefault();
                    break;

                case 38:
                    // Key↑
                    p_func();
                    break;

                case 40:
                    // Key↓
                    n_func();
                    break;
                };
            });



            //Mouse Wheel Event
            if (document.addEventListener) {
                document.addEventListener('touchmove', function(e) {
                    e.preventDefault();
                });
                document.addEventListener("mousewheel", function(e) {
                    MouseFunc(e, -(e.wheelDelta));
                });
                document.addEventListener("DOMMouseScroll", function(e) {
                    MouseFunc(e, e.detail);
                });
            } else if (document.attachEvent) {
                document.attachEvent("onmousewheel", function(e) {
                    MouseFunc(e, e.wheelDelta);
                });
            }

            function MouseFunc(e, delta) {
                if (navigator.userAgent.match(/Mac | PPC/)) {
                    if (delta < 0) {
                        n_func();
                    } else {
                        p_func();
                    };
                } else {
                    if (delta > 0) {
                        n_func();
                    } else {
                        p_func();
                    };
                };
            };

            //Menu Buttons Event
            $(options.horizontalMenu).click(function(e) {
                e.preventDefault();
                var par = $(this).parent();
                var navindex = $(options.horizontalMenu).index(this);
                //alert(navindex);
                if (mobile == false) {
                    $(options.parentBox + ':not(:animated)').animate({
                        "margin-left": -ww * navindex
                    }, options.scrollSpeed, options.scrollOption, function() {
                        $('.current').removeClass('current');
                        $('.menuCurrent').removeClass('menuCurrent');
                        $(options.block).eq(navindex).addClass("current");
                        $(options.horizontalMenu).eq(navindex).addClass("menuCurrent");
                    });
                } else {
                    curpage = navindex;
                    $(options.parentBox).css({
                        "-webkit-transform": "translate3d(" + -ww * curpage + "px,0,0)"
                    });
                    $('.current').removeClass('current');
                    $('.menuCurrent').removeClass('menuCurrent');
                    $(options.block).eq(navindex).addClass("current");
                    $(options.horizontalMenu).eq(navindex).addClass("menuCurrent");
                };
            });

            // Touch Events
            var navindexT;
            var sabun;
            var touch;
            var Xpos;
            $(options.parentBox).bind("touchstart", touchHandlerS);
            $(options.parentBox).bind("touchmove", touchHandlerM);
            $(options.parentBox).bind("touchend", touchHandlerE);

            function touchHandlerS(e) {
                curnum = $('.current').index();
                TpageX = e.originalEvent.touches[0].pageX; // X 座標の位置
                // TpageY = e.changedTouches[0].pageY; // Y 座標の位置
                Xpos = TpageX;
                navindexT = -ww * curnum;
                wwT = $(window).width();
                //alert(navindexT);
            };

            function touchHandlerM(e) {
                e.preventDefault();
                TpageX = e.originalEvent.touches[0].pageX; // X 座標の位置
                // TpageY = e.changedTouches[0].pageY; // Y 座標の位置
                touch = Xpos - TpageX;
                sabun = navindexT - Xpos + TpageX;
                setTimeout(function() {
                    if (sabun > 0 && $(options.block + ':first').hasClass('current')) {
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + 0 + "px,0,0)"
                        });
                    } else if (touch > 0 && $(options.block + ':last').hasClass('current')) {
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + navindexT + "px,0,0)"
                        });
                    } else {
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + sabun + "px,0,0)"
                        });
                    };
                }, 0);
            };

            function touchHandlerE(e) {
                e.preventDefault();
                touch = Xpos - TpageX;
                hanbun = Math.abs(touch);
                setTimeout(function() {
                    if (hanbun > (ww / 3) && touch > 0 && !($(options.block + ':last').hasClass('current'))) {
                        //alert("next touch");
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + -ww * (curnum + 1) + "px,0,0)"
                        });
                        $('.current').next(options.block).addClass('current').end().removeClass('current');
                        $('.menuCurrent').next(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                    } else if (hanbun > (ww / 3) && touch < 0 && !($(options.block + ':first').hasClass('current'))) {
                        //alert("prev touch");
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + -ww * (curnum - 1) + "px,0,0)"
                        });
                        $('.current').prev(options.block).addClass('current').end().removeClass('current');
                        $('.menuCurrent').prev(options.horizontalMenu).addClass('menuCurrent').end().removeClass('menuCurrent');
                    } else {
                        $(options.parentBox).css({
                            "-webkit-transform": "translate3d(" + navindexT + "px,0,0)"
                        });
                    };
                }, 0);
            };

        });
    };

})(jQuery);