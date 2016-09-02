class ChangeColumnNullNameAndAccountnameToCoaches < ActiveRecord::Migration
  def change
    change_column_null :coaches, :name, true
    change_column_null :coaches, :account_name, false
  end
end
