# Extend img tag to use the alt text for the title attribute if alt is present & title is empty (for SEO)
# Also allow CSS sprite images
module ActionView::Helpers::AssetTagHelper
  alias_method :orig_image_tag, :image_tag

  @@css_sprite_images_yml = YAML.load_file("#{RAILS_ROOT}/config/css_sprite_images.yml")

  def image_tag(source, options = {})
    # Make sure we give the image a title tag for hover context description in firefox
    if options[:alt] && !options[:title]
      options[:title] = options[:alt]
    end

    # If a 'sprite' argument has been specified, infer the CSS Sprite image offset and
    # use the css background trick
    # 
    # Example Usage:
    # <%= image_tag('tripsteps_sprites_1.gif', :sprite => "new_win") %>
    if sprite_img = options[:sprite]
      sprite_src = source
      img_config = @@css_sprite_images_yml[sprite_src.split("/").last]
      img_config = img_config[sprite_img] if img_config

      if img_config
        sprite_src = path_to_image(sprite_src)
        options[:style] ||= ""
        options.delete :sprite
        source = "transparent.gif"
        options[:alt] ||= img_config["alt"]
        options[:title] ||= img_config["alt"]
        img_width = img_config["width"]
        img_height = img_config["height"]
        sprite_x_indent = 0
        sprite_y_indent = img_config["y"] * -1
        options[:width] ||= img_width
        options[:height] ||= img_height
        sprite_css = "background:transparent url(#{sprite_src}) no-repeat #{sprite_x_indent}px #{sprite_y_indent}px;"
        options[:style] = sprite_css + options[:style]
      else
        logger.error "Could not find css sprite #{sprite_img} from #{sprite_src}. Check config/css_sprite_images.yml"
      end
    end
    return orig_image_tag(source, options)
  end
end
