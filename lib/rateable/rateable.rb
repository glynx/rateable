module Rateable
  def is_rateable
    has_many :ratings, :as => :rateable, :class_name => "Rate"
    include InstanceMethods
  end

  module InstanceMethods
    def is_rateable?
      true
    end

    def self.is_rateable?
      true
    end

    # include instance methods that are needed
    def rate(user,stars)
      rating = Rate.where(:rateable => self, :rater => user).first
      rating = Rate.create(:rateable => self, :rater => user) unless rating
      rating.stars = stars
      rating.save
    end
  end
end


