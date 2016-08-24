class Supermemo

  def self.success_efactor(counter, efactor)
    success_calc(counter, 5, efactor)
  end

  def self.misprint_efactor(counter, efactor)
    success_calc(counter, 3, efactor)
  end

  def self.failed_efactor(counter, efactor)
    if efactor < 2
      efactor = 1
    else
      efactor -= 2
    end
    review_date = renew_interval(counter, efactor)
    counter += 1
    options = {review_date: review_date, efactor: efactor, counter: counter}
  end

  def self.success_calc(counter, quality, efactor)
    efactor = calculate_efactor(quality, efactor)
    review_date = renew_interval(counter, efactor)
    counter += 1
    options = {review_date: review_date, efactor: efactor, counter: counter}
  end

  def self.calculate_efactor(quality, efactor)
    efactor = efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
  end

  def self.renew_interval(counter, efactor)
    review_date = Time.current + case counter
          when 1
            1.day
          when 2
            6.days
          else
            ((counter - 1) * efactor).round.days
      end
    review_date = review_date.strftime("%d/%m/%Y")
  end

end