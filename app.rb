require 'bundler'
Bundler.require

configure do
  set :notes, []
  set :markdown, Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
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
    body: markdown.render(email['text'])
  }

  nil
end
