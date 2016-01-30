class AddShowIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :show_id, :integer
  end
end
