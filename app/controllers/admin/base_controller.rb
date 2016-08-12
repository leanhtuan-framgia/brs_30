class Admin::BaseController < ApplicationController
  layout "admin/application"
  before_action :logged_in_user, :verify_admin
end
