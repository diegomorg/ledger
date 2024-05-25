class Dashboard
  def initialize(user)
    @user = user
  end

  def active_people_pie_chart
    {
      active: active_people_count,
      inactive: inactive_people_count
    }
  end

  def total_debts
    Rails.cache.fetch("dash__total_debts", expires_in: 5.minutes) do
      Debt.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def total_payments
    Rails.cache.fetch("dash__total_payments", expires_in: 5.minutes) do
      Payment.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def balance
    total_payments - total_debts
  end

  def last_debts
    Rails.cache.fetch("dash__last_debts", expires_in: 5.minutes) do
      Debt.order(created_at: :desc).limit(10).map do |debt|
        [debt.id, debt.amount]
      end
    end
  end

  def last_payments
    Rails.cache.fetch("dash__last_payments", expires_in: 5.minutes) do
      Payment.order(created_at: :desc).limit(10).map do |payment|
        [payment.id, payment.amount]
      end
    end
  end

  def my_people
    Rails.cache.fetch("dash__my_people", expires_in: 5.minutes) do
      Person.where(user: @user).order(:created_at).limit(10)
    end
  end

  def top_person
    Rails.cache.fetch("dash__top_person", expires_in: 5.minutes) do
      Person.order(:balance).last
    end
  end

  def bottom_person
    Rails.cache.fetch("dash__bottom_person", expires_in: 5.minutes) do
      Person.order(:balance).first
    end
  end

  private

  def active_people_count
    Rails.cache.fetch("dash__active_people_count", expires_in: 5.minutes) do
      Person.actives.count
    end
  end

  def inactive_people_count
    Rails.cache.fetch("dash__inactive_people_count", expires_in: 5.minutes) do
      Person.inactives.count
    end
  end

  def active_people_ids
    Rails.cache.fetch("dash__active_people_ids", expires_in: 5.minutes) do
      Person.actives.select(:id)
    end
  end
end
