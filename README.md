# README

## Dependencies
  * Ruby 2.3.1
  * Rails 5.0.2
  * Ngrok

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
Got to documents_controller.rb
```ruby
# change the callback_url 

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
    callback_url: 'put ngrok link'
   )
   document
 end
```
How to run the test suite:
```
  $ rails s  
  $ ngrok http 3000
```  


