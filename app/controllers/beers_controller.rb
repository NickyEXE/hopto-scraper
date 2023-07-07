class BeersController < ApplicationController

  def beers
    beers = UntappdScraperService.new(permitted_params).full_menu.merge(HoptimistScraperService.new(permitted_params).menu)
    render json: beers
  end

  def drafts
    render json: UntappdScraperService.new(permitted_params).full_menu
  end

  def cans
    render json: HoptimistScraperService.new(permitted_params).menu
  end
  
  private

  def permitted_params
    params.permit("beer_type")
  end
end
