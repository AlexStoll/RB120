# medium_2.rb

class InvoiceEntry
  attr_reader :product_name, :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

thing = InvoiceEntry.new('apples', 10)
thing.update_quantity(20)
p thing.quantity