require 'sinatra'
require 'pry'
require 'net/http'
require 'json'

#ADD SQL METHOD FOR INSERT TO ANY DATABASE
#ADD SQL METHOD FOR SELECT FROM ANY DATABASE
#ADD PAGES FOR BREW DAY, BREW TRACKER, BREW JUDGE
#ADD PRETTY CSS FORMATTING

CLIENT_ID = ENV["OAUTH_CLIENT_ID"]
CLIENT_SECRET = ENV["OAUTH_SECRET"]

use Rack::Session::Cookie, {
  expire_after: 2592000, secret: ENV["SESSION_SECRET"]
}

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


helpers do
  def current_user
    session[:username]
  end

  def user_signed_in?
    !current_user.nil?
  end
end


get "/sign_out" do
  session[:username] = nil
  redirect "/"
end

get "/sign_in" do
  redirect "https://github.com/login/oauth/authorize?client_id=#{CLIENT_ID}"
end

get "/auth/github" do
  uri = URI("https://github.com/login/oauth/access_token")
  res = Net::HTTP.post_form(uri, {
    "client_id" => CLIENT_ID,
    "client_secret" => CLIENT_SECRET,
    "code" => params["code"]
  })

  access_token = res.body.split("&")[0].split("=")[1]

  uri = URI("https://api.github.com/user?access_token=#{access_token}")
  res = Net::HTTP.get(uri)
  profile = JSON.parse(res)
  session[:username] = profile["login"]

  redirect "/"
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
