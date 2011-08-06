module Rateable
  module Helper
    def rateable, args = {}) 
      if @current_user and @current_user.ratings.where(:rateable => rateable).empty?                                                                                                                                                           
        render :partial => "rate", :locals => {:url => args[:url] ? args[:url] : url_for(rateable), :stars => args[:stars]}                                                                                                                    
      else
        stars_average = rateable.ratings.average("stars")
        ratings_count = rateable.ratings.count
        render :partial => "rating", :locals => {:stars => args[:stars], :rating => stars_average.to_i, :tooltip => "#{ratings_count} #{ratings_count == 1 ? "time" : "times"} rated, with an average value of #{stars_average}."}             
      end
    end
  end
end
