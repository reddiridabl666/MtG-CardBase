class ExpansionsController < ApplicationController
  before_action :set_expansion, only: %i[ show edit update destroy ]

  # GET /expansions or /expansions.json
  def index
    @expansions = Expansion.all
  end

  # GET /expansions/1 or /expansions/1.json
  def show
  end

  # GET /expansions/new
  def new
    @expansion = Expansion.new
  end

  # GET /expansions/1/edit
  def edit
  end

  # POST /expansions or /expansions.json
  def create
    @expansion = Expansion.new(expansion_params)

    respond_to do |format|
      if @expansion.save
        format.html { redirect_to expansion_url(@expansion), notice: "Expansion was successfully created." }
        format.json { render :show, status: :created, location: @expansion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expansions/1 or /expansions/1.json
  def update
    respond_to do |format|
      if @expansion.update(expansion_params)
        format.html { redirect_to expansion_url(@expansion), notice: "Expansion was successfully updated." }
        format.json { render :show, status: :ok, location: @expansion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expansions/1 or /expansions/1.json
  def destroy
    @expansion.destroy

    respond_to do |format|
      format.html { redirect_to expansions_url, notice: "Expansion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expansion
      @expansion = Expansion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expansion_params
      params.require(:expansion).permit(:name, :code, :card_num, :release_date)
    end
end
