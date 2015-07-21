require 'rails_helper'

RSpec.describe Task, type: :model do

  #序号在同一项目递增
  describe "No + 1" do
    it "should be no + 1" do
      project = create(:project)
      task_category = create(:task_category,project: project)
      task = create(:task, task_category: task_category)
      task.No == 1
      expect(task.No).to eq( 1 )
      task2 = create(:task, task_category: task_category)
      expect(task2.No).to eq( 2 )
    end
  end

  #状态切换,状态值变换是否正确
  describe "Assm State" do

    before(:each) do
      @task = create(:task)
    end

    #状态转换为待办中
    context "state to waiting" do

      it "should be doing to waiting" do
        @task.state = "doing"
        expect(@task.state).to eq( "doing" )
        @task.wait 
        expect(@task.state).to eq( "waiting" )
      end

      it "should be completed to waiting" do
        @task.state = "completed"
        expect(@task.state).to eq( "completed" )
        @task.wait 
        expect(@task.state).to eq( "waiting" )
      end

      it "should be acceptance to waiting" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        @task.wait 
        expect(@task.state).to eq( "waiting" )
      end
    end

    #状态转换为进行中
    context "state to doing" do

      it "should be waiting to doing" do
        expect(@task.state).to eq( "waiting" )
        @task.do 
        expect(@task.state).to eq( "doing" )
      end

      it "should be completed to doing" do
        @task.state = "completed"
        expect(@task.state).to eq( "completed" )
        @task.do 
        expect(@task.state).to eq( "doing" )
      end

      it "should be acceptance to doing" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        @task.do 
        expect(@task.state).to eq( "doing" )
      end
    end

    #状态转换为已完成
    context "state to completed" do

      it "should be waiting to completed" do
        expect(@task.state).to eq( "waiting" )
        @task.complete 
        expect(@task.state).to eq( "completed" )
      end

      it "should be doing to completed" do
        @task.state = "doing"
        expect(@task.state).to eq( "doing" )
        @task.complete 
        expect(@task.state).to eq( "completed" )
      end

      it "should be acceptance to completed" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        @task.complete 
        expect(@task.state).to eq( "completed" )
      end
    end

    #状态转换为验证通过
    context "state to acceptance" do

      it "should be waiting to acceptance" do
        expect(@task.state).to eq( "waiting" )
        @task.accept 
        expect(@task.state).to eq("acceptance")
      end

      it "should be doing to acceptance" do
        @task.state = "doing"
        expect(@task.state).to eq( "doing" )
        @task.accept 
        expect(@task.state).to eq("acceptance")
      end

      it "should be completed to acceptance" do
        @task.state = "completed"
        expect(@task.state).to eq("completed")
        @task.accept 
        expect(@task.state).to eq("acceptance")
      end
    end

  end

end
