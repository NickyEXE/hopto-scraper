class BeersController < ApplicationController
  def drafts
    render json: UntappdScraperService.new.full_menu
  end

  def cans
    render json: HoptimistScraperService.new.menu
  end
end
