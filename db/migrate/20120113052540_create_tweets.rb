class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id, :null => false
      t.string :text, :null => false, :limit => 140

      t.timestamps
    end
  end
end
