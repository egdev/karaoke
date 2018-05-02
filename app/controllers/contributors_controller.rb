class ContributorsController < ApplicationController
  before_action :set_contributor, only: [:show, :edit, :update, :destroy]

  # GET /contributors
  # GET /contributors.json
  def index
    @contributors = Contributor.all
  end

  # GET /contributors/new
  def new
    @contributor = Contributor.new
    
    respond_to do |format|
      format.html {}
      format.js {
        render layout: false
      }
    end
  end

  # GET /contributors/1/edit
  def edit
  end

  # POST /contributors
  # POST /contributors.json
  def create
    @contributor = Contributor.new(contributor_params)

    respond_to do |format|
      if @contributor.save
        format.html { redirect_to contributors_url, notice: 'Le chanteur a été créé avec succès.' }
        format.json { render :show, status: :created, location: @contributor }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /contributors/1
  # PATCH/PUT /contributors/1.json
  def update
    respond_to do |format|
      if @contributor.update(contributor_params)
        format.html { redirect_to contributors_url, notice: 'Le chanteur a été mis à jour avec succès.' }
        format.json { render :show, status: :ok, location: @contributor }
      else
        format.html { render :edit }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors/1
  # DELETE /contributors/1.json
  def destroy
    @contributor.destroy
    respond_to do |format|
      format.html { redirect_to contributors_url, notice: 'Le chanteur a été effacé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contributor
      @contributor = Contributor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contributor_params
      params.require(:contributor).permit(:name)
    end
end
