require 'bundler'
Bundler.require
require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals:{ideas: IdeaStore.all}
  end
 
  not_found do
    erb :error
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end
  
  

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end
  
  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end
  
  

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end
  
  
  
  
  
end
