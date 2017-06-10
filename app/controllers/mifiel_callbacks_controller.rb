class MifielCallbacksController < ApplicationController
 def index
   render plain: 'hola'
 end

 def create
   id = params['id']
   document = Mifiel::Document.find(id)
   file_name = document.name
   document.save_file_signed("#{Rails.root}/public/documents/signed/#{file_name}.pdf")
   document.save_xml("#{Rails.root}/public/documents/xml/#{file_name}.xml")
   byebug
 end

end
