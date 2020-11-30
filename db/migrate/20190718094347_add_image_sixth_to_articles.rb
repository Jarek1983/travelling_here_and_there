class AddImageSixthToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_sixth, :string
  end
end
