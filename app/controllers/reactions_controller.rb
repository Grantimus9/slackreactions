class ReactionsController < ApplicationController

  # cancancan
  load_and_authorize_resource

  before_action :set_reaction, only: [:show, :edit, :update, :destroy]

  # GET /reactions
  # GET /reactions.json
  def index

    if params[:search].nil? || params[:search].empty?
      @reactions = Reaction.where(user_id: current_user.id).all.paginate(page: params[:page], :per_page => 5)
    else
      # @reactions = Reaction.where(id: Reaction.search_any_word_trigram(params[:search]).map(&:id)).paginate(page: params[:page], :per_page => 30)
      @reactions = Reaction.search_any_word_trigram(params[:search]).paginate(page: params[:page], :per_page => 5)
    end

    # Team Facts
    @total_team_reactions = Reaction.count
    @user_reactions = Reaction.where(:user_id => current_user.id).count

    @top_submitters = User.order( "reactions_count desc" ).limit(3).all
    @top_requesters = Request.top_requesters


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
        flash[:success] = 'Nice!'
        format.html { redirect_to reactions_url }
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
        flash[:success] = 'Nice!'
        format.html { redirect_to reactions_url }
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
      flash[:notice] = 'Boom!'
      format.html { redirect_to reactions_url }
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
