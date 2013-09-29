class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :source_account
      t.string :destination_account
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :fee, precision: 8, scale: 2
      t.date :due_date
      t.string :fee_type

      t.timestamps
    end
  end
end
