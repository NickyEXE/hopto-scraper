class CreateCancels < ActiveRecord::Migration[7.0]
  def change
    create_table :cancels do |t|
      t.integer :canceller_id
      t.integer :cancellee_id

      t.timestamps
    end
  end
end
