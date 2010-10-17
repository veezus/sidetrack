class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  
  def email_notification(search_term, text)
    @recipients = search_term.email
    @subject = "[Sidetrack] New mention"
    @sent_on = Time.now
    body[:text] = text
  end
  
end
