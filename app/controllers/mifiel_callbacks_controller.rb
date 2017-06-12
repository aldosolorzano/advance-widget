class MifielCallbacksController < ApplicationController

 def create
   id = params['id']
   # method to fetch pdf & xml files and merge
   fetch_files(id)
 end

 private

 def fetch_files(id)
   base_path = "#{Rails.root}/public/documents"
   document  = Mifiel::Document.find(id)
   file_name = document.name
   document.save_file_signed("#{base_path}/signed/#{file_name}")
   document.save_xml("#{base_path}/xml/#{file_name}.xml")
   merge_files(file_name, base_path)
   puts "**************** FILES CREATED *******************"
 end

 def merge_files(file_name, base_path)
   original_file = "#{base_path}/original/#{file_name}"
   signed_file   = "#{base_path}/signed/#{file_name}"
   pdf           = CombinePDF.new
   pdf << CombinePDF.load(original_file) # one way to combine, very fast.
   pdf << CombinePDF.load(signed_file)
   pdf.save "#{base_path}/pdf_merge/#{file_name}"
   merge_xml_base64(file_name, original_file,base_path)
 end

 def merge_xml_base64(pdf_file_name, original_pdf_file, base_path)
   xml_file_name        = "#{pdf_file_name}.xml"
   base64_original_file = Base64.encode64(
        File.open("#{original_pdf_file}", "rb").read
      )
   @doc                 = Nokogiri::XML(
        File.open("#{base_path}/xml/#{xml_file_name}")
      )
   file                 = @doc.at_css "file"
   file.content         = "#{base64_original_file}"
   File.write("#{base_path}/xml_base64/#{xml_file_name}", @doc.to_xml)
 end

end
