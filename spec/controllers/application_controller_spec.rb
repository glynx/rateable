require 'spec_helper'

describe ApplicationController do
  let(:user){ Factory(:user) }

  describe :login do
    it "it saves the given user_id in the session" do
      get :login, :user_id => user.id
      session[:user_id].should == user.id
    end

    it "saves nil in the session if no id is given" do
      get :login
      session[:user_id].should == nil
    end
  end

  describe :logout do
    it "sets the user in the session to nil if user is logged in" do
      session[:user_id] = user.id
      get :logout
      session[:user_id].should == nil
    end

    it "sets the user in the session to nil if no user logged in" do
      get :logout
      session[:user_id].should == nil
    end
  end

  describe :current_user do
    it "returns nil if session[:user_id] is nil and no user_id is given as param" do
      session[:user_id] = nil
      controller.current_user.should == nil
    end

    it "return user if session nil and user_id is given as param" do
      session[:user_id] = nil
      get :logout, :user_id => user.id
      controller.current_user.should == user
    end 

    it "returns the User with session[:user_id] as it's id" do
      session[:user_id] = user.id
      controller.current_user.should == user
    end
  end
end
