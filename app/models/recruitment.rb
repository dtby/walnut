# == Schema Information
#
# Table name: recruitments
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :string(255)
#  certificate      :string(255)
#  degree_id        :integer
#  company_id       :integer
#  category         :string(255)
#  city             :string(255)
#  remuneration     :string(255)
#  foreign_language :string(255)
#  others           :string(255)
#  description      :text(65535)
#  hr_email         :string(255)
#  browse_count     :integer          default(0)
#  publish_time     :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry         :string(255)
#  number           :integer
#  view_count       :integer
#  nature           :string(255)
#  department       :string(255)
#  need_person      :string(255)
#  stop_time        :time
#  must_school      :string(255)
#  must_specialty1  :string(255)
#  must_specialty2  :string(255)
#  age              :string(255)
#  experience       :string(255)
#  it_tec           :string(255)
#  responsibility   :text(65535)
#  demand           :text(65535)
#

class Recruitment < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :degree
  belongs_to :company
  has_many :user_recruitments, dependent: :destroy
end
