class CreateRfcs < ActiveRecord::Migration[6.1]
  def change
    create_table :rfcs do |t|
      t.string :key,    null: false, uniq: true
      t.integer :count, null: false, default: 1

      t.timestamps
    end
  end
end
