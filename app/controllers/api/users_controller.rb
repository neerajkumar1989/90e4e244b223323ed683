class Api::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all.page(params[:page])
    render json: { data: array_serializer(users), meta: pagination_meta(users) }
  end

  def create
    @user = User.new(users_params)
    if @user.save
      render json: { data: single_serializer(@user) }
    else
      render json: { errors: @user.errors, adapter: :json }
    end
  end

  def show
    render json: { data: single_serializer(@user) }
  end

  def update
    if @user.update(user_params)
      render json: { data: single_serializer(@user) }
    else
      render json: { message: @user.errors, adapter: :json }
    end

  end

  def destroy
    if @user.present?
      @user.destroy
      render json: { message: 'User destroyed successfully' }
    else
      render json: { message: 'No user found' }
    end
  end

  def typehead
    search = "%#{params[:search].parameterize}%"
    users = User.search(search, fields: [:firstname, :lastname, :email], operator: 'or')
    render json: { data: array_serializer(users) }
  end

  private

  def set_user
    @user = User.find_by_id(params[:user])
    unless @user.present?
      render json: { message: 'No data present' }
    end
  end

  def users_params
    params.require(:user).permit(:firstname, :lastname, :email)
  end

  def array_serializer(users)
    ActiveModel::Serializer::CollectionSerializer.new(users, serializer: UserSerializer)
  end

  def single_serializer(user)
    ActiveModel::Serializer::CollectionSerializer.new(user, serializer: UserSerializer)
  end

  def pagination_meta(users)
    {
      current_page: users.current_page,
      next_page: users.next_page,
      previous_page: users.prev_page,
      total_page: users.total_pages,
      total_count: users.total_count,
    } if users.present?
  end
end

