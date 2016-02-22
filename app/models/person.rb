class Person < ActiveRecord::Base
  has_many :pets, inverse_of: :owner, foreign_key: 'owner_id'
  def full_name
    "#{surname}, #{given_name}"
  end
end
