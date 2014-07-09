class AddStateToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :state, :string
  end
end
