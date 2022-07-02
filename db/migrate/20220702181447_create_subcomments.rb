class CreateSubcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :subcomments do |t|
      t.text :content
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
