module Rateable
  class Rate < ActiveRecord::Base
    belongs_to :rateable, :polymorphic => true
    belongs_to :rater, :polymorphic => true

    validates_presence_of :rateable
    validates_presence_of :rater
    validate :stars_must_be_in_range

    def stars_must_be_in_range 
      unless (1..rateable.max_stars).include? stars
        errors.add :stars, "must be within 1 to #{rateable.max_stars}"
      end
    end
  end
end
