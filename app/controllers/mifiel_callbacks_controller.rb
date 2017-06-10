class MifielCallbacksController < ApplicationController

 def create
   id = params['id']
   # method to fetch pdf and xml files and merge
   fetch_files(id)
 end

 private

 @base_path = "#{Rails.root}/public/documents"

 def fetch_files(id)
   document = Mifiel::Document.find(id)
   file_name = document.name
   document.save_file_signed("#{Rails.root}/public/documents/signed/#{file_name}")
   document.save_xml("#{Rails.root}/public/documents/xml/#{file_name}.xml")
   merge_files(file_name)
 end

 def merge_files(file_name)
   original_file = "#{Rails.root}/public/documents/original/#{file_name}"
   signed_file = "#{Rails.root}/public/documents/signed/#{file_name}"
   pdf = CombinePDF.new
   pdf << CombinePDF.load(original_file) # one way to combine, very fast.
   pdf << CombinePDF.load(signed_file)
   pdf.save "#{Rails.root}/public/documents/pdf_merge/#{file_name}"
 end

end
