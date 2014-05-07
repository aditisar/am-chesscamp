class PrintablesController < ApplicationController
  def payments
    @unpaid_registrations = Registration.all.deposit_only.to_a.sort_by { |r| r.camp }
    render :layout => 'printable'
  end

  def general
    render :layout => 'printable'
  end
  
end
