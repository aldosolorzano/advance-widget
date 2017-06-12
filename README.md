# README

## Dependencies
  * Ruby 2.3
  * Rails 5
  * Ngrok
  * postgreSQL 9

## Installation

Bundle ruby gems:
```
 $ bundle install
```  
Database creation:
```
 $ rails/rake db:create
```
Create a app_keys.rb file inside the initializers folder
``` ruby
ENV['MIFIEL_APP_ID'] = 'put your mifiel_id'
ENV['MIFIEL_APP_SECRET'] = 'put your mifiel_secret'
```
How to run the test suite:
```
  $ rails s  
  $ ngrok http 3000
```  
Got to documents_controller.rb
```ruby
# change the ngrok_url variable to your ngrok url 

 def create_mifiel_doc(file_path,file_name)
   ngrok_url     = 'https://77cf18b7.ngrok.io' # change this line
   file_contents = File.read(file_path)
   hash          = Digest::SHA256.hexdigest(file_contents)
   document      = Mifiel::Document.create(
      hash: hash,
      name: "#{file_name}.pdf",
      signatories: [{
        email: 'jeff@email.com',
        tax_id: 'PRUE890723KLI'
      }],
      callback_url: "#{ngrok_url}/mifiel/docs/callback"
     )
   document
 end
```
After signing the document, check your server logs to see the POST call from the Mifiel servers.
```
 You can find your documents inside: public/documents folder
```

