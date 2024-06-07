class BalanceMailer < ApplicationMailer
  def send_csv(email)
    csv = BalanceReport.generate_csv
    attachments['Balance Report.csv'] = {mime_type: 'text/csv', content: csv}
    mail(to: email, subject: 'Relatório', body: 'Balanço de usuários')
  end
end
