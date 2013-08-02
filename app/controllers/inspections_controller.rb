class InspectionsController < ApplicationController
	before_filter :signed_in_user
  load_and_authorize_resource


	def new
		@inspection = Inspection.new
    #authorize! :create, @inspection
	end

  def download_artifacts
    @inspection = Inspection.find(params[:id])
    @inspection.artifacts.each do |a|
      send_data a.file, filename: a.filename,
                type: a.content_type
    end

  end

  def upload_remarks
    if request.post?
      @inspection = Inspection.find(params[:id])

      if Remark.parse_excel( params[:remarks_file], @inspection )
        flash.now[:success] = "Remarks were successfully uploaded"
        redirect_back_or @inspection
      else
        flash.now[:error] = "Can not upload #{}"
        render 'upload_remarks'
      end
    else
      #handle get. I.e. do nothing for now
    end
  end

	def show
		@inspection = Inspection.find(params[:id])
    self.current_inspection= @inspection
		store_location
	end

	def create


		if @inspection.save
			flash[:success] = "inspection #{@inspection.name} created"
			redirect_to root_url
		else
			render 'new'
		end
  end


  def index
    @inspections = Inspection.all
  #  respond_to do |format|
  #    format.js
  #  end
  end

  def destroy
    #remove a roles connected to inspections when deleted
    @inspection = Inspection.find(params[:id])
    if !current_user.nil?
      if ((current_user.has_role? :supervisor) || ( current_user.has_role? :admin ))
        @inspection.destroy
      else
        flash.now[:success] = "Looks like you don't have right to do that"
      end
    end
  end


  def edit
    @inspection = Inspection.find(params[:id])

  end
  def change_status
    @inspection = Inspection.find(params[:id])
    if !current_user.nil?
      #we don't think here about roles, they are controlled in abilities,
      # moderator can not use this action when status in 'archived' or 'closed'

      if current_user.has_role(:moderator, Inspection) && (params[:status] != 'archived') && (params[:status] != 'closed')
        @inspectio.status = params[:status]
      else
        @ispection.status = params[:status]
      end

      if @inspection.save
        flash.now[:success] = "Inspection status is now #{@inspection.status}"
        #redirect_to root_url
      else
        flash[:error] = "Can not change inspection status, sorry!"
      end
    end
  end
  def update
    @inspection = Inspection.find(params[:id])
    @inspection.update_attributes(params[:inspection])
  end
end
