class AddUniqueIndexToTagLabel < ActiveRecord::Migration
  def change
    change_column_null :tags, :label, false
    add_index :tags, :label, unique: true
  end
end
