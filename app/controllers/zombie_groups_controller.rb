class ZombieGroupsController < ApplicationController
      before_action :authenticate_user! 
      before_action :set_zombie_group, only: [:show, :edit, :update, :destroy]

  # GET /zombie_groups
  def index
    @zombie_groups = ZombieGroup.all
    @hash = Gmaps4rails.build_markers(@zombie_groups) do |zombie_group, marker|
      marker.lat zombie_group.latitude
      marker.lng zombie_group.longitude
      marker.infowindow  "<h2>"+zombie_group.title+"</h2>"

      marker.picture({
        "url" =>"zombiemarker.png",
        "width"  => 30,
        "height" => 50,
       })
    end
    new
  end

  # GET /zombie_groups/new
  def new
    @zombie_group = ZombieGroup.new
  end

  # POST /zombie_groups
  def create
    @zombie_group = ZombieGroup.new(zombie_group_params)
    @zombie_group.save
    redirect_to zombie_groups_url, notice: 'Zombie Horde has been successfully tagged!'

  end

  # PATCH/PUT /zombie_groups/1
  def update
    if @zombie_group.update(zombie_group_params)
      redirect_to @zombie_group, notice: 'Zombie Horde has been successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /zombie_groups/1
  def destroy
    @zombie_group.destroy
    redirect_to zombie_groups_url, notice: 'Zombie Horde has been successfully destroyed.'
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zombie_group
      @zombie_group = ZombieGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zombie_group_params
      params.require(:zombie_group).permit(:latitude, :longitude, :address, :title)
    end
end
