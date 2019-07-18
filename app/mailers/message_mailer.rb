class MessageMailer < ApplicationMailer

	default from: 'mailcontact83@gmail.com'

	def welcome_email
		@message = params[:message]
		mail(to: 'mailcontact83@gmail.com', subject: 'Dostałeś wiadomość')
	end

end