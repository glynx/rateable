require "active_record"
require "action_view"

require 'rateable/is_rateable'
require 'rateable/rater'
require 'rateable/rate'
ActiveRecord::Base.send :extend, Rateable::IsRateable
ActiveRecord::Base.send :extend, Rateable::Rater

if defined?(ActionView)
  require 'rateable/helper'
  ActionView::Base.send :include, Rateable::Helper
end
