require 'spec_helper'

describe VersacommerceAPI::Order do
  let!(:klass) { VersacommerceAPI::Order }

  before(:all) do
    initialize_session
  end

  describe 'CRUD Operations' do

    describe 'Create' do
      context 'New Order' do
        context 'when order is valid' do
          it 'should place a new order' do
          end
        end

        context 'when order is invalid' do
          it 'should raise error' do
          end
        end
      end
    end

    describe 'Retrive' do
      context 'when order does not exist' do
        it 'should raise error' do
        end
      end

      context 'when order exist' do
        it 'should return the order' do
        end
      end
    end

    describe 'Update' do
      context 'for existing order' do
        it 'should update the attributes of the order' do
        end
      end
    end

    describe 'delete' do
      context 'when order does not exist' do
        it 'should raise error' do
        end
      end

      context 'when order exist' do
        it 'should delete the order' do
        end
      end
    end
  end

end