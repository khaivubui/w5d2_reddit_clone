class ChangeDescriptionColumnToAllowNull < ActiveRecord::Migration[5.1]
  def change
    change_column :subs, :description, :string, null: true
  end
end
