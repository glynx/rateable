class RateableMigration < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer 'rateable_id'
      t.string 'rateable_type'
      t.integer 'rater_id'
      t.string 'rater_type'
      t.integer 'stars'
    end
  end

  def self.down
    drop_table :rates
  end
end
