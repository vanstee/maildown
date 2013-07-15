require 'bundler'
Bundler.require

configure do
  set :notes, []
end

get '/' do
end

get '/notes' do
  { notes: settings.notes }.to_json
end

post '/notes' do
  email = JSON.parse(params['mandrill_events']).first['msg']

  settings.notes << {
    from: email['from_email'],
    subject: email['subject'],
    body: email['text']
  }

  nil
end
