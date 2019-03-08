class NotificationsController < ApplicationController
  def mark_as_read
    @notification = Notification.find(params[:notification_id])
    @notification.update(read_at: DateTime.now)
    head :ok
  end
end
