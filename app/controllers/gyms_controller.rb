class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    gyms = Gym.all
    render json: gyms
  end

  def show
    selected_gym = find_gym
    render json: selected_gym
  end

  def update
    selected_gym = find_gym
    selected_gym.update(gym_params)
    render json: selected_gym
  end

  def destroy
    selected_gym = find_gym
    selected_gym.destroy

    # render json: selected_gym
    head :no_content
  end

  private

  def gym_params
    params.permit(:name, :address)
  end

  def find_gym
    Gym.find(params[:id])
  end

  def render_unprocessable_entity(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: 'Gym not found' }, status: :not_found
  end
end
