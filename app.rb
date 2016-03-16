require 'sinatra'
require_relative 'config/application'
require 'pry'

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all()
  erb :'meetups/index'
end

get '/meetups/new' do
  redirect '/auth/github' unless current_user
  erb :'meetups/new'
end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  @attendents = @meetup.users
  erb :'meetups/show'
end

get '/meetups/:id/join' do
  @meetup = Meetup.find(params[:id])
  if current_user
    current_user.join(@meetup)
  end
  erb :'meetups/join'
end

get '/meetups/:id/leave' do
  @meetup = Meetup.find(params[:id])
  current_user.leave(@meetup)
  flash[:notice] = "You have successfully left the meetup you anti-social bastard"
  erb :'meetups/show'
end

post '/meetups' do
  attributes = {"name" => params["name"],
                "details" => params["details"],
                "when" => params["when"],
                "location" => params["location"]}
  errors = ""
  attributes.each do |key, attribute|
    if attribute == "" or attribute.nil?
      # binding.pry
      if errors == ""
        errors = "You must specify a #{key}"
      else
      # binding.pry
        errors += ", #{key}"
      end
    end
  end
  errors += "\nDetails must exceed 20 characters\n" if attributes["details"].length < 20
  errors += "Name cannot exeed 100 characters\n" if attributes["name"].length > 100
  flash[:notice] = errors
  redirect '/meetups/new' unless (errors == "")
  @meetup = Meetup.create(name: attributes["name"],
                          details: attributes["details"],
                          when: attributes["when"],
                          location: attributes["location"])
  @meetup.owner = current_user
  redirect "/meetups/#{@meetup.id}"

end
