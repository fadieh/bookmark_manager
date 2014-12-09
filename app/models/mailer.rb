class Mailer

	def self.create_token
		(1..64).map{('A'..'Z').to_a.sample}.join
	end

	def self.create_time_stamp
		time.now
	end

end