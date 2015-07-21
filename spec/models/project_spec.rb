require 'rails_helper'

RSpec.describe Project, type: :model do
  context "Relations" do
    #it { should have_many(:task_categories) } 
  end

  describe "xxxx" do
    before(:each) do 
      @project = build(:project)
    end
    context "ffff" do
      #it { should have_many :task_categories } 
      it "should be paid from initial" do
        @project.is_public == false
      end
    end
  end
end
