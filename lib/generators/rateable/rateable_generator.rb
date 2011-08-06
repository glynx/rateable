require 'rails/generators/migration'

class RateableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def copy_files
     copy_file "star_unfilled.png", "public/images/rateable/star_unfilled.png"
     copy_file "star_filled.png", "public/images/rateable/star_filled.png"
     copy_file "rateable.js", "public/javascripts/rateable.js"
     copy_file "rateable.css", "public/stylesheets/rateable.css"
     migration_template "migration.rb", "db/migrate/rateable_migration"
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
end
