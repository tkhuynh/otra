class Show < ActiveRecord::Base
	has_many :performances
	belongs_to :host
end
