class CommentsController < ApplicationController
    def create
      if session[:user_id]
        @gossip = Gossip.find(params[:gossip_id])
        @comment = @gossip.comments.build(comment_params)
        @comment.user = User.find_by(id: session[:user_id])  
      
        if @comment.save
          redirect_to @gossip, notice: 'Commentaire ajouté.'
        else
          render 'gossips/show'
        end
      else
        redirect_to login_path, alert: 'Vous devez être connecté pour créer un potin.'
      end
    end

    def edit
      @gossip = Gossip.find(params[:gossip_id])
      @comment = @gossip.comments.find(params[:id])
    end
   
    def update
      @gossip = Gossip.find(params[:gossip_id])
      @comment = @gossip.comments.find(params[:id])
      if @comment.update(comment_params)
        redirect_to @gossip, notice: 'Commentaire mis à jour avec succès.'
      else
        render :edit
      end
    end

    def destroy
      @gossip = Gossip.find(params[:gossip_id])
      @comment = @gossip.comments.find(params[:id])
      @comment.delete
      redirect_to @gossip, notice: 'Commentaire supprimé avec succès.'
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content, :user, :gossip)
    end
  end