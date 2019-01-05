class Admin::AdminController < Admin::ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
end