module V1
  class ContactsController < BaseController
    before_action :authenticate
    before_action :set_contact, only: %i[show update destroy]
  
    # GET /contacts
    def index
      @contacts = Contact.all
  
      render json: @contacts
    end
  
    # GET /contacts/1
    def show
      render json: @contact
    end
  
    # POST /contacts
    def create
      @contact = Contact.new(parsed_contact_params)

      if @contact.save
        render json: @contact, status: :created
      else
        render_error(:unprocessable_entity, nil, @contact.errors)
      end
    end
  
    # PATCH/PUT /contacts/1
    def update
      @contact.social_networks.destroy_all
      if @contact.update(parsed_contact_params)
        render json: @contact
      else
        render_error(:unprocessable_entity, nil, @contact.errors)
      end
    end
  
    # DELETE /contacts/1
    def destroy
      @contact.destroy
      render json: {}
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Parse contact params (type -> kind, social_networks -> social_networks_attributes)
      def parsed_contact_params
        data = contact_params
        data[:user] = @current_user
        data[:social_networks_attributes] = data.delete(:social_networks)
        data[:social_networks_attributes].each do |social_network|
          social_network[:kind] = social_network.delete(:type)
        end
        data
      end
  
      # Only allow a trusted parameter "white list" through.
      def contact_params
        params.permit(:name, :email, :address, :phone, social_networks: [[:type, :url, :number]])
      end
  end
end
