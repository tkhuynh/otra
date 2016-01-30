class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :venue
      t.date :show_date
      t.string :location
      t.integer :slots
      t.integer :host_id
      t.boolean :booked

      t.timestamps null: false
    end
  end
end
