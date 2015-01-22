class Beer < ActiveRecord::Base
belongs_to :brewery
has_many :ratings, dependent: :destroy

	def average_rating
	ratings.average(:score).to_f
	end

	def to_s
	"#{name} - Brewery: #{brewery.name}"
	end
end
