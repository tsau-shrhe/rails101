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
		@posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
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

	def join
		@group = Group.find(params[:id])

		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "成功加入本討論版!!"
		else
			flash[:warning] = "你已經是本討論版成員了"
		end

		#這可能出錯
		redirect_to group_path(@group)
	end

	def quit
		@group = Group.find(params[:id])

		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:alert] = "成功退出討論版"
		else
			flash[:warning] = "你還不是本版討論成員，無法退出。"
		end

		redirect_to group_path(@group)
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