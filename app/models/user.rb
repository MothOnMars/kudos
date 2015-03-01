# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  firstname       :string           not null
#  lastname        :string           not null
#  email_address   :string           not null
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address    (email_address) UNIQUE
#  index_users_on_organization_id  (organization_id)
#

class User < ActiveRecord::Base
  #assumption: a user can only belong to one org
  belongs_to :organization

  validates_uniqueness_of :email_address
  validates_presence_of :email_address

  #downcase email address
end
