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
#

class Artifact < ActiveRecord::Base
  attr_accessible :comment, :inspection_id, :name
  belongs_to :inspection
  has_many :remarks
  
  validates :inspection_id, presence: false
  # validates :name, presence: true
  validates :file, presence: true
  validates :filename, presence: true
  # validates :content_type, presence: true


  def uploaded_file=(incoming_file)
  	self.filename = incoming_file.original_filename
  	self.content_type = incoming_file.content_type
  	self.name = "test file name"
  	self.file = incoming_file.read
  	self.inspection_id = 1
  end

  def filename=(new_filename)
  	write_attribute :filename, sanitize_filename(new_filename)
  end

  private
  	def sanitize_filename(filename)
  		just_filename = File.basename(filename)
  		just_filename.gsub(/[^\w\.\-]/, '_')
  	end
end
