module CustomTagHelpers

  def wrapped(el = :div, attrs = {}, &block)
    capture_haml do
      haml_tag el, attrs do
        haml_tag :div, :class => 'wrapper', &block
      end
    end
  end

end
