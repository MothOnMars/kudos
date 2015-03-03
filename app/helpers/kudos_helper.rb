module KudosHelper

  def kudos_call_to_action
    if @current_user.can_send_kudo?
      @kudo = @current_user.sent_kudos.new
      render partial: 'kudos/new'
    else
      render partial: 'kudos/next_week'
    end
  end
end
