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
    subject(:kudo) { build(:kudo) }
    it { should validate_presence_of(:message) }

    it 'is invalid if the user cannot send kudos' do
      kudo.sender.stub(:can_send_kudo?).and_return(false)
      expect(kudo).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:recipient) }
  end

  describe 'scopes' do
    describe '.this_week' do

      let!(:recent_kudo) { create(:kudo) }
      let!(:old_kudo) { create(:kudo, created_at: 2.weeks.ago) }

      it 'includes kudos created in current work week' do
        expect(Kudo.this_week).to include(recent_kudo)
      end

      it 'does not include kudos created before the current work week' do
        expect(Kudo.this_week).to_not include(old_kudo)
      end
    end
  end
end
