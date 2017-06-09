class SignsController < ApplicationController

  def show
    file_path = "#{Rails.root}/public/documents/#{params[:file_name]}.pdf"
    @pdf_encoded = Base64.encode64(File.open("#{file_path}", "rb").read)
  end
end
