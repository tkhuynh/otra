class RemoveColumnsFromPerformances < ActiveRecord::Migration
  def change
    remove_column :performances, :host_id, :integer
    remove_column :performances, :agree, :boolean
    remove_column :performances, :show_id, :integer
    remove_column :performances, :requester_id, :integer
  end
end
