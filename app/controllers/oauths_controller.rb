#-*- coding: utf-8 -*-
class OauthsController < ApplicationController

  def welcome
  
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def redirect
    cookies[:access_token] = Koala::Facebook::OAuth.new(redirect_oauths_url).get_access_token(params[:code]) if params[:code]
    
    redirect_to cookies[:access_token] ? scenarios_url : "http://www.facebook.com/"
  end
end
