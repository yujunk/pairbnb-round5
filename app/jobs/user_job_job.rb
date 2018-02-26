class UserJobJob < ApplicationJob
  queue_as :default

  def perform(*users)
    # Do something later
  end
end
