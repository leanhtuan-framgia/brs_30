class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]

  def index
    @requests = Request.paginate page: params[:page], per_page: Settings.size
  end

  def new
    @request = current_user.requests.new
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "flash.send_request_success"
      redirect_to requests_url
    else
      render :new
    end
  end

  private
  def request_params
    params.require(:request).permit :name, :author, :publish_date, :description
  end
end
