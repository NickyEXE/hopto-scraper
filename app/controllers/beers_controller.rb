class BeersController < ApplicationController
  def index
    render json: UntappdScraperService.new.full_menu
  end
end
