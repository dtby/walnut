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
#  logo_url      :string(255)
#  city          :string(255)
#  industry      :string(255)
#  nature        :string(255)
#  scale         :string(255)
#

class Company < ActiveRecord::Base
end
