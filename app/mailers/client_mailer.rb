class ClientMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  
  default :from => "head stories concierge <concierge@hedstories.de>"

  def constent_request(client)
    @client = client
    mail(:to => "#{client.fullname} <#{client.email}>", :subject => "Willkommen")
  end

  def appointment_conformation(appointment)
    @appointment = appointment
    @client = @appointment.client
    mail(:to => "#{@client.fullname} <#{@client.email}>", :subject => "Bestätigung")
  end
end
