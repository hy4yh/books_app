# frozen_string_literal: true

class ChangeColumnToBook < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :title, :string, null: false
    change_column :books, :memo, :string, null: false
  end
end
