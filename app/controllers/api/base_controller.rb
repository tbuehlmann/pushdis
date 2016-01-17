class API::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  private

  def authenticate
    if api_token.present?
      authenticate_or_request_with_http_token do |token, _options|
        token == api_token
      end
    end
  end

  def api_token
    @api_token ||= Rails.application.secrets.api_token
  end
end
