class GeneratePdfJob
  include Sidekiq::Job
  sidekiq_options queue: :pdf 
  
  def perform(url)
    return if Pdf.exists?(url: url)
    
    pdf_data = Grover.new(url).to_pdf

    pdf_record = Pdf.create!(url: url) 

    pdf_record.file.attach(
      io: StringIO.new(pdf_data),
      filename: "#{url}.pdf",
      content_type: "application/pdf"
    )
  end


end