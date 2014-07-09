class AddStateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :state, :string
  end
end
