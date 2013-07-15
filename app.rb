require 'sinatra'

configure do
  set :notes, []
end

get '/' do
end

get '/notes' do
  %(
    {
      "notes": [
        {
          "from": "vanstee@bignerdranch.com",
          "subject": "This s a test",
          "body": "Testing the markdown stuffs. <b>Bold</b> <i>Fancy</i>"
        }
      ]
    }
  )
end

post '/notes' do
  settings.notes << {
    from: params[:from_email],
    subject: params[:subject],
    body: params[:text]
  }

  nil
end
