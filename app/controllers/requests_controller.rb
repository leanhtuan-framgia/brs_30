class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]
  before_action :find_request, only: :destroy

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

  def destroy
    if @request.pendding?
      @request.destroy
      flash[:success] = t "flash.cancel_success"
      redirect_to requests_url
    else
      flash[:danger] = t "flash.cant_cancel_request"
      redirect_to requests_url
    end
  end

  private
  def request_params
    params.require(:request).permit :name, :author, :publish_date, :description
  end

  def find_request
    @request = Request.find_by id: params[:id]
    if @request.nil?
      flash[:danger] = t "flash.cant_find_request"
      redirect_to requests_url
    end
  end
end
