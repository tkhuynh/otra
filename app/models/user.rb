class User < ActiveRecord::Base
	has_secure_password
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://www.weefmgrenada.com/images/na4.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	validates :name, presence: true
	validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }
  #only validate passoword when signup
	validates	:password, length: {minimum: 6}, on: :create
end
