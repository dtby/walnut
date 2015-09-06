module Wechat
  class OauthsController < ApplicationController
    before_action :store_reurl, only: [:index]
    respond_to :html

    def index
      openid = session[:openid]
      if openid.present?
        redirect_to session[:recurl] || wechat_root_path
      else  
        url = $client.authorize_url check_wechat_oauths_url
        redirect_to url
      end
    end

    def check
      result = $client.get_oauth_access_token(params[:code])
      openid = result.result["openid"]
      session[:openid] = openid
      # subscriber = Subscriber.where(openid: openid).first
      # if subscriber.present?
        redirect_to session[:recurl] || wechat_root_path
      # else
        # redirect_to wechat_error_path
      # end
    end

    private
    def store_reurl
      session[:recurl] = params[:recurl] if params[:recurl].present?
      session[:target_url] = params[:target_url] if params[:target_url].present?
    end
  end
end
