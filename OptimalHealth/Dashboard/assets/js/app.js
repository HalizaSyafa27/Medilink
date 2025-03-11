!function ($) {
    "use strict";

    var MainApp = function () {
        this.$body = $("body"),
            this.$wrapper = $("#wrapper"),
            this.$btnFullScreen = $("#btn-fullscreen"),
            this.$leftMenuButton = $('.button-menu-mobile'),
            this.$menuItem = $('.has_sub > a')
    };
        MainApp.prototype.Preloader = function () {
            $(window).load(function() {
                $('#status').fadeOut();
                $('#preloader').delay(350).fadeOut('slow');
                $('body').delay(350).css({
                    'overflow': 'visible'
                });
            });
        },
        MainApp.prototype.init = function () {
            //this.Preloader();
        },
        //init
        $.MainApp = new MainApp, $.MainApp.Constructor = MainApp
}(window.jQuery),

//initializing
    function ($) {
        "use strict";
        $.MainApp.init();
    }(window.jQuery);
    

//Disable cut copy paste
$('body').bind('cut copy paste', function (e) {
    e.preventDefault();
});

//Disable mouse right click
/* $("body").on("contextmenu",function(e){
    return false;
}); 
document.onkeydown = function(e) {
    if (e.ctrlKey && 
        (e.keyCode === 67 || 
         e.keyCode === 86 || 
         e.keyCode === 85 || 
         e.keyCode === 117)) {
        alert('This is not allowed');
        return false;
    } else {
        return true;
    }
};

$(document).keydown(function (event) {
    if (event.keyCode == 123) {
        return false;
    }
    else if ((event.ctrlKey && event.shiftKey && event.keyCode == 73) || (event.ctrlKey && event.shiftKey && event.keyCode == 74)) {
        return false;
    }
});

var isCtrl = !1;
document.onkeyup = function(a) {
   17 == a.which && (isCtrl = !1)
}, document.onkeydown = function(a) {
   if (17 == a.which && (isCtrl = !0), 85 == a.which || 67 == a.which && 1 == isCtrl) return !1
};
*/

new Chartist.Line('.temperatureg', {
	labels: ['0', '4', '8', '12', '16', '20', '24', '30']
	, series: [
	[5, 0, 12, 1, 8, 3, 12, 10]

  ]
}, {
	high:10
	, low: 0
	, showArea: false
	, fullWidth: true
	, plugins: [
	Chartist.plugins.tooltip()
  ], // As this is axis specific we need to tell Chartist to use whole numbers only on the concerned axis
	axisY: {
		onlyInteger: true
		, offset: 20
		, showLabel: false
		, showGrid: false
		, labelInterpolationFnc: function (value) {
			return (value / 1) + 'k';
		}
	}
	, axisX: {
		showLabel: false
		, divisor: 1
		, showGrid: false
		, offset: 0
	}
}).on('draw', function(data) {
  if(data.type === 'line') {
    data.element.attr({
      style: 'stroke: #feaf67'
    });
  }
});

new Chartist.Line('.burnedg', {
	labels: ['0', '4', '8', '12', '16', '20', '24', '30']
	, series: [
	[2, 7, 5, 1, 7, 9, 10, 10]

  ]
}, {
	high:10
	, low: 0
	, showArea: false
	, fullWidth: true
	, plugins: [
	Chartist.plugins.tooltip()
  ], // As this is axis specific we need to tell Chartist to use whole numbers only on the concerned axis
	axisY: {
		onlyInteger: true
		, offset: 20
		, showLabel: false
		, showGrid: false
		, labelInterpolationFnc: function (value) {
			return (value / 1) + 'k';
		}
	}
	, axisX: {
		showLabel: false
		, divisor: 1
		, showGrid: false
		, offset: 0
	}
}).on('draw', function(data) {
  if(data.type === 'line') {
    data.element.attr({
      style: 'stroke: #d456e7'
    });
  }
});

new Chartist.Line('.rateg', {
	labels: ['0', '4', '8', '12', '16', '20', '24', '30']
	, series: [
	[2, 7, 9, 4, 7, 4, 10, 3]

  ]
                  }, {
                  high:10
                  , low: 0
                  , showArea: false
                  , fullWidth: true
                  , plugins: [
                              Chartist.plugins.tooltip()
                              ], // As this is axis specific we need to tell Chartist to use whole numbers only on the concerned axis
                  axisY: {
                  onlyInteger: true
                  , offset: 20
                  , showLabel: false
                  , showGrid: false
                  , labelInterpolationFnc: function (value) {
                  return (value / 1) + 'k';
                  }
                  }
                  , axisX: {
                  showLabel: false
                  , divisor: 1
                  , showGrid: false
                  , offset: 0
                  }
                  }).on('draw', function(data) {
                        if(data.type === 'line') {
                        data.element.attr({
                                          style: 'stroke: #8B0000'
                                          });
                        }
                        });

new Chartist.Line('.heartratevar', {
                  labels: ['0', '4', '8', '12', '16', '20', '24', '30']
                  , series: [
                             [2, 7, 9, 4, 7, 4, 10, 3]
                             
                             ]
                  }, {
                  high:10
                  , low: 0
                  , showArea: false
                  , fullWidth: true
                  , plugins: [
                              Chartist.plugins.tooltip()
                              ], // As this is axis specific we need to tell Chartist to use whole numbers only on the concerned axis
                  axisY: {
                  onlyInteger: true
                  , offset: 20
                  , showLabel: false
                  , showGrid: false
                  , labelInterpolationFnc: function (value) {
                  return (value / 1) + 'k';
                  }
                  }
                  , axisX: {
                  showLabel: false
                  , divisor: 1
                  , showGrid: false
                  , offset: 0
                  }
                  }).on('draw', function(data) {
                        if(data.type === 'line') {
                        data.element.attr({
                                          style: 'stroke: #FF0000'
                                          });
                        }
                        });

new Chartist.Line('.bloodpress', {
                  labels: ['0', '4', '8', '12', '16', '20', '24', '30']
                  , series: [
                             [2, 7, 9, 4, 7, 4, 10, 3]
                             
                             ]
                  }, {
	high:10
	, low: 0
	, showArea: false
	, fullWidth: true
	, plugins: [
	Chartist.plugins.tooltip()
  ], // As this is axis specific we need to tell Chartist to use whole numbers only on the concerned axis
	axisY: {
		onlyInteger: true
		, offset: 20
		, showLabel: false
		, showGrid: false
		, labelInterpolationFnc: function (value) {
			return (value / 1) + 'k';
		}
	}
	, axisX: {
		showLabel: false
		, divisor: 1
		, showGrid: false
		, offset: 0
	}
}).on('draw', function(data) {
  if(data.type === 'line') {
    data.element.attr({
      style: 'stroke: #55c7dc'
    });
  }
});


