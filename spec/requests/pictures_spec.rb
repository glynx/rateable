require 'spec_helper'

describe "Pictures" do
  it "shows the picture when visiting the show action" do
    picture = Factory(:picture)
    visit picture_path(picture)
    page.should have_content(picture.name)
  end

  it "should not set current_user when no user_id is given" do
    user = Factory(:user)
    picture = Factory(:picture)
    visit picture_path(picture)
    User.all.each do |u|
      page.should_not have_content(u.email)
    end
  end

  it "should set current_user when a user_id is given" do
    picture = Factory(:picture)
    user = Factory(:user)
    visit picture_path(picture, :user_id => user.id)
    page.should have_content(user.email)
  end

  it "should show star images when not logged in" do
    picture = Factory(:picture)
    visit picture_path(picture)
    page.should_not have_xpath('//div[@class="rating"]/a')
    page.should have_xpath('//div[@class="rating"]/img')
  end

  it "should show a star links when logged in and not already voted" do
    picture = Factory(:picture)
    user = Factory(:user)
    user.ratings.destroy_all
    visit picture_path(picture, :user_id => user.id)
    page.should have_xpath('//div[@class="rating"]/a[@class="rate"]')
    page.should_not have_xpath('//div[@class="rating"]/img')
  end

  it "shows star images when logged in and already voted" do
    picture = Factory(:picture)
    user = Factory(:user)
    user.rate(picture,1)
    visit picture_path(picture, :user_id => user.id)
    page.should_not have_xpath('//div[@class="rating"]/a[@class="rate"]')
    page.should have_xpath('//div[@class="rating"]/img')
  end

  it "should be possible to vote", :js => true do
    picture = Factory(:picture)
    user = Factory(:user)
    user.ratings.destroy_all
    visit login_path(:user_id => user.id)
    visit picture_path(picture)
    page.should have_xpath('//div[@class="rating"]/a[@class="rate"]')
    find(:xpath, '//div[@class="rating"]/a[@class="rate"][3]').click
    page.should have_no_xpath('//div[@class="rating"]/a[@class="rate"]')
    page.should have_xpath('//div[@class="rating"]/img[@alt="Star_filled"][1]')
    page.should have_xpath('//div[@class="rating"]/img[@alt="Star_filled"][2]')
    page.should have_xpath('//div[@class="rating"]/img[@alt="Star_filled"][3]')
    page.should have_no_xpath('//div[@class="rating"]/img[@alt="Star_filled"][4]')
  end
end

