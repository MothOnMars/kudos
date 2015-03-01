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

class User < ActiveRecord::Base
  #assumption: a user can only belong to one org
  belongs_to :organization
  has_many :kudos_sent, class_name: 'Kudo', foreign_key: 'sender_id'
  has_many :kudos_received, class_name: 'Kudo', foreign_key: 'recipient_id'

  validates_uniqueness_of :email_address
  validates_presence_of :email_address

  #downcase email address
end
