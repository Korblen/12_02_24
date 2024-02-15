class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def edit
    end

    def update
        city = City.find_or_create_by(name: user_params[:city_name])
        if @user.update(user_params.except(:city_name).merge(city: city))
            redirect_to home_path, notice: 'Votre compte a été mis à jour avec succès.'
        else
            render :edit
        end
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Inscription réussie !"
        else
          render :new
        end
    end

    private
    def set_user
        @user = User.find(session[:user_id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :description, :city_name, :age)
    end
end