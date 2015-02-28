require 'spec_helper'

describe Organization do

  describe 'schema' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_index(:name).unique(true) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:users) }
  end
end
