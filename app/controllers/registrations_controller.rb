class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_registrations = Registration.paginate(:page => params[:page]).per_page(10)
    @inactive_registrations = Registration.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @registration = Registration.new
    @registration.student_id = params[:id] unless params[:id].nil?
    #set student to current student
    @student = Student.find(@registration.student_id)
    #making an array of camps that that student can actually register for
    @possible_camps = Camp.active.to_a
    #get rid of camps that don't match students rating
    @possible_camps.delete_if { |c| c.curriculum.max_rating < @student.rating }
    @possible_camps.delete_if { |c| c.curriculum.min_rating > @student.rating }    
    #get rid of camps at the same time as camps they are registered for
    @times_taken = @student.camps.map { |c| [c.start_date,c.time_slot] }
    @possible_camps.delete_if { |c| @times_taken.include?([c.start_date,c.time_slot]) }

    @profh_possible_camps = Curriculum.for_rating(@student.rating).map{ |c| c.camps }.flatten - @student.camps
   
    puts 'am i getting the right list of camps ', @profh_possible_camps.sort == @possible_camps.sort
  end

  def edit    
  end

  def create
    @registration = Registration.new(registration_params)
    #@acceptable_camps = Camps.alphabetical
    if @registration.save
      # if saved to database
      flash[:notice] = "#{@registration.student.proper_name} is registered for #{@registration.camp.name}."
      redirect_to student_path(@registration.student_id) # go to student page
    else
      # return to the 'new' form 
      redirect_to :action => "new", :id=> @registration.student_id
    end
  end

  def update
    if @registration.update_attributes(registration_params)
      flash[:notice] = "#{@registration.student.proper_name}'s registration for #{@registration.camp.name} is updated."
      redirect_to @registration
    else
      render :action => 'edit'
    end
  end

  def destroy
    @registration.destroy
    flash[:notice] = "Successfully removed #{@registration.student.proper_name} from #{@registration.camp.name}."
    redirect_to students_url
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :active, :points_earned, :payment_status)  
    end
end
