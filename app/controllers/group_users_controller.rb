class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    group_user = GroupUser.new
    group_user.user_id = current_user.id
    group_user.group_id = group.id
    group_user.save
    redirect_to group_path(group.id)
  end

  def destroy
    group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:group_id])
    group_user.destroy
    redirect_to groups_path
  end
end
