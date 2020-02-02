class AuthenticationController < ApplicationController
    before_action :authenticate_user, :only => [:set_account_info, :account_settings, :signed_out]

    def sign_in
        @user = User.new
    end

    def login
        email = params[:user][:email]
        password = params[:user][:password]
    
        user = User.authenticate(email, password)

        if user
            session[:user_id] = user.id
            flash[:info] = 'Successfully logged in.'
            redirect_to :root
        else
            flash[:error] = 'Email or password incorrect.'
            redirect_to :sign_in
        end
    end

    def signed_out
        session[:user_id] = nil
        flash[:info] = "You have been signed out."
        redirect_to :root
    end

    def account_settings
        @user = current_user
    end

    def set_account_info
        old_user = current_user

        @user = User.authenticate(old_user.email, params[:user][:password])

        if @user.nil?
            @user = current_user
            @user.errors[:password] = 'Password is incorrect.'
            render :action => 'account_settings'
        else
            @user.previous_email = old_user.email
            @user.previous_username = old_user.username
            @user.update(user_params)
        
            if @user.valid?
                @user.password = @user.new_password unless @user.new_password.nil? || @user.new_password.empty?
                @user.save
                flash[:info] = 'Account settings have been changed.'
                redirect_to :root
            else
                render :action => 'account_settings'
            end
        end
    end

    def new_user
        @user = User.new
    end
    
    def register
        @user = User.new(user_params)
      
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            flash[:notice] = 'Welcome.'
            redirect_to :root
        else
            render :action => "new_user"
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :salt, :avatar, :bio, :encrypted_password, :new_password, :new_password_confirmation)
        end
end
