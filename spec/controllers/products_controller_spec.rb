require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
    describe 'get #show' do
      it "renders the :show template" do
        product = create(:product)
        get :show, params: {  id: product }
        expect(response).to render_template :show
      end

    describe 'delete #destroy' do
      it "renders to root_path" do
        product = create(:product)
        delete :destroy, params: {id: product.id }
        expect(response).to redirect_to root_path
      end    
    end

    describe 'get #update' do 
      it "renders the :update template" do
        product = create(:product)
        get :update, params: {id: product}
        expect(response).to render_template :update
      end
    end
end    
