class AddPositionToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :position, :integer
  end
end
