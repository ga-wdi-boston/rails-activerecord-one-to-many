class Pet < ActiveRecord::Base
  belongs_to :owner, inverse_of: :pets, class_name: 'Person'
end
