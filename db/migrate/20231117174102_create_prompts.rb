class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.string :name
      t.text :prompt
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
