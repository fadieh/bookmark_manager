class Tag

	include DataMapper::Resource

	has n, :links, :through => Resource # has many relationships.

	property :id, Serial
	property :text, String

end