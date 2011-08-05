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
