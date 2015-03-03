class KudosController < ApplicationController
  def index
    @sent_kudos = current_user.sent_kudos
    @received_kudos = current_user.received_kudos
  end

  def new
  end

  def create
    organization = current_user.organization
    recipient = organization.users.find_by_email(params['email'])
    current_user.sent_kudos.create!(recipient: recipient, message: params['kudo']['message'])
    flash[:success] = "Your kudo was sent!"
    redirect_to root_url
  end
end
