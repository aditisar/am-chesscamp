
class PrintablesController < ApplicationController
  before_action :set_camp, only: [:camp_report]
  before_action :set_family, only: [:family_report]

  def payments
    @camps = Camp.all.to_a
    @camps.delete_if { |c| c.start_date.year != Date.today.year} 
    render :layout => 'printable' 
  end

  def camp_report
    render :layout => 'printable'
  end

  def family_report
    render :layout => 'printable'
  end

  private
    def set_camp
      @camp = Camp.find(params[:camp_id])
    end

    def set_family
      @family = Family.find(params[:family_id])
      @year = params[:year]
    end

  
end
