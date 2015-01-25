class Beer < ActiveRecord::Base
belongs_to :brewery
has_many :ratings, dependent: :destroy

include RatingAverage

	

	def to_s
	"#{name} - Brewery: #{brewery.name}"
	end

	
end
