class PagesController < ApplicationController
  
  def show
    segments = params[:slug].to_s.split("/")

    @page = segments.reduce(nil) do |parent, slug|
      scope = parent ? parent.children : Page.roots
      scope.friendly.find(slug)
    end

  end
end
