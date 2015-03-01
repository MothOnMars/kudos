require 'spec_helper'

describe User do
  describe 'schema' do
    it { should have_db_column(:firstname).of_type(:string).with_options(null: false)  }
    it { should have_db_column(:lastname).of_type(:string).with_options(null: false)  }
    it { should have_db_column(:email_address).of_type(:string).with_options(null: false) }
    it { should have_db_column(:organization_id).of_type(:integer).with_options(null: false)  }
    #scope to email?
    it { should have_db_index(:organization_id) }
    it { should have_db_index(:email_address).unique(true) }
  end

  describe 'validations' do
    subject { build(:user) }
    it { should validate_uniqueness_of(:email_address) }
    it { should validate_presence_of(:email_address) }
  end

  describe 'associations' do
    it { should belong_to(:organization) }
  end
end
