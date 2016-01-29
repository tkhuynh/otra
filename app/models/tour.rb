class Tour < ActiveRecord::Base
	belongs_to :band
	has_many :performances
	accepts_nested_attributes_for :performances
end