require "active_record"
require "action_view"
require "action_controller"

require 'rateable/is_rateable'
require 'rateable/rater'
require 'rateable/rate'

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Rateable::IsRateable
  ActiveRecord::Base.send :include, Rateable::Rater
end

if defined?(ActionView::Base)
  require 'rateable/helper'
  ActionView::Base.send :include, Rateable::Helper
end

if defined?(ActionController::Base)
  ActionController::Base.prepend_view_path File.dirname(__FILE__) + "/../app/views"
end
