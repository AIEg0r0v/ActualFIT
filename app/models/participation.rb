# == Schema Information
#
# Table name: participations
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  inspection_id :integer
#  role          :string(255)
#

class Participation < ActiveRecord::Base
  attr_accessible :role, :inspection_id, :user_id, :inspection, :user
  belongs_to :inspection
  belongs_to :user

end
