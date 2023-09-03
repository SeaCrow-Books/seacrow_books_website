class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # Your code for gathering stats, etc.
  end
end
