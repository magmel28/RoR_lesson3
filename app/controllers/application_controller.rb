class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :counter

  protect_from_forgery with: :exception
  include SessionsHelper

  def counter
    unless session[:user_id].nil?
      if session[:count].nil?
        session[:count] = 0
      else
        session[:count] += 1
      end
    end
  end
end
