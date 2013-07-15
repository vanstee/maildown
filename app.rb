require 'bundler'
Bundler.require

configure do
  set :notes, []
  set :markdown, Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
end

def sendReply(email, name)
        m = Mandrill::API.new
        message = {
         :subject=> "Thanks for signing!",
         :from_name=> "Maildown",
         :text=>"Thanks for sending us a message!",
         :to=>[
               {
                :email=> email,
                :name=>  name
                }
                ],
         :html=>"<html><h1>Thanks.</h1><br/><br/>Thanks for sending us a message! Check out our logbook at <a href="http://maildown.herokuapp.com">maildown.herokuapp.com</a></html>",
         :from_email=>"sender@yourdomain.com"
        }
        sending = m.messages.send message
        puts sending

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
    body: settings.markdown.render(email['text']),
    timestamp: Time.now.to_i
  }

  nil
end
