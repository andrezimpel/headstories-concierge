# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview
  def constent_request(client)
    @client = client
    mail(:to => "#{client.fullname} <#{client.email}>", :subject => "Willkommen")
  end

  def appointment_conformation
    @appointment = Appointment.find(1)
    ClientMailer.appointment_conformation(@appointment)
  end
end
