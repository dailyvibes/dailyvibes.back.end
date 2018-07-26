# frozen_string_literal: true

# :nodoc:
class TodotaskItemsController < ApiController
  before_action :authenticate_user
  before_action :set_todotask_item, only: %i[destroy]

  # GET /todotask_items
  def index
    @todotask_items = TodotaskItem.all

    render json: @todotask_items
  end

  # GET /todotask_items/1
  def show
    # @list = List.includes(:todotask_items).find(params[:id])

    # result = if !@list.todotask_items.empty?
    #            @list.as_json(include: :todotask_items)
    #          else
    #            @list.as_json
    #          end

    @todotask_item = TodotaskItem.includes(:tags, :notes).find(params[:id])

    result = @todotask_item.as_json(include: [:tags, :notes])

    render json: result
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

      @todotask_item = TodotaskItem.new(title: todotask_items_params['title'],
                                        remindable: todotask_items_params['remindable'],
                                        duedate_at: duedate_at
                                        )
      @todotask_item.list = List.find(todotask_items_params['project'])
      if todotask_items_params['notes'] && todotask_items_params['notes'].size.positive?
        # Note.new(content: todotask_items_params['notes'],
                 # todotask_item: @todotask_item)
        # @todotask_item.notes.create(content: todotask_items_params['notes'])
        @todotask_item.notes.build(content: todotask_items_params['notes'])
      end
      if todotask_items_params['tags'] && todotask_items_params['tags'].size.positive?
        tags = todotask_items_params['tags'].split(',')

        tags.each do |tag|
          # Tag.new(label: tag, todotask_item: @todotask_item)
          # @todotask_item.tags.create(label: tag)
          @todotask_item.tags.build(label: tag)
        end
      end

      if @todotask_item.save
        # render json: @todotask_item, status: :created, location: @todotask_item
        render json: @todotask_item, status: :created
      else
        render json: @todotask_item.errors, status: :unprocessable_entity
      end
    rescue StandardError => e
      puts e
      raise e
    end
  end

  # PATCH/PUT /todotask_items/1
  def update
    @todotask_item = TodotaskItem.find(params[:id])

    # head :forbidden unless current_user == @todotask_item.list.user

    duedate_at = Time.strptime(todotask_items_params['duedate_at'], '%Y-%m-%dT%H:%M:%S%z').in_time_zone if !todotask_items_params['duedate_at'].blank?

    # puts "duedate_at: #{duedate_at}"

    if todotask_items_params['archived']
      archived_at = Time.strptime(todotask_items_params['archived_at'], '%Y-%m-%dT%H:%M:%S%z').in_time_zone if !todotask_items_params['archived_at'].blank?
    end

    @todotask_item.title = todotask_items_params['title'] if todotask_items_params['title']
    @todotask_item.remindable = todotask_items_params['remindable'] if todotask_items_params['remindable'] != nil
    @todotask_item.duedate_at = duedate_at if duedate_at
    @todotask_item.archived_at = archived_at if archived_at
    @todotask_item.archived = todotask_items_params['archived'] if todotask_items_params['archived']

    if todotask_items_params['project'] && !todotask_items_params['project'].blank?
      unless @todotask_item.list.id == todotask_items_params['project']
        @todotask_item.list = List.find(todotask_items_params['project'])
      end
    end

    if todotask_items_params['notes'] && todotask_items_params['notes'].size.positive?
      @todotask_item.notes.build(content: todotask_items_params['notes'])
    end
    if todotask_items_params['tags'] && todotask_items_params['tags'].size.positive?
      tags = todotask_items_params['tags'].split(',')

      tags.each do |tag|
        # Tag.new(label: tag, todotask_item: @todotask_item)
        # @todotask_item.tags.create(label: tag)
        @todotask_item.tags.build(label: tag)
      end
    end

    if @todotask_item.save
      # respond_to do |format|
      #   format.json  { render json:  @todotask_item }
      # end
      render json: @todotask_item, status: :ok
    else
      render json: @todotask_item.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    puts e
    raise e
  end

  # DELETE /todotask_items/1
  def destroy
    @todotask_item.destroy if current_user == @todotask_item.list.user
  end

  private

  def set_todotask_item
    @todotask_item = TodotaskItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def todotask_items_params
    # params.require(:todotask_item).permit(:title, :duedate_at, :archived_at, :notes, :tags, :remind_me, :project)
    params.require(:task).permit(:title, :duedate_at, :archived_at, :notes, :tags, :remindable, :project, :archived)
  end
end
