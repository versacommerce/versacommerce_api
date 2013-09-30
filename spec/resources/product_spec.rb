require 'spec_helper'

describe VersacommerceAPI::Product do
  let!(:klass) { VersacommerceAPI::Product }

  before(:all) do
    initialize_session
  end

  describe 'CRUD Operations' do

    describe 'Create' do
      context 'new product' do
        context 'when invalid' do
          it 'should contains error messages' do
            new_product = klass.create(:title => 'New-Api-product')
            expect { new_product.errors.messages[:base].present? }.to be_true
          end
        end

        context 'when valid' do
          it 'should save the product' do
            new_product = klass.new(:title => 'New-Api-product', :code=>"1x Api Product")
            new_product.save.should be_true
          end
        end
      end
    end

    describe "Retrive" do
      context "when product not found" do
        it 'should raise resource not found error' do
          expect { klass.find(23456789) }.to raise_error(ActiveResource::ResourceNotFound)
        end
      end

      context "when fetching products with limit value" do
        it 'should return specified number of products' do
          products = klass.find(:all, :params => {:limit => 2})
          products.count.should eql 2
        end
      end
    end

    describe 'Update' do
      context 'for an existing product' do
        it 'should update the given product attributes' do
         product = klass.where(code: "1x Api Product").first
         product.code = '2x Api Product'
         product.save!
         expect { klass.find(product.id).code }.should eql '2x Api Product'
        end
      end
    end

    describe 'Delete' do
      before(:all) { @product = VersacommerceAPI::Product.last }

      context 'when product exist' do
        it 'should delete the specified product' do
          response = @product.destroy
          response.code.should eql '200'
        end
      end

      context 'when product does not exist' do
        it 'should raise resource not found errors' do
          expect { klass.find(23456789) }.to raise_error(ActiveResource::ResourceNotFound)
        end
      end
    end
  end
end