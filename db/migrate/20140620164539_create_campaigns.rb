class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.datetime :end_date
      t.integer :target

      t.timestamps
    end
  end
end
