class HomeController < ApplicationController
    def index
    end

    def search
        @promotions = Promotion.where('name like ? OR description like ? OR code like ?', 
                                      params[:q], params[:q], params[:q])
    end
end 