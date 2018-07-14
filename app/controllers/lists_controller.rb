# frozen_string_literal: true

# :nodoc:
class ListsController < ApiController
  before_action :authenticate_user
  before_action :set_list, only: %i[update destroy]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

  # GET /lists/1
  def show
    @list = List.includes(:todotask_items).find(params[:id])

    result = if !@list.todotask_items.empty?
               @list.as_json(include: :todotask_items)
             else
               @list.as_json
             end

    render json: result
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    # params.require(:list).permit(:title, :duedate_at, :archived_at, :completed_at, :title_description, :emoji, :color, :favourite, :visible, :public, :dv_default)
    params.require(:list).permit(:title)
  end
end
