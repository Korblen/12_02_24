class StaticPagesController < ApplicationController
    def team
    end
  
    def contact
    end

    def home
    end

    def welcome
        @first_name = params[:first_name]
    end
end