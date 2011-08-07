require 'spec_helper'

describe User do
  describe :is_rater? do
    it "as instance method returns true" do
      user = Factory(:user) 
      assert user.is_rater?
    end

    it "as class method returns true" do 
      assert User.is_rater? 
    end
  end

  describe :rate do
    let(:user) { Factory(:user) }

    it "should call Rateable.rate if object is rateable" do
      picture = Factory(:picture)
      picture.should_receive(:rate).with(user,1)
      user.rate(picture,1)
    end

    it "returns false if the object does not respond to is_rateable?" do
      user.rate(user,1).should == false
    end

    it "returns false if the object is nil" do
      user.rate(nil,1).should == false
    end
  end
end
