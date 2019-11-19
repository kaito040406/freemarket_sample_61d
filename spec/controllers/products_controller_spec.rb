require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
  it "renders the :new template" do
    get :new
    expect(response).to render_template :new
    end
  end
  describe 'GET #index' do
  it "renders the :index template" do
    get :index
    expect(response).to render_template :index
  end
end

    describe 'get #show' do
      it "renders the :show template" do
        product = create(:product)
        get :show, params: {  id: product }
        expect(response).to render_template :show
      end
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
  # describe 'POST #create' do
  #   let(:params) { {product: attributes_for(:product) } }
  #   it "renders the :create template" do
  #       post :create
  #       expect(response).to render_template :create
  #   end
  # end
end  