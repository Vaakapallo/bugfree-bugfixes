class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
  	"#{beer.name} #{score}"
  end

  def new
    @rating = Rating.new
  end
end
