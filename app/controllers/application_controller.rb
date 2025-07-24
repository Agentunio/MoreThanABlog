class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :prepare_pdf_link
  before_action :load_nav_pages

  private

  def load_nav_pages
    @nav_pages = Page.roots.in_nav.order(:title)
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
end
