class AddImageFifthToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_fifth, :string
  end
end
