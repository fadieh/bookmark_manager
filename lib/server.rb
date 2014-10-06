env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on LocalHost. 
# The name will be "bookmark_manager_test" or "bookmark_manager_development"
# depending on the environment.
DataMapper.setup(:default, "postgress://localhost/bookmark_manager_#{env}") 

require './lib/link' # needs to be done after datamapper is initialised

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them.
DataMapper.auto_upgrade!