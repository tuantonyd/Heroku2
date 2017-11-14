class ContactForm < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message
  validates_presence_of :name, :email, :message

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Oliver Heart Contact Form Submission" ,
      :to => "oliver.heart.gifts@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
