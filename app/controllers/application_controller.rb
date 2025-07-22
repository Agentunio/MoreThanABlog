class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  after_action :pdfdownload

  def pdfdownload
    if request.format.html? && request.get?
      url_in = Pdf.find_by(url: request.original_url)
      if url_in.presence 
        snapshot = Pdf.create!(url: request.original_url)
        GeneratePdfJob.perform_async(snapshot.id)
        @current_snapshot = snapshot
      else
        @current_snapshot = url_in
      end
    end
  end

  private

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
