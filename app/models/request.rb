class Request < ActiveRecord::Base
	belongs_to :show
	belongs_to :performance
end
