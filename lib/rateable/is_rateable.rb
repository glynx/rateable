module Rateable
  module IsRateable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def is_rateable(args = {})
        raise ":stars must be an integer >= 1" if args[:stars] and not (args[:stars].is_a?(Integer) and args[:stars] >= 1)
        @max_stars = args[:stars] || 5
        has_many :ratings, :as => :rateable, :class_name => "Rateable::Rate", :dependent => :destroy
        include Rateable::IsRateable::InstanceMethods
      end

      def is_rateable?
        true
      end
      
      def max_stars
        @max_stars
      end

    end

    module InstanceMethods
      def is_rateable?
        true
      end

      def max_stars
        self.class.max_stars
      end

      # include instance methods that are needed
      def rate(user,stars)
        raise "#{user.inspect} is not a rater" unless user.respond_to?(:is_rater?) and user.is_rater?
        rating = Rate.where(:rateable => self, :rater => user).first
        unless rating 
          rating = Rate.create(:rateable => self, :rater => user, :stars => stars) 
        else
          rating.stars = stars
        end
        rating.save
      end
    end
  end
end

