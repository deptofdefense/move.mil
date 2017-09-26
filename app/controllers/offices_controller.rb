class OfficesController < ApplicationController
  def index
    transportation_offices
  end

  private

  def transportation_offices
    @transportation_offices ||= TransportationOffice.all.page(params[:page])
  end
end
