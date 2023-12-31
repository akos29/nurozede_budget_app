class GroupsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are not authorized to proceed with your request.'
    redirect_to root_path # You can redirect to any page you prefer
  end

  def index
    @groups = Group.includes(:expenses).where(user_id: current_user.id)
  end

  def show; end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: 'Group was successfully created.' }
        format.json { render :index, status: :created, location: @group }
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

    respond_to do |format|
      if @group.destroy
        format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      else
        format.html { redirect_to groups_url, notice: 'Group was not destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon, :icon_image)
  end
end
