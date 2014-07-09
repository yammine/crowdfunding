class AddSlugToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :slug, :string
    add_index :campaigns, :slug
  end
end
