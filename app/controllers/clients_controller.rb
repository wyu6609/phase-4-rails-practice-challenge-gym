class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    clients = Client.all
    render json: clients
  end

  def show
    selected_client = find_client
    render json: selected_client
  end

  def updated
    selected_client = find_client
    selected_client.update(client_params)
  end

  private

  def find_client
    Client.find(params[:id])
  end

  def client_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: 'Client not found' }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    reder json: {
            errors: exception.record.errors.full_messages,
          },
          status: :unprocessable_entity
  end
end
