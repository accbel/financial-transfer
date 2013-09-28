class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :source_account
      t.string :destination_account
      t.decimal :amount
      t.decimal :fee
      t.date :due_date
      t.string :type

      t.timestamps
    end
  end
end
