module TrackRecordsHelper
  
  def track
    TrackRecord.create(user_id: current_user.id, scenario_name: params[:url], action: params[:action], execute_at: Time.new)
  end
end