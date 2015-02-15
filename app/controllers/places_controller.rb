class PlacesController < ApplicationController
  def index
  end

  def show
    places = Rails.cache.read(session[:last_city])
    places.each do |place|
      if place.id == params[:id]
        @place = place
      end
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_city] = params[:city].downcase
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end