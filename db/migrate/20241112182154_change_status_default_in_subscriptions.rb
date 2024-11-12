class ChangeStatusDefaultInSubscriptions < ActiveRecord::Migration[7.1]
  def change
    change_column_default :subscriptions, :status, 0
    change_column_null :subscriptions, :status, false
  end
end
