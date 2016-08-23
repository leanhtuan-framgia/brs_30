class Admin::RequestsController < Admin::BaseController
  before_action :find_request, only: [:edit, :update]
  before_action :load_status, only: :edit

  def index
    @requests = Request.order_by_time.paginate page: params[:page],
      per_page: Settings.size
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "flash.handle_request_success"
      redirect_to admin_requests_path
    else
      load_status
      render :edit
    end
  end

  private
  def request_params
    params.require(:request).permit :req_status
  end

  def find_request
    @request = Request.find_by id: params[:id]
    if @request.nil?
      flash[:danger] = t "flash.cant_find_request"
      redirect_to admin_root_path
    end
  end

  def load_status
    @request_statuses = Request.req_statuses.map{|key, value| [key, key]}
  end
end
