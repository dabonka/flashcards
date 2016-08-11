class AddCountersToCards < ActiveRecord::Migration
  def change
    add_column :cards, :level,        :integer, default: 0
    add_column :cards, :fail_counter, :integer, default: 0
  end
end
