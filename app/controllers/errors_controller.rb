class ErrorsController < ApplicationController

  before_action :set_format

  def not_found
    puts request.format
    render status: 404
  end

  private
  def set_format
    request.format = :html
  end
end
