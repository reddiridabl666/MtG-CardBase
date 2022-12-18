class CardInstancesController < ApplicationController
  before_action :set_card_instance, only: %i[ show edit update destroy ]

  # GET /card_instances or /card_instances.json
  def index
    @card_instances = CardInstance.all
  end

  # GET /card_instances/1 or /card_instances/1.json
  def show
  end

  # GET /card_instances/new
  def new
    @card_instance = CardInstance.new
  end

  # GET /card_instances/1/edit
  def edit
  end

  # POST /card_instances or /card_instances.json
  def create
    filtered = card_instance_params
    filtered[:rarity] = filtered[:rarity].to_i
    @card_instance = CardInstance.new(filtered)

    respond_to do |format|
      if @card_instance.save
        format.html { redirect_to card_instance_url(@card_instance), notice: "Card instance was successfully created." }
        format.json { render :show, status: :created, location: @card_instance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_instances/1 or /card_instances/1.json
  def update
    respond_to do |format|
      if @card_instance.update(card_instance_params)
        format.html { redirect_to card_instance_url(@card_instance), notice: "Card instance was successfully updated." }
        format.json { render :show, status: :ok, location: @card_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_instances/1 or /card_instances/1.json
  def destroy
    @card_instance.destroy

    respond_to do |format|
      format.html { redirect_to card_instances_url, notice: "Card instance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_instance
      @card_instance = CardInstance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_instance_params
      params.require(:card_instance).permit(:flavour_text, :expansion_id, :card_id, :image, :rarity)
    end
end
