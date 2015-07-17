# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  imageable_id        :integer
#  imageable_type      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Image, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
