class ErrorsController < ApplicationController
  before_action :set_format

  def not_found
    render status: :not_found
  end

  def internal_server_error
    render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
  end

  private

  def set_format
    request.format = :html
  end
end
