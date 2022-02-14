class TransactionCategory < ActiveRecord::Base
  has_many :subcategories, :class_name => "TransactionCategory", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "TransactionCategory", :optional => true

  def default
    return TransactionCategory.find(category: 'Uncategorized')
  end
end
