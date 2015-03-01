require 'spec_helper'

describe Kudo do
  describe 'schema' do
    it { should have_db_column(:message).of_type(:string).with_options(null: false)  }
    it { should have_db_column(:recipient_id).of_type(:integer).with_options(null: false)  }
    it { should have_db_column(:sender_id).of_type(:integer).with_options(null: false)  }
    #scope to email?
    it { should have_db_index(:sender_id) }
    it { should have_db_index(:recipient_id) }
  end

  describe 'validations' do
    subject { build(:kudo) }
    it { should validate_presence_of(:message) }
  end

  describe 'associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:recipient) }
  end
end
