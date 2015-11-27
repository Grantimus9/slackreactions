class ReactionsController < ApplicationController

  # cancancan
  load_and_authorize_resource

  before_action :set_reaction, only: [:show, :edit, :update, :destroy]

  # GET /reactions
  # GET /reactions.json
  def index
    @search = Reaction.search do
      fulltext params[:search]
    end

    @reactions = Reaction.where(id: @search.results.map(&:id)).paginate(page: params[:page], :per_page => 30)
  end

  # GET /reactions/new
  def new
    @reaction = Reaction.new
  end

  # POST /reactions
  # POST /reactions.json
  def create
    @reaction = current_user.reactions.build(reaction_params)

    respond_to do |format|
      if @reaction.save
        format.html { redirect_to reactions_url, notice: 'Reaction was successfully created.' }
        format.json { render :show, status: :created, location: @reaction }
      else
        format.html { render :new }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reactions/1
  # PATCH/PUT /reactions/1.json
  def update
    respond_to do |format|
      if @reaction.update(reaction_params)
        format.html { redirect_to reactions_url, notice: 'Reaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @reaction }
      else
        format.html { render :edit }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reactions/1
  # DELETE /reactions/1.json
  def destroy
    @reaction.destroy
    respond_to do |format|
      format.html { redirect_to reactions_url, notice: 'Reaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reaction
      @reaction = Reaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reaction_params
      params.require(:reaction).permit(:keywords, :image, :remote_image_url)
    end
end
