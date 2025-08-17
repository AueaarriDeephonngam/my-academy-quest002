class QuestsController < ApplicationController
  before_action :set_quest, only: [ :destroy, :toggle ]

  def index
    @quests = Quest.order(created_at: :desc)
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      redirect_to quests_path, notice: "Quest added successfully!"
    else
      @quests = Quest.order(created_at: :desc)
      render :index
    end
  end

  def toggle
    @quest.update(done: !@quest.done)
    redirect_to quests_path
  end

  def destroy
    @quest.destroy
    redirect_to quests_path, notice: "Quest deleted successfully!"
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title)
  end
end
