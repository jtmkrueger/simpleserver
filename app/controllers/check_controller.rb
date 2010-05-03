class CheckController < ApplicationController
  def index
    SimpleServerCheck.run_checks
    render :text => "checked"
  end
end
