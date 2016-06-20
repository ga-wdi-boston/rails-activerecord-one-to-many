class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    render json: @people
  end

  # GET /people/1
  # GET /people/1.json
  def show
    render json: @person
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      head :no_content
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy

    head :no_content
  end

  private

    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:given_name, :surname, :gender, :height, :weight, :born_on, :home_town_id
)
    end
end
