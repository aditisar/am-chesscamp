class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_registrations = Registration.active.paginate(:page => params[:page]).per_page(10)
    @inactive_registrations = Registration.inactive.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @registration = Registration.new
    @registration.student_id = params[:id] unless params[:id].nil?
   # @registration.camp_id = params[:id] unless params[:id].nil?
  end

  def edit    
  end

  def create
    @registration = Registration.new(registration_params)
    #@acceptable_camps = Camps.alphabetical
    if @registration.save
      # if saved to database
      flash[:notice] = "#{@registration.student.proper_name} is registered for #{@registration.camp.name}."
      redirect_to @student # go to student page
    else
      # return to the 'new' form
      render :action => 'new'
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
    redirect_to registrations_url
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :active, :points_earned, :payment_status)  
    end
end
