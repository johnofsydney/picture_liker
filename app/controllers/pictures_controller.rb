class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  # before_action :check_user, except: [:index]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  def results
    redirect_to pictures_url and return unless current_admin_user

    @user = User.find_by(id: params[:user_id].to_i)

    @liked_pictures = Picture.joins(:picture_users)
                             .where(picture_users: { user_id: @user.id, like:true })

    @disliked_pictures = Picture.joins(:picture_users)
                                .where(picture_users: { user_id: @user.id, dislike: true })
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    redirect_to pictures_url and return unless current_admin_user || current_user
  end

  # GET /pictures/new
  def new
    redirect_to pictures_url and return unless current_admin_user

    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
    redirect_to pictures_url and return unless current_admin_user
  end

  # POST /pictures or /pictures.json
  def create
    redirect_to pictures_url and return unless current_admin_user

    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    redirect_to pictures_url and return unless current_admin_user

    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    redirect_to pictures_url and return unless current_admin_user

    @picture.destroy!

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_multiple
    redirect_to pictures_url and return unless current_admin_user

    # Logic to render the form for adding multiple pictures
  end

  def create_multiple
    redirect_to pictures_url and return unless current_admin_user

    params[:pictures][:images].compact_blank.each do |picture_params|
      picture = Picture.new
      picture.image.attach(picture_params)
      picture.save!
    end

    redirect_to pictures_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:image)
    end
end
