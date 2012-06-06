class ScenariosController < ApplicationController
  include ScenariosHelper
  include UsersHelper
  include TrackRecordsHelper

  before_filter :parse_facebook_cookies, except: :authorize
  after_filter  :track, only: [:analyze, :run]
  
  def parse_facebook_cookies
    facebook_cookies
  end
  
  # GET /scenarios
  # GET /scenarios.json
  def index
    unless access_token
      redirect_to controller: 'oauths', action: 'welcome'
      return
    end
  
    @drivers = [:chrome, :ff, :ie, :safari]
    @scenarios = Scenario.where(user_id: current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scenarios }
    end
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scenario }
    end
  end

  # GET /scenarios/new
  # GET /scenarios/new.json
  def new
    @scenario = Scenario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scenario }
    end
  end

  # GET /scenarios/1/edit
  def edit
    @scenario = Scenario.find(params[:id])
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(params[:scenario])

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to @scenario, notice: 'Scenario was successfully created.' }
        format.json { render json: @scenario, status: :created, location: @scenario }
      else
        format.html { render action: "new" }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scenarios/1
  # PUT /scenarios/1.json
  def update
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      if @scenario.update_attributes(params[:scenario])
        format.html { redirect_to @scenario, notice: 'Scenario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy

    respond_to do |format|
      format.html { redirect_to scenarios_url }
      format.json { head :no_content }
    end
  end
  
  def authorize
    session[:access_token] = "succsess"
    redirect_to scenarios_url
  end
  
  def welcome
  
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
  
  def analyze
    driver = params[:driver].to_sym
    options = nil
    case driver
      when :chrome
        options = {switches: %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]}
    end
  
    begin
      shotcrawl  = Shotcrawl::Application.new(online: true, url: params[:url], driver: params[:driver].to_sym, options: options)
      test_cases = shotcrawl.scenario_write(params[:url]).join()
      shotcrawl.browser.close
    rescue Errno::ECONNRESET => e
      logger.error e
    rescue => e
      logger.error e
      retry
    end
    scenario = Scenario.find_or_initialize_by(name: params[:url], user_id: current_user.id, create_at: Time.new, execute_at: nil)
    scenario.testcases.build({value: test_cases})
    scenario.save
    
    respond_to do |format|
      format.html { redirect_to scenarios_url}
      format.json { head :no_content }
    end
  end
  
  def run
    formed_scenario = params[:em1].gsub(/^\<p\>|\<\/p\>$/, '').gsub(/&nbsp;/, ' ')
        
    begin
      shotcrawl = Shotcrawl::Application.new(online: true, url: scenarios_url, driver: params[:driver].to_sym)
      test_cases = shotcrawl.run(formed_scenario)
      shotcrawl.browser.close
    rescue Errno::ECONNRESET => e
      logger.error e
    end
    
    @scenario = Scenario.find(params[:scenario_id])
    
    respond_to do |format|
      if @scenario.testcases.first.update_attributes(value: test_cases) && @scenario.update_attributes(execute_at: Time.new)
        format.html { redirect_to scenarios_url, notice: 'Scenario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to scenarios_url }
        format.json { render json: @scenario.errors, status: :unprocessable_entity}
      end
    end
  end
end