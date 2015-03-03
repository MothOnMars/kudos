require 'spec_helper'

describe ApplicationController do
  it { should use_before_filter(:authenticate_user!) }
end
