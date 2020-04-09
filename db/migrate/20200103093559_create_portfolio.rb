class CreatePortfolio < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :portfolioname
      t.integer :user_id
    end
  end
end
