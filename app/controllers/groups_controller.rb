class GroupsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @groups = Group.all
    @user = current_user
  end

  def show;end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @group = Group.find_by_id(params[:id])
  end

  def update
    @group = Group.find_by_id(params[:id])
    
    if @group.update(group_params)
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find_by_id(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
