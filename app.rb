require 'bundler'
Bundler.require

configure do
  set :notes, []
end

get '/' do
end

get '/notes' do
  settings.notes.to_json
end

post '/notes' do
  settings.notes << {
    from: params[:from_email],
    subject: params[:subject],
    body: params[:text]
  }

  nil
end
