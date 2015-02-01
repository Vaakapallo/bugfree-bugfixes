class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true,
	length: { minimum: 3, maximum: 15 }

	validates :password, format: {with: /.*[A-Z].*/, message: "has to have at least one CAPITAL LETTER"},
	length: {minimum: 4}
	validates :password, format: {with: /.*[\d].*/, message: "has to have at least one numb3r"}

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
end