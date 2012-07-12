# TMP solution:
# https://github.com/middleman/middleman/pull/370#issuecomment-6727140
# https://github.com/bhollis/middleman/blob/1229a9991a4bf575bef5edb6180dac5b63fce5c5/middleman-core/lib/middleman-core/application.rb#L220
module Middleman
  class Application
    # Work around this bug: http://bugs.ruby-lang.org/issues/4521
    # where Ruby will call to_s/inspect while printing exception
    # messages, which can take a long time (minutes at full CPU)
    # if the object is huge or has cyclic references, like this.
    def to_s
      "the Middleman application context"
    end
  end
end

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
    attrs_to_merge = [:type, :rel].freeze
    capture_haml do
      haml_tag :nav, attrs do
        haml_tag :ul do
          items.each do |item|
            item, path = item.to_a.flatten if item.is_a? Hash
            haml_tag :li, :class => item.downcase do
              path ||= "/#{item.downcase.dasherize}"
              title  = "Read about #{item.downcase}"

              new_attrs = {
                :href  => path,
                :class => ('active' if request.path =~ /^#{path.gsub('.html', '')}/),
                :title => title
              }
              attrs_to_merge.each do |key|
                new_attrs.merge! key => attrs[key] if attrs[key]
              end

              haml_tag :a, item, new_attrs
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

  def group_and_sort_by(elements, grouped_by, blueprint, &block)
    groups = elements.group_by {|e| e[grouped_by] }
    blueprint.each do |group|
      slice = groups[group]
      yield group, slice if slice
    end
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
