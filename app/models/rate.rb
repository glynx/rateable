class Rate < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  belongs_to :rater, :polymorphic => true

  validates_presence_of :rateable
  validates_presence_of :rater
  validates_inclusion_of :stars, :in => (1..5).to_a
end
