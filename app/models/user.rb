class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :managed_albums, class_name: 'ManagedAlbums', dependent: :destroy
  has_many :albums, through: :managed_albums
end
