# == Schema Information
#
# Table name: chat_messages
#
#  id            :integer          not null, primary key
#  content       :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  inspection_id :integer
#

require 'spec_helper'

describe ChatMessage do
  pending "add some examples to (or delete) #{__FILE__}"
end
