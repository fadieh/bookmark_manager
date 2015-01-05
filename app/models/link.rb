class Link

	include DataMapper::Resource

	property :id,	Serial
	property :title, String
	property :url, String
	has n, :tags, :through => Resource
	property :votes, Integer, :default => 0

	def upvote
		self.votes += 1
		self.save
	end

	def downvote
		self.votes += 1
		self.save
	end

end