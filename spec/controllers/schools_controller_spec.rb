require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets schools instance variable' do
      school = School.create(name: 'test')
      get :index
      expect(assigns(:schools)).to eq([school])
    end

    # what does render_template mean?
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) do
      @school = School.create(name: 'test')
      get :show, id @school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the school instance variable' do
      expect(assigns(:school)).to eq(@school)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end   
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'sets new school instance variable' do
      get :new
      expect(assigns(:school)).to_not be(:nil)
      expect(assigns(:school).class).to eq(School)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @school = School.create(name: 'test')
      get :edit, id: @school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the school instance variable' do
      expect(assigns(:school)).to eq(@school)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do

    context 'with a name' do
      before(:each) do
        @school_name = 'test'
        post :create, {school: {name: @school_name}}
      end

      it 'successfully creates a school' do
        expect(School.count).to eq(1)
        expect(School.first.name).to eq(@school_name)
      end

      it 'redirects to schools index on successful creation' do
        expect(response).to redirect_to(schools_path)
      end
    end

    context 'without a name' do
      before(:each) do
        post :create, {school: {name: ''}}
      end

      it 'fails to create a school with a name' do
        expect(School.count).to eq(0)
      end

      it 'renders the new template if unsuccessful' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @school = School.create(name: 'test')
    end

    context 'with updated name' do
      before(:each) do
        put :update, {id: @school.id, school: {name: 'updated'}}
      end
      
      it 'updates a school successfully' do
        expect(@school).reload.name).to eq('updated')
      end

      it 'redirects to school show path on successful update' do
        expect(response).to redirect_to school_path(@school)
      end
    end

    context 'without updated name' do
      before(:each) do
        put :update, {id: @school.id, school: {name: ''}}
      end

      it 'renders the edit template on the error update' do
        expect(response).to render_template(:edit)
      end

      it 'does not update the school on error' do
        expect(@school.reload.name).to eq('test')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      school = School.create(name: 'test')
      expect(School.count).to eq(1)
      delete :destroy, id: school.id
    end

    it 'deletes a school' do
      expect(School.count).to eq(0)
    end

    it 'reidrects to schools index on successful delete' do
      expect(response).to redirect_to schools_path
    end
  end

end
