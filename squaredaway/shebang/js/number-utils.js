;(function() { 

  function sanitize(nStr) {
    return typeof nStr ==="number" ? nStr : nStr.indexOf(',') === -1 ? parseFloat(nStr) : parseFloat(nStr.split(',').join(""));
  }

  function roundPlaces(n, places) {
    n = typeof n === "number" ? n : sanitize( n );
    return Math.round(n*(Math.pow(10,places))) / Math.pow(10,places);
  }

  function format( number, places ) {
    places && ( number = roundPlaces( number, places) );
    number = ""+number;
    var x = number.split('.');
    var x1 = typeof p ==="number" && p === 0 ? Math.round(parseFloat(number))+'' : x[0];
    var x2 = x.length > 1 && ((typeof places ==="number" && places !== 0) || typeof places ==="undefined") ?  x[1] : '';
    x2 = places ? '.'+(pad(x2, places)) : (x2.length ? '.'+x2 : '');
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
  }

  function pad( num, len, padChar, dir) {

    var STR_PAD_LEFT = 1;
    var STR_PAD_RIGHT = 2;
    var STR_PAD_BOTH = 3;
    var str = "" + num;

    len = len || 0;
    padChar = padChar || 0;
    dir = STR_PAD_RIGHT;

    if (len + 1 >= str.length) {

      switch (dir){

      case STR_PAD_LEFT:
        str = Array(len + 1 - str.length).join(padChar) + str;
        break;

      case STR_PAD_BOTH:
        var right = Math.ceil((padCharlen = len - str.length) / 2);
        var left = padCharlen - right;
        str = Array(left+1).join(padChar) + str + Array(right+1).join(padChar);
        break;

      default:
        str = str + Array(len + 1 - str.length).join(padChar);
        break;

      }

    }

    return str;

  }
  window.numberUtils = {
    format: format,
    formatRate: function( rate ) {
      return format( rate, 3 );
    },
    pad: pad
  };

})();
