class GroupsController < ApplicationController
	before_action :authenticate_user! ,only: [:new, :create, :edit, :update, :destroy]
	before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

	def index
		@groups = Group.all
	end
	def new
		@group = Group.new
	end
	def show
		@group = Group.find(params[:id])
	end
	def edit

	end

	def create
		@group = Group.new(group_params)
		@group.user = current_user
		if @group.save
			redirect_to groups_path
		else
			render :new
		end
	end
	def update

		if @group.update(group_params)
			redirect_to groups_path , notice: "修改成功.."
		else
			render :edit
		end
	end
	def destroy
		@group.destroy
		#flash[:alert] = "討論版刪除"
		redirect_to groups_path , alert: "討論刪除成功。"
	end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end

	def find_group_and_check_permission
		@group = Group.find(params[:id])
		if current_user != @group.user
			redirect_to root_path , alert:"您沒有刪除權限!!"
		end
	end
end