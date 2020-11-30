class AddImageFourthToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_fourth, :string
  end
end
