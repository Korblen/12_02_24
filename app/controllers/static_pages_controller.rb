class StaticPagesController < ApplicationController
    def team
    end
  
    def contact
    end

    def home
        @gossips = Gossip.all
    end

    def welcome
        @first_name = params[:first_name]
    end

end