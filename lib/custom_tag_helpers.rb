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
