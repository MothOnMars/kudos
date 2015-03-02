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
  class KudoLimitError < StandardError; end

  #assumption: a user can only belong to one org
  belongs_to :organization
  has_many :sent_kudos, class_name: 'Kudo', foreign_key: 'sender_id'
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'recipient_id'

  validates_uniqueness_of :email_address
  validates_presence_of :email_address

  MAX_KUDOS_PER_WEEK = 3

  def give_kudo(recipient_id,message)
    if kudos_available > 0
      self.sent_kudos.create!(recipient_id: recipient_id, message: message)
    else
      raise KudoLimitError, "This user has already sent 3 kudos this week"
    end
  end

  def kudos_available
    MAX_KUDOS_PER_WEEK  - sent_kudos.this_week.count
  end
end
