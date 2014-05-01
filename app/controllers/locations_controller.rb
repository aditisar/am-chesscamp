class LocationsController < ApplicationController

  before_action :check_login, except: [:index, :show]
  
  def index
    @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_locations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end



end
