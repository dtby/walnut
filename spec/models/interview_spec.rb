# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :string(255)
#  iv_category_id :integer
#  browse_count   :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  public_time    :string(255)
#  image_url      :string(255)
#  view_count     :integer
#

require 'rails_helper'

RSpec.describe Interview, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
