require 'mail'

Mail.defaults do
  delivery_method :smtp, {
      :port      => 587,
      :address   => "smtp.mailgun.org",
      :user_name => "postmaster@91.241.170.153",
      :password  => ENV["MAILGUN_ACCESS_PASSWORD"]
  }
end

mail = Mail.deliver do
  to      'bar@example.com'
  from    'foo@mail.ru'
  subject 'Hello'

  text_part do
    body 'Testing some Mailgun awesomness'
  end
end