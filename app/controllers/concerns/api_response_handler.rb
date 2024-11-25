# frozen_string_literal: true

# ApiResponseHandler provides methods for handling API responses in controllers.
# It defines methods for success and error responses and centralizes error handling for common exceptions.
#
# Included Methods:
# - handle_api_error: Handles exceptions and renders JSON responses with appropriate status codes.
# - api_success: Renders a successful JSON response with data, message, and status.
# - render_success: Renders a successful JSON response with a standardized success message.
# - render_failure: Renders a failure JSON response with a standardized failure message.
# - api_created: Renders a JSON response for resource creation with status :created.
module ApiResponseHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_api_error
  end

  private

  # Handles API errors and renders a JSON response with an appropriate error message.
  #
  # @param [Exception] error The exception that occurred.
  # @return [JSON] JSON response with error message and status code.
  def handle_api_error(error)
    error_message = error.message || 'An error occurred'
    status_code = :internal_server_error

    case error
    when ActiveRecord::RecordNotFound
      status_code = :not_found
    when ActionController::ParameterMissing
      status_code = :bad_request
    when ActiveRecord::RecordInvalid
      status_code = :unprocessable_entity
      error_message = error.record.errors.full_messages.join(', ')
    when ActionController::RoutingError, ActionController::UnknownFormat, AbstractController::ActionNotFound
      status_code = :not_found
    end

    render json: { error: error_message }, status: status_code
  end

  # Renders a successful JSON response.
  #
  # @param [Hash] data The data to include in the response.
  # @param [String] message The success message of the request.
  # @param [Symbol] status The HTTP status code (default: :ok).
  # @param [ActiveModel::Serializer] serializer Optional serializer for custom data shaping.
  # @return [JSON] JSON response with data and status code.
  def api_success(data: nil, message: nil, status: :ok, serializer: nil)
    response = { data:, message: }

    if serializer
      render json: response, status:, each_serializer: serializer
    else
      render json: response, status:
    end
  end

  # Renders a successful JSON response with a default message.
  #
  # @param [Hash] data The data to include in the response.
  # @param [String] message The success message (default: 'Request successful').
  # @param [Symbol] status The HTTP status code (default: :ok).
  # @return [JSON] JSON response with success status.
  def render_success(data = nil, message = 'Request successful', status = :ok)
    response = { success: true, message: }
    response[:response] = data if data.present?
    render json: response, status:
  end

  # Renders an error JSON response with a default message.
  #
  # @param [Hash] data The data to include in the response.
  # @param [String] message The error message (default: 'Request Failed').
  # @param [Symbol] status The HTTP status code (default: :bad_request).
  # @return [JSON] JSON response with error status.
  def render_failure(data: nil, message: 'Request Failed', status: :bad_request)
    response = { success: false, message: }
    response[:response] = data if data.present?
    render json: response, status:
  end

  # Renders a JSON response for a resource creation.
  #
  # @param [Hash] data The data to include in the response.
  # @return [JSON] JSON response with data and status code :created.
  def api_created(data)
    api_success(data, status: :created)
  end
end