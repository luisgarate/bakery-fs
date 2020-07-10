class OvensController < ApplicationController
  before_action :authenticate_user!

  def index
    @ovens = current_user.ovens
  end

  def show
    @oven = current_user.ovens.find_by!(id: params[:id])
  end

  def empty
    @oven = current_user.ovens.find_by!(id: params[:id])
    if @oven.cookies.any?
      @oven.cookies.each{|c| c.update_attributes!(storage: current_user)}
    end
    redirect_to @oven, alert: 'Oven emptied!'
  end

  def reload_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
    render partial: 'ovens/cookie_status', cookie: @oven.cookie
  end
end
