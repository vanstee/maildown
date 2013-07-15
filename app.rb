require 'sinatra'

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
