class HomeController < ApplicationController
  def index
    unless current_user.nil?
      @upcoming_camps = current_user.instructor.camps.upcoming.chronological
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
