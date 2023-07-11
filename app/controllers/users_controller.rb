class UsersController < ApplicationController
    def create
        @user = User.create(user_params)
            render json: {user: @user}, status: :ok
    end

    def auth
        @user   = User.find_by(email: user_params[:email])
        if @user && @user.authenticate(user_params[:password])
            token = encode_token(user_email: @user.email, user_password: @user.password)
            render json: {email: params[:email], token: token}, status: :ok
        else
            render json: {error: 'Usuário ou senha invalido'}, status: :bad_request 
        end   
    end

    private

    def user_params
        params.permit(:email, :password) 
    end

end
