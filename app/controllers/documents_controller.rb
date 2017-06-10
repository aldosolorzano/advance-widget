class DocumentsController < ApplicationController

 def create
     file_name = params[:name]
     if file_name.empty?
       alert_user("Name can't be blank")
       render :new
       return
     else
      #  method to create pdf file and mifiel doc
       document = create_pdf(file_name)
       widget_id = Mifiel::Document.all.last.signers.first.widget_id
       if document.nil? then alert("Couldn't save document") end

       redirect_to sign_path(widget_id,{file_name:file_name})
     end
 end

 private
 def create_pdf(file_name)
   # Load the html to convert to PDF
   html = File.read("#{Rails.root}/public/example.html")
   # Create a new kit and define page size to be US letter
   kit = PDFKit.new(html, :page_size => 'Letter')
   # create file path
   file_path = "#{Rails.root}/public/documents/original/#{file_name}.pdf"
   # Save the html to a PDF file
   if kit.to_file(file_path)
      create_mifiel_doc(file_path,file_name)
   else
      nil
   end
 end

 def create_mifiel_doc(file_path,file_name)
   file_contents = File.read(file_path)
   hash = Digest::SHA256.hexdigest(file_contents)
   document = Mifiel::Document.create(
    hash: hash,
    name: "#{file_name}.pdf",
    signatories: [{
      email: 'jeff@email.com',
      tax_id: 'PRUE890723KLI'
    }],
    callback_url: 'https://b1ae1168.ngrok.io/mifiel/docs/callback'
   )
   document
 end

 def alert_user(message)
   flash[:alert] = message
 end

end
