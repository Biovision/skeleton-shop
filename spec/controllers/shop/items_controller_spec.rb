require 'rails_helper'

RSpec.describe Shop::ItemsController, type: :controller, focus: true do
  context 'when order_id is not set in session' do
    describe 'post create' do
      it 'creates new order'
      it 'calls order#add_item'
      it 'redirects to item page'
    end

    describe 'delete destroy' do
      it 'creates new order'
      it 'calls order#remove_item'
      it 'redirects to item page'
    end
  end

  context 'when order_id is set in session' do
    describe 'post create' do
      it 'calls order#add_item'
      it 'redirects to item page'
    end
    
    describe 'delete destroy' do
      it 'calls order#remove_item'
      it 'redirects to item page'
    end
  end
end
