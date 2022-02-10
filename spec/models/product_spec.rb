require 'rails_helper'

RSpec.describe Product, type: :model do

  test_category = Category.new(name: "Product test category")
  test_product = Product.new(name: 'test product', price_cents: 55555, quantity: 111, category: test_category)
  
  
  describe 'Validations' do

    it "valid with valid attributes" do
      expect(test_product).to be_valid
    end

    it "invalid name" do
      test_product.name = nil
      expect(test_product).to be_invalid
      expect(test_product.errors.full_messages).to include("Name can't be blank")
    end

    it "invalid price" do
      test_product.price_cents = nil
      expect(test_product).to be_invalid
      expect(test_product.errors.full_messages).to include("Price can't be blank")
    end

    it "invalid quantity" do
      test_product.quantity = nil
      expect(test_product).to be_invalid
      expect(test_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "invalid category" do
      test_product.category = nil
      expect(test_product).to be_invalid
      expect(test_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end