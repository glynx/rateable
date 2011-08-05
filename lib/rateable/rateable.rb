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

module Rater
  def is_rater
    has_many :ratings, :as => :rater, :class_name => "Rate"
    include InstanceMethods
  end

  module InstanceMethods
    def self.is_rater? 
      true
    end

    def is_rater?
      true
    end

    def rate(obj,stars)
      if obj.is_rateable?
        obj.rate(self,stars)
      else
        false
      end
    end
  end
end
