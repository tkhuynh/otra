class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :status
      t.integer :requester_id
      t.date :performance_date
      t.string :location
      t.integer :band_id
      t.integer :tour_id
      t.integer :host_id
      t.boolean :agree

      t.timestamps null: false
    end
  end
end
