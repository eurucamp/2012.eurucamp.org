module CustomTagHelpers

  def wrapped(el = :div, attrs = {}, &block)
    capture_haml do
      haml_tag el, attrs do
        haml_tag :div, :class => 'wrapper', &block
      end
    end
  end

  def image(url, sizes = [], attrs = {})
    # TODO: Move into private method
    attrs[:src] = url
    attrs[:class] ||= ''
    attrs[:class] << ' resp'
    attrs[:class].strip!
    sizes.each do |size|
      attrs[:"data-#{size}"] = image_url_for_size(url, size)
    end
    capture_haml do
      haml_tag :img, attrs
    end
  end

private

  def image_url_for_size(url, size)
    extension = File.extname(url)
    url.chomp(extension) + '-' + size.to_s + extension
  end

end
