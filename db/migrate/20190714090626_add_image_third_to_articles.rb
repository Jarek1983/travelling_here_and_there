class AddImageThirdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_third, :string
  end
end
