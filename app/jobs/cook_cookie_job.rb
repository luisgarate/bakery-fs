class CookCookieJob < ApplicationJob
  queue_as :default

  def perform(cookie)
    sleep(4.minutes)
    cookie.cooked = true
    cookie.save
  end
end
