class GossipsController < ApplicationController
    before_action :set_gossip, only: [:show, :edit, :update, :destroy]
    before_action :check_user, only: [:edit, :update, :destroy]
    def show
        @gossip = Gossip.find(params[:id])
        @user = @gossip.user
        rescue ActiveRecord::RecordNotFound
            flash[:alert] = "Le potin que vous cherchez n'existe pas."
            redirect_to root_path
    end

    def new
        if session[:user_id]
            @gossip = Gossip.new
        else
            redirect_to login_path
        end
    end

    def create
        if session[:user_id]
        @gossip = Gossip.new(gossip_params)
        @gossip.user = User.find(session[:user_id])
      
            if @gossip.save
                redirect_to home_path, notice: 'Votre potin a été créé avec succès.'
            else
                render :new
            end
        else
            redirect_to login_path, alert: 'Vous devez être connecté pour créer un potin.'
        end
    end

    def edit
        @gossip = Gossip.find(params[:id])
    end
    
    def update
        @gossip = Gossip.find(params[:id])
        if @gossip.update(gossip_params)
          redirect_to @gossip, notice: 'Potin bien mis à jour !'
        else
          render :edit
        end
    end

    def destroy
        @gossip = Gossip.find(params[:id])
        @gossip.comments.destroy_all
        @gossip.delete
        redirect_to gossips_path, notice: 'Potin supprimé avec succès.'
    end
    
    private
    
    def gossip_params
        params.require(:gossip).permit(:title, :content, :tag).tap do |gossip_params|
            raise ActionController::ParameterMissing.new("Title cannot be blank") if gossip_params[:title].blank?
            raise ActionController::ParameterMissing.new("Content cannot be blank") if gossip_params[:content].blank?
        end
    end

    def set_gossip
        @gossip = Gossip.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Le potin que vous cherchez n'existe pas."
        redirect_to root_path
    end

    def check_user
        unless current_user == @gossip.user
          redirect_to gossips_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
        end
    end
end