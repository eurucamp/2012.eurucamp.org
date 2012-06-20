(function($) {

  function compareNumbers(a, b){
    return a - b;
  }

  $.fn.responsiveImages = function(options) {

    var $window = $(window);

    this.each(function(){
      var $this = $(this),
          sizes = [];

      $this.data('orig-size', $this.attr('src'));

      $.each($this.data(), function(key, value) {
        if (!isNaN(parseFloat(key)) && isFinite(key)) {
          sizes.push(parseInt(key, 10));
        }
      });
      sizes = sizes.sort(compareNumbers);

      var onResize = function() {
        var width = $window.width(),
            src   = $this.data('orig-size');

        $.each(sizes, function(i, size) {
          if (width >= size) {
            src = $this.data(String(size));
          }
        });

        if ($this.attr('src') !== src) {
          $this.attr('src', src);
        }
      }

      $window.on('resize', $.debounce(onResize, 10)).trigger('resize');

    });

  };

})(jQuery);

