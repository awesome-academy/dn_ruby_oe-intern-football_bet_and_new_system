class StaticPagesController < ApplicationController
  def home
    @q = SoccerMatch.ransack(params[:q])
    @pagy, @soccer_matches = pagy @q.result.includes(:home_team, :guest_team)
                                    .newest
  end

  def help; end

  def about; end
end
