require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe 'schema' do
    it { should have_db_column(:firstname).of_type(:string).with_options(null: false)  }
    it { should have_db_column(:lastname).of_type(:string).with_options(null: false)  }
    it { should have_db_column(:email).of_type(:string).with_options(null: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
    it { should have_db_column(:organization_id).of_type(:integer).with_options(null: false)  }
    #scope to email?
    it { should have_db_index(:organization_id) }
    it { should have_db_index(:email).unique(true) }
  end

  describe 'validations' do
    subject { build(:user) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end

  describe 'associations' do
    it { should belong_to(:organization) }
    it { should have_many(:received_kudos) }
    it { should have_many(:sent_kudos) }
  end

  describe '#full_name' do
    let(:user) { build(:user, firstname: 'Charlie', lastname: 'Chaplin') }
    it 'returns the full name of the user' do
      expect(user.full_name).to eq('Charlie Chaplin')
    end
  end

  describe 'giving kudos' do
    subject(:give_kudo) do
      user.sent_kudos.create!(recipient: another_user, message: 'you rock!')
    end

    describe '#kudos_available' do
      it 'defaults to 3' do
        expect(user.kudos_available).to eq(3)
      end

      it 'decreases as kudos are given' do
        expect{ give_kudo }.to change{user.kudos_available}.from(3).to(2)
      end
    end

    describe '#can_send_kudo?' do
      it 'is true when the user has kudos available' do
        allow(user).to receive(:kudos_available).and_return(2)
        expect(user.can_send_kudo?).to be true
      end

      it 'is true when the user has kudos available' do
        allow(user).to receive(:kudos_available).and_return(0)
        expect(user.can_send_kudo?).to be false
      end
    end
  end
end
