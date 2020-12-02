class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |c|
      c.text :username
      c.text :content
      c.integer :post_id
      c.timestamps
    end
  end
end
