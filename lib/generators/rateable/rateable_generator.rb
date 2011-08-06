require 'rails/generators/migration'

class RateableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def copy_files
     copy_file "star_unfilled.png", "public/images/rateable/star_unfilled.png"
     copy_file "star_filled.png", "public/images/rateable/star_filled.png"
     copy_file "rateable.js", "public/javascripts/rateable.js"
     copy_file "rateable.css", "public/stylesheets/rateable.css"
     migration_template "migration.rb", "db/migrate", :migration_file_name => "rateable_migration"
  end
end
