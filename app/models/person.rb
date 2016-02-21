class Person < ActiveRecord::Base
  def full_name
    "#{surname}, #{given_name}"
  end
end
