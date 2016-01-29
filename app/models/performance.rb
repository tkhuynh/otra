class Performance < ActiveRecord::Base
	belongs_to :tour
	belongs_to :band
	belongs_to :show
end
