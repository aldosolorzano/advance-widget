require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  describe '#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
    it 'if name param empty render new template' do
      post(:create, params: {name:''})

      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    it 'post to #create Creates a new pdf ' do
      name = Faker::RickAndMorty.character
      name = name.split(' ').join('')
      post(:create, params: {name:name})
      file_path = "#{Rails.root}/public/documents/#{name}.pdf"
      expect(File).to exist(file_path)
    end
  end

end
