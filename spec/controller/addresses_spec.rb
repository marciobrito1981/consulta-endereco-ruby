require 'rails_helper'

describe AddressesController, type: :controller do
    it 'request index without token and return 401' do
        get :index 
        expect(response).to have_http_status(:unauthorized)  
    end


end
