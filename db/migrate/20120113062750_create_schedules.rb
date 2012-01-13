class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :user_id, :null => false
      t.time :reserved_at, :null => false

      t.timestamps
    end
  end
end
