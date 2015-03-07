require 'sinatra'
# require 'sinatra/flash'
require 'pry'
require 'csv'

enable :sessions

#ADD SQL METHOD FOR INSERT TO ANY DATABASE
#ADD SQL METHOD FOR SELECT FROM ANY DATABASE
#ADD PAGES FOR BREW DAY, BREW TRACKER, BREW JUDGE
#ADD PRETTY CSS FORMATTING

def db_connection(db_name)
  begin
    connection = PG.connect(dbname:db_name)
    yield(connection)
  ensure
    connection.close
  end
end

def sql_insert(db_name, *)
  conn.exec_params("INSERT INTO db_name VALUES ")
end

def sql_select(db_name, *)
  conn.exec("SELECT value FROM db_name")
end

get '/' do
  erb :home_page
end

# get '/RecipeMaker' do
#   recipe_array = db_connection {|conn| conn.exec("SELECT * FROM ")}
#   erb :recipe_maker, locals: { recipe_array: recipe_array}
# end
#
# post '/RecipeMaker' do
#   db_connection do |conn|
#     conn.exec_params ("INSERT INTO ")
#     end
#   redirect '/RecipeMaker'
# end
