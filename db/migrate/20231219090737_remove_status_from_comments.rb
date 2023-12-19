class RemoveStatusFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :status, :string
  end
end
