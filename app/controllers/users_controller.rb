class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  authorize_resource

  def show; end
end
