class GeneratePdfJob
  include Sidekiq::Job

  def perform(*args)
    snapshot = Pdf.find(snapshot_id)

    pdf = Grover.new(snapshot.url, print_background: true).to_pdf

   snapshot.file.attach(
      io: StringIO.new(pdf),
      filename: "#{snapshot.url}.pdf",
      content_type: 'application/pdf'
    )

    snapshot.update!(status: :done)

  rescue => e
    snapshot.update!(status: :failed)
    Rails.logger.error("PDF failed: #{e.message}")

  end
end