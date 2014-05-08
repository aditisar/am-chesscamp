class HomeController < ApplicationController
  def index
    unless current_user.nil?
      @all_camps = Camp.all
      @all_families = Family.all
      @upcoming_camps = current_user.instructor.camps.upcoming.chronological
      @low_enroll = Camp.all.delete_if {|c| c.registrations.size > 2}
      @no_instructors = Camp.all.delete_if { |c| c.camp_instructors.size != 0}
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  

end
