# == Schema Information
#
# Table name: artifacts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  comment       :string(255)
#  inspection_id :integer
#  file          :binary(52428800)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  filename      :string(255)
#  content_type  :string(255)
#  user_id       :integer
#

require 'spec_helper'

describe Artifact do
  it "is valid with a name, file, user_id, inspection id, filename and content_type"
  it "is invalid without a name"
  it "is invalid without a file"
  it "is invalid without a filename"
  it "is invalid without a user_id"
  it "is invalid without a inspection_id"
  it "is invalid without a content_type"
end
