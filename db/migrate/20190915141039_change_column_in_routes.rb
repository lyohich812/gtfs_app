class ChangeColumnInRoutes < ActiveRecord::Migration[5.1]
  def change
    change_column :routes, :agency_id, :string
  end
end
