require 'rails/generators/migration'

class RateableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def copy_files
     directory img_path
#     copy_file "star_unfilled.png", File.join(img_path, "star_unfilled.png")
#     copy_file "star_filled.png", File.join(img_path, "star_filled.png")
     directory js_path
#     copy_file "rateable.js", File.join(js_path, "rateable.js")
     directory stylesheets_path
#     copy_file "rateable.css", File.join(stylesheets, "rateable.css")
     migration_template "migration.rb", migrations_path, :migration_file_name => "rateable_migration"
  end

  def js_path
    File.join("public", "javascript")
  end

  def img_path
     File.join("public","images","rateable")
  end

  def stylesheets_path
     File.join("public","stylesheets")
  end

  def migrations_path
     File.join("db","migrate")
  end
end
