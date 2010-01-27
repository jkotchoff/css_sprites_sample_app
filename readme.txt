Overview:
---------
This sample app shows one way of using css sprites in rails with code like:
<%= image_tag("/images/sprite_icons.png", :sprite => "weather_cloudy") %> cloudy<br/>
that outputs html like:
<img src="/images/transparent.gif" style="background: transparent url(/images/sprite_icons.png) no-repeat scroll 0px 66px;" height="16" width="16"> cloudy<br>

Try it yourself:
----------------
> git clone git@github.com:cornflakesuperstar/css_sprites_sample_app.git
> cd css_sprites_sample_app
> ./script/server
open http://localhost:3000 in browser

Interesting Bits:
-----------------
- config/initializers/monkey_patch_image_sprites.rb
- config/css_sprite_images.yml
- public/images/sprite_icons.png
- app/views/about/index.html.erb
