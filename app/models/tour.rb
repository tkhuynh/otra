class Tour < ActiveRecord::Base
	belongs_to :band
	has_many :performances, dependent: :destroy
	accepts_nested_attributes_for :performances, reject_if: lambda { |a| a[:performance_date] or a[:location].blank? }, allow_destroy: true
end