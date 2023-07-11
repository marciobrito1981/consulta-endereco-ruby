require 'net/http'

class AddressesController < ApplicationController

  before_action :authenticate
  before_action :save_user_zipcode

  include ActionController::HttpAuthentication::Token::ControllerMethods

    def index
        addresses = Address.all
        render json: addresses
      end
  
      def show
        address = Address.find_by(zipcode: params[:id])
        if address
          render json: address
        else
          address = search_address_from_api(params[:id])
          if address
            render json: address, status: :created
          else
            render json: { error: 'Endereço não encontrado' }, status: :not_found
          end
        end
      end
  
      private
  
      def search_address_from_api(zipcode)
        response = Net::HTTP.get_response(URI("https://viacep.com.br/ws/#{zipcode}/json/"))
        if response.is_a?(Net::HTTPSuccess)
          data = JSON.parse(response.body)
          address = Address.create(
            street: data['logradouro'],
            city: data['localidade'],
            state: data['uf'],
            zipcode: zipcode
          )
          
          return address
        end
        nil
      end
end


