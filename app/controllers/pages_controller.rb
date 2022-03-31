class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]
  def home
    @building = Building.new
  end
end
