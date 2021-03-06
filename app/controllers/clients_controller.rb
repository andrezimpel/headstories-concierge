class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  skip_filter :authenticate_user!, only: [:show]
  layout :resolve_layout
  include AppointmentsHelper

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @appointments = @client.appointments

    respond_to do |format|
      format.html
      format.json
      format.ics { render :text => generate_ical(@appointments) }
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        ClientMailer.constent_request(@client).deliver_now

        format.html { redirect_to clients_url, notice: 'Client was successfully invited.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_url, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # invitation handling
  def resend_invitation
    @client = Client.find(params[:id])
    ClientMailer.constent_request(@client).deliver_now
    redirect_to clients_url, notice: 'Client was successfully reinvited.'
  end

  def accept_invitation
    @client = Client.where(consent_token: params[:consent_token]).first
    @consent = @client.consent
    @client.update_attributes(consent: true) unless @consent
    redirect_to thank_you_path(id: @client, consent: @consent)
  end

  def thank_you
    @client = Client.find(params[:id])
    @consent = params[:consent]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:firstname, :lastname, :gender, :formally, :consent, :email, :consent_token)
    end

    def resolve_layout
      if params[:action] == 'thank_you'
        return 'public'
      end
      return 'application'
    end
end
