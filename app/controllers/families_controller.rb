class FamiliesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :check_login, except: [:index, :show]
  before_action :set_family, only: [:show, :edit, :update, :destroy]

  def index
    @active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @students = @family.students.alphabetical
  end

  def new
    @family = Family.new
  end

  def edit
    # reformating the phone so it has dashes when displayed for editing (personal taste)
    @family.phone = number_to_phone(@family.phone)
  end

  def create
    @family = Family.new(faily_params)
    if @family.save
      redirect_to @family, notice: "#{@family.family_name} family was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @family.update(family_params)
      redirect_to @family, notice: "#{@family.family_name} family was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @family.destroy
    redirect_to family_url, notice: "#{@family.family_name} family was removed from the system."
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active)
    end
end

  # create_table "families", force: true do |t|
  #   t.string  "family_name"
  #   t.string  "parent_first_name"
  #   t.string  "email"
  #   t.string  "phone"
  #   t.boolean "active",            default: true
  # end