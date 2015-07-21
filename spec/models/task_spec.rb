require 'rails_helper'

RSpec.describe Task, type: :model do

  #序号在同一项目递增
  describe "No + 1" do
    it "should be no + 1" do
      task = create(:task)
      task.No == 1
      expect(task.No).to eq( 1 )
      task2 = create(:task)
      expect(task2.No).to eq( 2 )
    end
  end

  #创建task择期对应的task_category的任务总数+1，未完成数+1
  describe "task_category's task + 1" do
    it "should be task_category's task + 1" do
      task = create(:task)
      expect(task.task_category.total).to eq( 1 )
      expect(task.task_category.unfinished).to eq( 1 )

      task2 = create(:task)
      expect(task2.task_category.total).to eq( 2 )
      expect(task2.task_category.unfinished).to eq( 2 )
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
        unfinished = @task.task_category.unfinished
        @task.wait 
        expect(@task.state).to eq( "waiting" )
        expect(@task.task_category.unfinished).to eq( unfinished )
      end

      it "should be completed to waiting" do
        @task.state = "completed"
        expect(@task.state).to eq( "completed" )
        unfinished = @task.task_category.unfinished
        @task.wait 
        expect(@task.state).to eq( "waiting" )
        expect(@task.task_category.unfinished).to eq( unfinished + 1 )
      end

      it "should be acceptance to waiting" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        unfinished = @task.task_category.unfinished
        @task.wait 
        expect(@task.state).to eq( "waiting" )
        expect(@task.task_category.unfinished).to eq( unfinished + 1 )
      end
    end

    #状态转换为进行中
    context "state to doing" do

      it "should be waiting to doing" do
        expect(@task.state).to eq( "waiting" )
        unfinished = @task.task_category.unfinished
        @task.do 
        expect(@task.state).to eq( "doing" )
        expect(@task.task_category.unfinished).to eq( unfinished )
      end

      it "should be completed to doing" do
        @task.state = "completed"
        expect(@task.state).to eq( "completed" )
        unfinished = @task.task_category.unfinished
        @task.do 
        expect(@task.state).to eq( "doing" )
        expect(@task.task_category.unfinished).to eq( unfinished + 1 )
      end

      it "should be acceptance to doing" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        unfinished = @task.task_category.unfinished
        @task.do 
        expect(@task.state).to eq( "doing" )
        expect(@task.task_category.unfinished).to eq( unfinished + 1 )
      end
    end

    #状态转换为已完成
    context "state to completed" do

      it "should be waiting to completed" do
        expect(@task.state).to eq( "waiting" )
        unfinished = @task.task_category.unfinished
        @task.complete 
        expect(@task.state).to eq( "completed" )
        expect(@task.task_category.unfinished).to eq( unfinished - 1 )
      end

      it "should be doing to completed" do
        @task.state = "doing"
        expect(@task.state).to eq( "doing" )
        unfinished = @task.task_category.unfinished
        @task.complete 
        expect(@task.state).to eq( "completed" )
        expect(@task.task_category.unfinished).to eq( unfinished - 1 )
      end

      it "should be acceptance to completed" do
        @task.state = "acceptance"
        expect(@task.state).to eq( "acceptance" )
        unfinished = @task.task_category.unfinished
        @task.complete 
        expect(@task.state).to eq( "completed" )
        expect(@task.task_category.unfinished).to eq( unfinished )
      end
    end

    #状态转换为验证通过
    context "state to acceptance" do

      it "should be waiting to acceptance" do
        expect(@task.state).to eq( "waiting" )
        unfinished = @task.task_category.unfinished
        @task.accept 
        expect(@task.state).to eq("acceptance")
        expect(@task.task_category.unfinished).to eq( unfinished - 1 )
      end

      it "should be doing to acceptance" do
        @task.state = "doing"
        expect(@task.state).to eq( "doing" )
        unfinished = @task.task_category.unfinished
        @task.accept 
        expect(@task.state).to eq("acceptance")
        expect(@task.task_category.unfinished).to eq( unfinished - 1 )
      end

      it "should be completed to acceptance" do
        @task.state = "completed"
        expect(@task.state).to eq("completed")
        unfinished = @task.task_category.unfinished
        @task.accept 
        expect(@task.state).to eq("acceptance")
        expect(@task.task_category.unfinished).to eq( unfinished )
      end
    end

  end

end
