class User < ApplicationRecord
	
	before_save {self.email = self.email.downcase }
	
	validates :name, presence: true, length: { maximum:50 }
	
	email_regex_validation = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 }, format: { with: email_regex_validation }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end


