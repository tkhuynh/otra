class Band < User
	has_many :tours
	has_many :performances
end