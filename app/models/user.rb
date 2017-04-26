require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :playlists
  belongs_to :playlist
  validates :name, presence: :true, uniqueness: true, length: { minimum: 2 }
  validates :bio, presence: :true, length: { minimum: 1 }

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
