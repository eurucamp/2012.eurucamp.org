module CustomTagHelpers

  def wrapped(el = :div, attrs = {}, &block)
    capture_haml do
      haml_tag el, attrs do
        haml_tag :div, :class => 'wrapper', &block
      end
    end
  end

  def image(url, sizes = [], attrs = {})
    attrs[:src] = url
    attrs = inject_class(attrs, 'resp')
    sizes.each do |size|
      attrs[:"data-#{size}"] = image_url_for_size(url, size)
    end
    capture_haml do
      haml_tag :img, attrs
    end
  end

  def nav(items, attrs)
    capture_haml do
      haml_tag :nav, attrs do
        haml_tag :ul do
          items.each do |item|
            haml_tag :li, :class => item.downcase do
              path = "/#{item.downcase.dasherize}.html"
              attrs = {
                :href  => path,
                :class => ('active' if request.path == path),
                :title => "Read about #{item.downcase}"
              }
              haml_tag :a, item, attrs
            end
          end
        end
      end
    end
  end

  def schedule_for(items, options, &block)
    schedule_start  = Time.utc 2012, 1, 1, options[:start], 0, 0

    first_start_h, first_start_min = items.first.start.to_s.split('.')
    first_start_time = Time.utc 2012, 1, 1, first_start_h, first_start_min, 0

    items.each_with_index do |item, index|
      start              = item.start
      stop               = item.end || items[index + 1].start

      start_h, start_min = start.to_s.split('.')
      stop_h, stop_min   = stop.to_s.split('.')

      start_min          = start_min.ljust(2, '0')
      stop_min           = stop_min.ljust(2, '0')

      start_time         = Time.utc 2012, 1, 1, start_h, start_min, 0
      stop_time          = Time.utc 2012, 1, 1, stop_h, stop_min, 0

      duration_min       = (stop_time - start_time) / 60

      distance_min       = (start_time - first_start_time + (first_start_time - schedule_start)) / 60

      yield item, duration_min, distance_min

    end
  end

  def float_to_time(num)
    hours = num.to_int
    minutes = ((num - hours.to_f) * 60).to_int
    "#{"%02d" % hours}.#{"%02d" % minutes}"
  end

private

  def inject_class(attributes, klass)
    attrs = attributes.dup
    attrs[:class] ||= ''
    attrs[:class] << " #{klass}"
    attrs[:class].strip!
    attrs
  end

  def image_url_for_size(url, size)
    extension = File.extname(url)
    url.chomp(extension) + '-' + size.to_s + extension
  end

end
