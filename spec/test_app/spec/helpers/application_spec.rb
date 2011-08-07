describe ApplicationHelper do
  include Rateable::Helper

  describe :rating_for do
    before(:each) do
      @picture = Factory(:picture)
      @user = Factory(:user)
    end

    def current_user
      @user
    end

    it "should render the rate partial if logged in and not rated yet" do
      rating_for @picture
      assert_template :partial => "rateable/_rate"
    end

    it "should render the ratings partial if logged in and already rated" do
      @user.rate @picture, 1
      rating_for @picture
      assert_template :partial => "rateable/_rating"
    end

    it "should raise an error if the object given is not rateable" do
      lambda{rating_for(@user)}.should raise_error 
    end

    it "should show ratings if not logged_in" do
      @user = nil
      rating_for(@picture)
      assert_template :partial => "rateable/_rating"
    end

    it "should show the rate partial if user is given as parameter" do 
      @user = nil
      rating_for @picture, :user => Factory(:user)
      assert_template :partial => "rateable/_rate"
    end

    it "should use given url if user allowed to rate" do
      url = "test123"
      rating_for @picture, :url => url
      rendered.should include(url)
    end

  end
end
