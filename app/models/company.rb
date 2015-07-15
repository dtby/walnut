# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text(65535)
#  address       :string(255)
#  web_address   :string(255)
#  contact_phone :string(255)
#  contact       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Company < ActiveRecord::Base
end
