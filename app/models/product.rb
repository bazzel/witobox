class Product < ActiveRecord::Base

  # === Named scopes
  #
  named_scope(:for_sale, :conditions => {:sold => false})
end
