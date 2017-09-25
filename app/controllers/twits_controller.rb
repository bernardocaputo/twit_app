class TwitsController < ApplicationController
before_action :authenticate_user!
before_action :set_twit, only: [:update, :destroy]
before_action :owner?, only: [:update, :destroy]


  def index
    @twits = Twit.newest_first
  end

  def create
    @twit = Twit.new(twit_params)
    respond_to do |format|
      if @twit.save
        format.json { render json: @twit }
      else
        format.json { render json: @twit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @twit.update(twit_params)
        format.json { render json: true }
      else
        format.json { render json: @twit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @twit.destroy
    respond_to do |format|
      format.json { render json: true}
    end
  end

  private

  def set_twit
    @twit = Twit.find(params[:id])
  end

  def twit_params
    params.require(:twit).permit(:content).merge(user: current_user)
  end


  def owner?
    unless current_user == @twit.user
      respond_to do |format|
        format.json { render json: false, status: :forbidden }
        format.html { redirect_to new_user_session_path }
      end
    end
  end
end
