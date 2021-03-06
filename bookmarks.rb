require 'rubygems'
require 'sinatra'
require 'sequel'
require 'bookmark'


before do
  @message = "Bookmarks"
  @book_marks = BookMark.all
end

#list bookmarks
get '/' do
  haml :list
end

#view a bookmark
get '/bookmarks/:id' do |id|
  @book_mark = BookMark[id]
  haml :view
end

#edit a bookmark
get '/bookmarks/:id/edit' do |id|
  @book_mark = BookMark[id]
  haml :edit
  
end

#create a bookmark
post '/bookmarks/' do
  title = params[:title]
  link = params[:link]
  
  unless title == "" && link == ""
    BookMark.new do |b|
      b.title = title
      b.link = link
      b.save
    end
  end
  
  redirect '/'
end

#update a bookmark
put '/bookmarks/' do
  id = params[:id]
  unless id == ""
    title = params[:title]
    link = params[:link]
  
    unless title == "" && link == ""
      b = BookMark[id]
      b.title = title
      b.link = link
      b.save
    end
  end
  
  redirect '/' if id == ""
  redirect "/bookmarks/#{id}"
  
end

#delete a bookmark
delete '/bookmarks/' do 
  id = params[:id]
  b = BookMark[id]
  b.destroy
  redirect '/'
end

not_found do
  haml :not_found
end

#error do
#  @error = request.env['sinatra.error'].name
#  haml :error
#end


