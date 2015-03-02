# == Schema Information
#
# Table name: kudos
#
#  id           :integer          not null, primary key
#  message      :string           not null
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Kudo < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :message, :sender_id, :recipient_id

  #assumption: number of kudos is per week starting Monday, not within 7 days
  scope :this_week , lambda { where('created_at > ?', Time.now.at_beginning_of_week) }
end
