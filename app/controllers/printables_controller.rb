class PrintablesController < ApplicationController
  def payments
    @unpaid_registrations = Registration.all.deposit_only.to_a.sort_by { |r| r.camp }
    render :layout => 'printable'
  end

  def general
    until_date = Date.today + 1.month
    @camps = Camp.all.delete_if {|c| c.start_date > until_date } 
    render :layout => 'printable'
  end
  
end
