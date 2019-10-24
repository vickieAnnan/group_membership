class SessionsController < ApplicationController
    def new
    end

    def  create
        @user = User.find_by(email:login_params[:email])
        if @user && @user.authenticate(login_params[:password])
            session[:user_id] = @user.id
            redirect_to '/groups'
        else 
            flash[:login_errors] = ['Invalid_credentials']
            redirect_to '/users'
        end
    end
    

    def destroy 
        session.clear
        redirect_to '/users'
    end

    private
        def login_params
            params.require(:login).permit(:email, :password)
        end
end
