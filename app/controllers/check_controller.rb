class CheckController < ApplicationController
  def index
    SimpleServerCheck.run_checks
  end
end
