require 'spec_helper'

describe KudosController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    sign_in user
  end

  describe 'routing' do
    it { should route(:get, '/').to(action: :index) }
  end


  describe '#index' do
    before { get :index }

    it { should respond_with(200) }
  end

  describe '#create' do
  end
end
