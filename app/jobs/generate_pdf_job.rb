class GeneratePdfJob
  include Sidekiq::Job
  sidekiq_options queue: :pdf, lock: :until_executed
  
  def perform(url)
    pdf = Pdf.find_or_create_by!(url: url) 

    return if pdf.file.attached?           

    pdf.with_lock do                     
      return if pdf.file.attached?

      pdf_data = Grover.new(url).to_pdf
      pdf.file.attach(
        io: StringIO.new(pdf_data),
        filename: "#{url}.pdf",
        content_type: "application/pdf"
      )
    end
  rescue ActiveRecord::RecordNotUnique
  end



end