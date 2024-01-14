class ChangeCustomerIdToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :snacks, :customer_id, true
  end 
  def down
    change_column_null :snacks, :customer_id, false
  end
end
