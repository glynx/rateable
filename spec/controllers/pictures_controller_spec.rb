require 'spec_helper'

describe PicturesController, "rating a picture" do

  it "should rate the picture" do
    picture = Factory(:picture)
    user = Factory(:user)
    post 'rate', :user_id => user.id, :id => picture.id, :stars => 1
    ratings = user.reload.ratings
    ratings.count.should == 1
    ratings.first.rateable.should == picture
    ratings.first.stars.should == 1
    response.should be_success
  end

  it "is not possible unless logged in" do
    picture = Factory(:picture)
    post 'rate', :id => picture.id, :stars => 1
    picture.ratings.count.should == 0
    response.should_not be_success
    response.body.should == "You are not allowed to vote for this item!"
  end

  it "is not possible if already voted" do
    picture = Factory(:picture)
    user = Factory(:user)
    user.rate(picture, 1)
    post 'rate', :id => picture.id, :user_id => user.id, :stars => 1
    response.should_not be_success
    picture.ratings.count.should == 1
  end

  it "is not possible to vote if no stars are given" do
    picture = Factory(:picture)
    user = Factory(:user)
    post 'rate', :id => picture.id, :user_id => user.id
    response.should_not be_success
    picture.ratings.count.should == 0
  end

  it "should not be possible with to many stars" do
    picture = Factory(:picture)
    user = Factory(:user)
    post 'rate', :id => picture.id, :user_id => user.id, :stars => picture.max_stars+1
    response.should_not be_success
    picture.ratings.count.should == 0
  end

  it "should not be possible with to less stars" do
    picture = Factory(:picture)
    user = Factory(:user)
    post 'rate', :id => picture.id, :user_id => user.id, :stars => 0
    response.should_not be_success
    picture.ratings.count.should == 0
  end

end
