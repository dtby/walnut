require 'rails_helper'

RSpec.describe Task, type: :model do

  #序号在同一项目递增
  describe "No + 1" do
    it "should be no + 1" do
      task = create(:task)
      task.No == 1
      task2 = create(:task)
      task.No == 2
    end
  end

  #状态切换
  describe "Assm State" do

    before(:each) do
      @task = create(:task)
    end

    #状态转换未待办中
    context "state to waiting" do
      it "should be waiting to waiting" do
        @task.state == "waiting"
        @task.wait 
        @task.state == "waiting"
      end

      it "should be doing to waiting" do
        @task.state = "doing"
        @task.state == "doing"
        @task.wait 
        @task.state == "waiting"
      end

      it "should be completed to waiting" do
        @task.state = "completed"
        @task.state == "completed"
        @task.wait 
        @task.state == "waiting"
      end

      it "should be acceptance to waiting" do
        @task.state = "acceptance"
        @task.state == "acceptance"
        @task.wait 
        @task.state == "waiting"
      end

      it "should be failure to waiting" do
        @task.state = "failure"
        @task.state == "failure"
        @task.wait 
        @task.state == "waiting"
      end
    end
  end
end
