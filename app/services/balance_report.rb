require 'csv'

class BalanceReport
  def self.generate_csv
    Tempfile.new(["export_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_balance_report", '.csv']).tap do |file|
      CSV.open(file, 'wb') do |csv|
        csv << %w[Nome E-mail Balanço Ativo]

        Person.joins(:user).select(:name, 'users.email', :balance, :active).each do |u|
          csv << [
            u.name,
            u.email,
            u.balance,
            u.active
          ]
        end
      end
    end
  end
end
