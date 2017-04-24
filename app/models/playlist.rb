class Playlist < ActiveRecord::Base
	has_many :users
	has_many :songs
end
