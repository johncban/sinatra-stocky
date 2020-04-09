class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t| 
      t.integer :portfolio_id
      t.integer :user_id
      t.string :stock
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
