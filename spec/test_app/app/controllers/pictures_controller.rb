class PicturesController < ApplicationController

  before_filter { @picture = Picture.find_by_id(params[:id]) }

  def show
    
  end

  def rate
    # Check if the current user has already voted
    if current_user and current_user.ratings.where(:rateable => @picture).empty? and @picture.rate(current_user, params[:stars])
      render :partial => "rateable/rating", :locals => {:rating => @picture.ratings.average("stars").to_i}                                                                    
    else
      render :text => "You are not allowed to vote for this item!", :status => 500
    end
  end


end
