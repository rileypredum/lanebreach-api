class ApplicationController < ActionController::API 
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActionController::ParameterMissing, with: :missing_parameters   

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.record.errors.full_messages.map { |error| error + "." }}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: 'Sorry, resource not found.' }, status: :not_found
  end

  def record_not_unique
    render json: { error: 'Sorry, the record is not unique.' }, status: :unprocessable_entity
  end

  def missing_parameters
    render json: { error: 'Sorry, you are missing parameters.' }, status: :unprocessable_entity
  end
end
