require 'spec_helper'

describe VersacommerceAPI::Product do
  let!(:klass) { VersacommerceAPI::Product }

  before do
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
            expect { new_product.save! }.to be_true
          end
        end
      end
    end

    describe "Retrive" do
      context "when product not found" do
        it 'should raise error' do
          expect {klass.find(23456789) }.to raise_error
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
    end

    describe 'Delete' do
    end
  end

end