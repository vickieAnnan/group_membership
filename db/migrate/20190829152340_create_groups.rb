class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :org_name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
