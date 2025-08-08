module Api
  module Admin
    class UploadsController < ActionController::API
      include Rails.application.routes.url_helpers

      before_action :authenticate_user!   # JWT
      MAX_SIZE = 15.megabytes

      def image
        file = params.require(:file)

        return render_error('Plik jest za duży')          if file.size > MAX_SIZE
        return render_error('Dozwolone są tylko zdjęcia') unless file.content_type.starts_with?('image/')

        blob = ActiveStorage::Blob.create_and_upload!(
          io:         file,
          filename:   file.original_filename,
          content_type: file.content_type
        )

        render json: { location: url_for(blob) }, status: :created
      rescue => e
        Rails.logger.error(e)
        render_error('Nie udało się zapisać pliku')
      end

      private

      def render_error(msg)
        render json: { error: msg }, status: :unprocessable_entity
      end
    end
  end
end
