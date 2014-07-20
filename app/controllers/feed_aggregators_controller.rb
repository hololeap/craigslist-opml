class FeedAggregatorsController < ApplicationController
  before_action :set_feed_aggregator, only: [:show, :edit, :update, :destroy]

  # GET /feed_aggregators
  # GET /feed_aggregators.json
  def index
    @feed_aggregators = FeedAggregator.all
  end

  # GET /feed_aggregators/1
  # GET /feed_aggregators/1.json
  def show
    render text: @feed_aggregator.generate_xml
  end

  # GET /feed_aggregators/new
  def new
    @feed_aggregator = FeedAggregator.new
  end

  # GET /feed_aggregators/1/edit
  def edit
  end

  # POST /feed_aggregators
  # POST /feed_aggregators.json
  def create
    raise params.inspect
    @feed_aggregator = FeedAggregator.new(feed_aggregator_params)

    respond_to do |format|
      if @feed_aggregator.save
        format.html { redirect_to @feed_aggregator, notice: 'Feed aggregator was successfully created.' }
        format.json { render :show, status: :created, location: @feed_aggregator }
      else
        format.html { render :new }
        format.json { render json: @feed_aggregator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_aggregators/1
  # PATCH/PUT /feed_aggregators/1.json
  def update
    respond_to do |format|
      if @feed_aggregator.update(feed_aggregator_params)
        format.html { redirect_to @feed_aggregator, notice: 'Feed aggregator was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed_aggregator }
      else
        format.html { render :edit }
        format.json { render json: @feed_aggregator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_aggregators/1
  # DELETE /feed_aggregators/1.json
  def destroy
    @feed_aggregator.destroy
    respond_to do |format|
      format.html { redirect_to feed_aggregators_url, notice: 'Feed aggregator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_aggregator
      @feed_aggregator = FeedAggregator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_aggregator_params
      params[:feed_aggregator]
    end
end
