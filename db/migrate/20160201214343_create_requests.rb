class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :status
      t.integer :requester_id
      t.integer :show_id
      t.integer :performance_id

      t.timestamps null: false
    end
  end
end
