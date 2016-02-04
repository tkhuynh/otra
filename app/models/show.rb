class Show < ActiveRecord::Base
	has_attached_file :flyer, styles: { large: "600x600", medium: "300x300>", thumb: "100x100>" }, default_url: "http://www.logoworks.com/blog/wp-content/themes/fearless/images/missing-image-640x360.png"
	validates_attachment_content_type :flyer, content_type: /\Aimage\/.*\Z/
	has_many :performances
	belongs_to :host
	has_many :requests
end
