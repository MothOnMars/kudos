require 'spec_helper'

describe User do
  describe 'schema' do
    it { should have_db_column(:firstname).of_type(:string) }
    it { should have_db_column(:lastname).of_type(:string) }
    it { should have_db_column(:email_address).of_type(:string) }
    it { should have_db_column(:organization_id).of_type(:integer) }
    #scope to email?
    it { should have_db_index(:organization_id) }
    it { should have_db_index(:email_address).unique(true) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:email_address) }
  end

  describe 'associations' do
    it { should belong_to(:organization) }
  end
end

class User < ActiveRecord::Base
  #assumption: a user can only belong to one org
  belongs_to :organization

  validates_uniqueness_of :email_address

  #downcase email address
end
