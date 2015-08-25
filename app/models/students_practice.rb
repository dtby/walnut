class StudentsPractice < ActiveRecord::Base
  belongs_to :student
  belongs_to :practice
end
