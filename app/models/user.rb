# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  firstname          :string           not null
#  lastname           :string           not null
#  email              :string           not null
#  organization_id    :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string           default(""), not null
#

class User < ActiveRecord::Base
  devise :database_authenticatable

  #assumption: a user can only belong to one org
  belongs_to :organization
  has_many :sent_kudos, class_name: 'Kudo', foreign_key: 'sender_id'
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'recipient_id'

  validates_uniqueness_of :email
  validates_presence_of :email

  delegate :org_name, to: :organization

  MAX_KUDOS_PER_WEEK = 3

  def full_name
    "#{firstname} #{lastname}"
  end

  def kudos_available
    MAX_KUDOS_PER_WEEK - sent_kudos.this_week.count
  end

  def can_send_kudo?
    kudos_available > 0
  end
end
