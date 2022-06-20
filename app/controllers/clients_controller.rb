class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]
  
  #set so anyone can look at the clients without logging in-------------------------------------
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!, except: [:index]

  #must be correct_user to make changes to clients
  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  # GET /clients or /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    #@client = Client.new
    @client = current_user.clients.build
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    #@client = Client.new(client_params)
    @client = current_user.clients.build(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @client = current_user.clients.find_by(id: params[:id])
    # correct user is that which has been associated with this ID
    #otherwise error message
    redirect_to clients_path, notice: "Not Authorized to Access This Client" if @client.nil?
    #if the friend id != current_user id it will be nil and youll get this message

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:first_name, :last_name, :phone, :email, :mail_address, :user_id)
    end
end
