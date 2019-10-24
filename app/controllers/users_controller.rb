class UsersController < ApplicationController

    def index

    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:id] = @user.id
            flash[:messages] = ['Succesfully created']
            redirect_to '/users'
        else
            
            flash[:register_errors] = @user.errors.full_messages
            redirect_to '/users'
            
        end   
    end
    

    def login
        @user = User.find_by_email(params[:email])
        if @user.nil?
            flash[:errors] = ['User does not exist']
            redirect_to '/users'
        else
            if @user.password == params[:password]
                session[:id] = @user.id
                redirect_to '/groups'
            else
                flash[:errors] = ['Email/Password does not match']
                redirect_to '/users'
            end
        end

    end



    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password)
        end

end
