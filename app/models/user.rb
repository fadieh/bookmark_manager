require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
	property :password_confirmation, Text

	property :password_token, Text
	property :token_time_stamp, String

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

	def send_reset_email
		RestClient.post "https://api:key-9697e2ab8b43fcf3bcef4b16a489d1fc"\
  		"@api.mailgun.net/v2/sandbox4e7aa7e546fe470fa8374cfef666b223.mailgun.org/messages", 
		:from => "Team <postmaster@sandbox4e7aa7e546fe470fa8374cfef666b223.mailgun.org>",
		:to => "#{self.email}",
		:subject => "Reset your password",
		:text => "Here is your password token.
#{self.password_token}
Use this token to reset your password at the following link:
http://localhost:9292/users/change_password/#{self.password_token}/#{self.email}"
	end

	def update_token
		self.password_token = (1..64).map{ ('A'..'Z').to_a.sample }.join
		self.token_time_stamp = Time.now
		self.save!
	end

end