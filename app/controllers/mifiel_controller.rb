class MifielController < ApplicationController
 def index
   documents = Mifiel::Document.all
 end

end
