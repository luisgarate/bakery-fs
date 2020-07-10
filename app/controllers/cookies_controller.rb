class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.any?
      redirect_to @oven, alert: 'There are cookies in the oven!'
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if params[:amount].present? && params[:amount] > 1
      cookies = []
      params[:amount].to_i.times do |i|
        cookies << Cookie.new(oven_id: @oven.id, filling: params[:fillings])
      end

      Cookie.import cookies

      cookies.each do |c|
        CookCookieJob.perform_later(c)
      end
    else
      @cookie = @oven.create_cookie!(cookie_params)
      CookCookieJob.perform_later(@cookie)
    else

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings, :amount)
  end
end
