class PrintablesController < ApplicationController
  def payments
    render :layout => 'printable'
  end

  def general
    render :layout => 'printable'
  end
  
end
