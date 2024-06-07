class ReportsController < ApplicationController
  def balance
    email = current_user.email
    BalanceMailer.send_csv(email).deliver_later
    redirect_to root_path, notice: 'Em breve você receberá o relatório no seu e-mail'
  end
end
