module Rateable
  module IsRateable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def is_rateable
        has_many :ratings, :as => :rateable, :class_name => "Rateable::Rate", :dependent => :destroy
        include Rateable::IsRateable::InstanceMethods
      end

      def is_rateable?
        true
      end
    end

    module InstanceMethods
      def is_rateable?
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
end

