class ClientMailer < ApplicationMailer
  default :from => "head stories concierge <concierge@hedstories.de>"

  def constent_request(client)
    @client = client
    mail(:to => "#{client.fullname} <#{client.email}>", :subject => "Willkommen")
  end
end
