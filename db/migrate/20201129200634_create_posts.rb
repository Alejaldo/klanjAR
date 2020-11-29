class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |p|
      p.text :username
      p.text :content
      
      p.timestamps 
    end
  end
end
