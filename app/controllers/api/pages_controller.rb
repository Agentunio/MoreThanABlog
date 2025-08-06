module Api
  class PagesController < ApplicationController
    before_action :set_page, only: %i[ show ]
    
    def show
      if @page
        render json: PagesSerializer.new(@page).serializable_hash
      else
        render json: { error: "Page not found" }, status: :not_found
      end
    end

    private
      
      def set_page
        @page = Page.friendly.find(params[:id])
      end

  end
end