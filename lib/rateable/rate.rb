module Rateable
  class Rate < ActiveRecord::Base
    belongs_to :rateable, :polymorphic => true
    belongs_to :rater, :polymorphic => true

    validates_presence_of :rateable
    validates_presence_of :rater
    validates_inclusion_of :stars, :in => Proc.new{|rate| (1..rate.max_stars).to_a}
  end

  def max_stars
    rateable.max_stars
  end
end
