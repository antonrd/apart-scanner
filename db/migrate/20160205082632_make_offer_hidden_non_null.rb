class MakeOfferHiddenNonNull < ActiveRecord::Migration
  def change
    change_column_null(:offers, :hidden, false)
    change_column_default(:offers, :hidden, false)
  end
end
