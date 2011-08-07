module Rateable
  module Helper
    def rating_for(rateable, args = {})
      user = args[:user] || try(:current_user)
      if user and user.ratings.where(:rateable => rateable).empty?
        render :partial => "rateable/rate", :locals => {:url => args[:url] ? args[:url] : url_for([:rate, rateable]), :stars => args[:stars]}
      else
        stars_average = rateable.ratings.average("stars")
        ratings_count = rateable.ratings.count
        render :partial => "rateable/rating", :locals => {:stars => args[:stars], :rating => stars_average.to_i, :tooltip => "#{ratings_count} #{ratings_count == 1 ? "time" : "times"} rated, with an average value of #{stars_average}."}
      end
    end
  end
end
