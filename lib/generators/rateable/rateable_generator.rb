class RateableGenerator < Rails::Generator::Base
  def manifest
    record do |m|
        m.directory img_path
        m.file "star_unfilled.png", File.join(img_path, "star_unfilled.png")
        m.file "star_filled.png", File.join(img_path, "star_filled.png")
        m.directory js_path
        m.file "rateable.js", File.join(js_path, "rateable.js")
        m.directory stylesheets_path
        m.file "rateable.css", File.join(stylesheets, "rateable.css")
        m.migration_template "migration.rb", migrations_path, :migration_file_name => "rateable_migration"
    end
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
