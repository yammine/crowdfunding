class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
