class TodayMissionsController < ApplicationController
  def update
    def update
      @today_mission = TodayMission.find(params[:id])
      if @today_mission.mission_status == 'until'
        @today_mission.update(mission_status: 'done')
      else
        @today_mission.update(mission_status: 'until')
      end
    end
  end
end
