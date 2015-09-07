class UserTrainController < ApplicationController
  def create
    #记录保存
    @user_train = UserTrain.find_or_initialize_by(user_id: current_user.id, train_id: params[:train_id]) 
    @user_train.save
    respond_with @user_train
  end

  def destroy
  end
end
