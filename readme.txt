This app shows how to extend the rails image_tag to accept a :sprite parameter which maps to a config file and renders the resultant image using the CSS Spriting technique.

The steps towards introducing this technique into your own rails app are (roughly):
cd ~
rails css_sprites
cd css_sprites
google: fam fam fam silk (save as #{RAILS_ROOT}/doc/)
unzip doc/famfamfam_silk_icons_v013.zip
mv icons/weather* public/images
./script/generate controller about index
vi config/routes.rb (map.root :controller => "about")
rm public/index.html
vi app/views/about/index.html.erb (<%= image_tag("/images/weather_clouds.png") %> clouds<br/> cloudy, lightning, rain, snow, sun..)
firefox localhost:3000 (and show the net performance of six images loading in a staggered fashion)
zip -r icons.zip weather*
http://spritegen.website-performance.org/ (save as #{RAILS_ROOT}/public/images/sprite_icons.png")
cp #{RAILS_ROOT}/config/monkey_patch_image_sprites.rb config/initializers/monkey_patch_image_sprites.rb
cp #{RAILS_ROOT}/config/css_sprite_images.yml config/css_sprite_images.yml 
cd public/images/
wget http://www.mappedrealestate.com.au/images/transparent.gif
vi app/views/about/index.html.erb (<%= image_tag("/images/sprite_icons.png", :sprite => "weather_clouds") %> Clouds<br/>)
firefox localhost:3000 in new window (compare firebug NET tab and show HTML source)
