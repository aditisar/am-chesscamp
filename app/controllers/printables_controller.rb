
class PrintablesController < ApplicationController
  def payments
    @camps = Camp.all.to_a
    @camps.delete_if { |c| c.start_date.year != Date.today.year} 
    render :layout => 'printable' 
  end

  def general
    until_date = Date.today + 1.month
    @camps = Camp.all.delete_if {|c| c.start_date > until_date } 
    render :layout => 'printable'
  end
  
end
