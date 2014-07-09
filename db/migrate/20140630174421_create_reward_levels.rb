class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|
      t.string :name
      t.integer :amount
      t.text :details
      t.references :campaign, index: true

      t.timestamps
    end
  end
end
