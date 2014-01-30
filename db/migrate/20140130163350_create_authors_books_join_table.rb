class CreateAuthorsBooksJoinTable < ActiveRecord::Migration
  def change
    create_join_table :authors, :books do |t|
      t.index [:author_id, :book_id]
      t.index [:book_id, :author_id]
    end
  end
end

# Alternate syntax
# class CreateAuthorsBooksJoinTable < ActiveRecord::Migration
#   def change
#     create_table :authors_books, id: false do |t|
#       t.integer :author_id
#       t.integer :book_id
#     end
#   end
# end
