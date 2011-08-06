module Rateable
  module Rater
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def is_rater
        has_many :ratings, :as => :rater, :class_name => "Rateable::Rate", :dependent => :destroy
        include Rateable::Rater::InstanceMethods
      end

      def is_rater? 
        true
      end
    end

    module InstanceMethods
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
end
