require 'spec_helper'

describe Picture do

  it "should have many ratings" do
    Factory(:picture).should respond_to(:ratings)
  end

  describe :is_rateable? do
    it "as instance method returns true" do
      picture = Factory(:picture)
      assert picture.is_rateable?
    end

    it "as class method returns true" do
      assert Picture.is_rateable?
    end
  end

  describe :rate do
    let(:picture) { Factory(:picture) }
    let(:user) { Factory(:user) }
  
    it "raises an exception if no valid rater is given" do
      lambda{picture.rate(picture,1)}.should raise_error
    end
  
    it "changes the rating of the given rater if already voted and stars are valid" do
      rating = Rateable::Rate.create(:rateable => picture, :rater => user, :stars => 1)
      picture.rate(user,2).should == true
      rating.id.should == picture.ratings.last.id
      picture.ratings.last.stars.should == 2
    end

    it "does not change the rating of the given rater if already voted and stars are not valid" do
      Rateable::Rate.create(:rateable => picture, :rater => user, :stars => 1)
      picture.rate(user,0).should == false
      picture.ratings.last.stars.should == 1
      picture.rate(user,100000).should == false
      picture.ratings.last.stars.should == 1
    end

    it "creates a new rating if valid rater and stars are given and not already rated" do
      user.ratings.empty?.should be_true
      picture.rate(user,1).should be_true
      rating = picture.ratings.last
      rating.rater.should == user
      rating.rateable.should == picture
      rating.stars.should == 1
    end

    it "does not create a new rating if valid rater and invalid stars are given" do
      picture.rate(user,0).should be_false
      picture.ratings.last.should be_nil
      picture.rate(user,10000).should be_false
      picture.ratings.last.should be_nil
    end
  end

  describe :max_stars do
    it "returns the value of the class-method max_stars" do
      Factory(:picture).max_stars.should == Picture.max_stars
    end

    it "returns an integer" do
      Picture.max_stars.should be_an(Integer)
      Picture.max_stars.should >= 1
    end
  end
end
