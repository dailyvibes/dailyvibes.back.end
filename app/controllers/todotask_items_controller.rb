# frozen_string_literal: true

# :nodoc:
class TodotaskItemsController < ApiController
  before_action :authenticate_user
  before_action :set_todotask_item, only: %i[show update destroy]

  # GET /todotask_items
  def index
    @todotask_items = TodotaskItem.all

    render json: @todotask_items
  end

  # GET /todotask_items/1
  def show
    render json: @todotask_item
  end

  # POST /todotask_items
  def create
    @todotask_item = TodotaskItem.new(todotask_item_params)

    if @todotask_item.save
      render json: @todotask_item, status: :created, location: @todotask_item
    else
      render json: @todotask_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todotask_items/1
  def update
    if @todotask_item.update(todotask_item_params)
      render json: @todotask_item
    else
      render json: @todotask_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todotask_items/1
  def destroy
    @todotask_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todotask_item
      @todotask_item = TodotaskItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todotask_item_params
      params.require(:todotask_item).permit(:title, :duedate_at, :archived_at)
    end
end
