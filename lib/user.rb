require 'bcrypt'

class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	# this is datamapper's method of validating the model
	# The model will not be saved unless both password
	# and password_confirmation are the same
	# read more about it in the documentation
	# http://datamapper.org/docs/validations.html
	validates_confirmation_of :password
	# validates_uniqueness_of :email

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
	property :password_confirmation, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

end