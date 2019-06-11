# medium_3.rb

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

apples = InvoiceEntry.new('apples', 50)
apples.update_quantity(1)
p apples.quantity = 5
p apples.quantity