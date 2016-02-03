class Show < ActiveRecord::Base
	has_attached_file :flyer, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :flyer, content_type: /\Aimage\/.*\Z/
	has_many :performances
	belongs_to :host
	has_many :requests
end
