require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  describe 'get #show' do
    it "renders the :show template" do
      product = create(:product)
      get :show, params: {  id: product }
      expect(response).to render_template :show
    end
  end
end
