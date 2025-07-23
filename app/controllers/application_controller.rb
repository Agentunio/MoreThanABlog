class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :prepare_pdf_link
  before_action :load_nav_pages

  private

  def load_nav_pages
    @nav_pages = Page.in_nav
  end

  def prepare_pdf_link
    return unless request.format.html? && request.get?

    current_path = request.url
    pdf = Pdf.find_by(url: request.url)

    if pdf.present? && pdf.file.attached?
      @pdf = pdf.file
    else
      GeneratePdfJob.perform_async(current_path)
    end

  end


  def require_permission(privilege, strict: false)
    unless current_user&.role&.send(privilege)
      if strict
        head :forbidden
      else
        redirect_to root_path, alert: "Brak dostępu."
      end
    end
  end
end
