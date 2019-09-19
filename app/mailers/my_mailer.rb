class MyMailer < ApplicationMailer
  default to: -> {"s3697652@student.rmit.edu.au, s3701799@student.rmit.edu.au"},
          from: "s3697652@student.rmit.edu.au",
          subject: "YourBook Contact Us"

  layout "mailer"

  def contact_us(contact)
    @contact = contact
    mail
  end
end