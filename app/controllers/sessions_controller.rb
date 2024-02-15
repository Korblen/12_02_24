class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in l'utilisateur et redirige vers la page d'accueil
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Connexion réussie!'
    else
      flash.now[:alert] = 'Email ou mot de passe invalide'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path, notice: 'Déconnexion réussie!'
  end
end
