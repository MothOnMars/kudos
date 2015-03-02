require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

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
    it { should have_many(:received_kudos) }
    it { should have_many(:sent_kudos) }
  end

  describe 'giving kudos' do
    subject(:give_kudo) { user.give_kudo(another_user.id, 'you rock!') }

    describe '#give_kudo' do
      it 'gives a kudo to the specified user' do
        expect{ give_kudo }.to change{another_user.received_kudos.count}.from(0).to(1)
      end

      it 'includes the correct message' do
        give_kudo
        expect( another_user.received_kudos.first.message ).to eq('you rock!')
      end

      it 'only allows 3 kudos to be given per week' do
        3.times { user.give_kudo(another_user.id, 'you rock!') }
        expect{ give_kudo }.to raise_error(User::KudoLimitError, /user has already sent/)
      end
    end

    describe '#kudos_available' do
      it 'defaults to 3' do
        expect(user.kudos_available).to eq(3)
      end

      it 'decreases as kudos are given' do
        expect{ give_kudo }.to change{user.kudos_available}.from(3).to(2)
      end
    end
  end
end
