require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) {
      Category.new(id: 1, name: 'Apparel')
    }

    let(:product) {
      Product.new(name: "Men's Classy shirt", 
        price: 100,
        quantity: 30, 
        category: category)
    }

    it 'should have a valid test' do
      expect(product).to be_valid
    end

    it 'should be invalid without a name' do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should be invalid without a price' do
      product.price_cents = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should be invalid without a quantity' do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should be invalid without a category' do
      product.category = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
