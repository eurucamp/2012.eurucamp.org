(function($) {

  $.debounce = function(callback, delay) {
    var timeout;
    return function() {
      var self = this, args = arguments;
      clearTimeout(timeout);
      timeout = setTimeout(function() {
        timeout = null;
        callback.apply(self, args);
      }, delay);
    };
  };

})(jQuery);

