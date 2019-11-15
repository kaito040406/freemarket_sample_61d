require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
    # describe 'get #show' do
    #   it "renders the :show template" do
    #     product = create(:product)
    #     get :show, params: {  id: product }
    #     expect(response).to render_template :show
      # end

    # describe 'delete #destroy' do
    #   it "renders to root_path" do
    #     product = create(:product)
    #     delete :destroy, params: {id: product.id }
    #     expect(response).to redirect_to root_path
    #   end    
    # end

  describe 'get #update' do 
    let(:login_user) { user_a }
   context 'login' do 
      before do
        visit edit_product_path(product_id)
        fill_in 'update', with: 'edit'
        click_button 'update'
      end

      it 'renders to root_path' do 
        expect(response).to have_content 'edit'
      end
    end
  end
end
