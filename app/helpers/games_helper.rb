module GamesHelper
  def games_status(status_number)
    case status_number
    when 0
      "未開打"
    when 1
      "進行中"
    when 2
      "結束"
    when 3
      "延賽"
    end
  end
end
