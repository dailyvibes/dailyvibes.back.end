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
    # return head :forbidden if @user == false
    render head :forbidden unless current_user

    # Time.strptime("2018-07-20T01:50:31Z", "%Y-%m-%dT%H:%M:%S%z").in_time_zone

    begin
      duedate_at = Time.strptime(todotask_items_params['duedate_at'], '%Y-%m-%dT%H:%M:%S%z').in_time_zone

      # title, b = hash.values_at(:a, :b)
      # title, duedate_at, notes, tags, remindable, project

      @todotask_item = TodotaskItem.new(
                                        title: todotask_items_params['title'],
                                        remindable: todotask_items_params['remindable'],
                                        duedate_at: duedate_at
                                        )
      @todotask_item.list = List.find(todotask_items_params['project'])
      if todotask_items_params['notes'] && todotask_items_params['notes'].size.positive?
        @todotask_item.notes.create(content: todotask_items_params['notes'])
      end
      if todotask_items_params['tags'] && todotask_items_params['tags'].size.positive?
        tags = todotask_items_params['tags'].split(',')

        tags.each do |tag|
          @todotask_item.tags.create(label: tag)
        end
      end

      if @todotask_item.save
        render json: @todotask_item, status: :created, location: @todotask_item
      else
        render json: @todotask_item.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      binding.pry
    end
  end

  # PATCH/PUT /todotask_items/1
  def update
    if @todotask_item.update(todotask_items_params)
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

  def set_todotask_item
    @todotask_item = TodotaskItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def todotask_items_params
    # params.require(:todotask_item).permit(:title, :duedate_at, :archived_at, :notes, :tags, :remind_me, :project)
    params.require(:task).permit(:title, :duedate_at, :archived_at, :notes, :tags, :remindable, :project)
  end
end
