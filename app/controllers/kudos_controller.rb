class KudosController < ApplicationController
  def index
    @sent_kudos = current_user.sent_kudos.includes(:recipient)
    @received_kudos = current_user.received_kudos.includes(:sender)
    @kudo = @current_user.sent_kudos.new
  end

  def create
    organization = current_user.organization
    recipient = organization.users.find_by_email(params['email'])
    if recipient.present?
      current_user.sent_kudos.create!(recipient: recipient,
                                      message: params['kudo']['message'])
      flash[:success] = "Your kudo was sent!"
    else
      flash[:error] = "Unable to find a user with that email address"
    end
    redirect_to root_url
  end
end
