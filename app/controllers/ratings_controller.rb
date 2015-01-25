class RatingsController < ApplicationController
  def index
  end

   def index
    @ratings = Rating.all
  end
end