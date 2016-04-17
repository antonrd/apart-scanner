class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def create
    Tag.create(tag_params)

    redirect_to tags_path
  end

  def update
    Tag.find(params[:id]).update_attributes(tag_params)

    redirect_to tags_path
  end

  def destroy
    Tag.find(params[:id]).destroy

    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:label)
  end
end
