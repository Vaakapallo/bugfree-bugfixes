class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { less_than_or_equal_to: ->(_) { Time.now.year} }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

	def print_report
	    puts name
	    puts "established at year #{year}"
	    puts "number of beers #{beers.count}"
  	end

  	def restart
  		self.year = 2015
  		puts "changed year to #{year}"
  	end
end
