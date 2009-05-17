#DB = Sequel.sqlite # in memory 
DB = Sequel.sqlite('./db/booky.db')

unless DB.table_exists? :book_marks
  DB.create_table :book_marks do
    primary_key :id
    varchar :title
    varchar :link
  end
  
  # populate the table
  DB[:book_marks].insert(:title => 'GitHub', :link => "http://github.com" )
  DB[:book_marks].insert(:title => 'Yahoo', :link => "http://yahoo.com")
  DB[:book_marks].insert(:title => 'Google', :link => "http://google.com")
  
end

class BookMark < Sequel::Model
end
