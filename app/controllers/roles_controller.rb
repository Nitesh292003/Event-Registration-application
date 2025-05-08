class RolesController < BaseController
    skip_before_action :verify_authenticity_token
    before_action :set_role, only: %i[show destroy update]
    load_and_authorize_resource
  
    def index
      @roles = Role.all
      render json: @roles
    end
  
    def show
      render json: @role
    end
  
    def create
      @role = Role.new(role_params)
      if @role.save
        render json: @role, status: :created
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @role.update(role_params)
        render json: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @role.destroy
      head :no_content
    end
  
    private
  
    def role_params
      params.require(:role).permit(:role_type)
    end
  
    def set_role
      @role = Role.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Role not found' }, status: :not_found
    end
  end
  