class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  before_action :authenticate_user!

  def image
    max_size = 15.megabytes
    file = params[:file]
  
    if file.size > max_size
      return render json: { error: 'Plik jest za duży' }, status: :unprocessable_entity
    end

    unless file.content_type.start_with?('image/')
      return render json: { error: 'Dozwolone są tylko zdjęcia' }, status: :unprocessable_entity
    end

    if file.present?
      blob = ActiveStorage::Blob.create_and_upload!(
        io: params[:file],
        filename: params[:file].original_filename,
        content_type: params[:file].content_type
      )

      render json: { location: url_for(blob) }
    else
      render json: { error: "Brak pliku" }, status: :unprocessable_entity
    end
  end
end
