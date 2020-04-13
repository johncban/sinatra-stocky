require 'pry'


class PortfolioController < ApplicationController

    get '/portfolio' do
        if logged_in?
            @portfolio = current_user.portfolios.all
            erb :'/portfolio/user_portfolio'
        else
            not_log_redirect 
        end
    end

    get '/portfolio/new' do
      if logged_in?
          @portfolio = current_user.portfolios.all
          erb :'/portfolio/create_portfolio'
      else
          not_log_redirect 
      end
    end

    post '/portfolio' do
        if params[:portfolioname].empty?
            flash[:message] = "Please Enter the Portfolio Name - Error Code: #{response.status}"
            portfolio_redirect
        else
            @user = current_user
            @portfolio = Portfolio.create(portfolioname:params[:portfolioname], user_id:@user.id)
            portfolio_redirect
        end
    end

    post '/portfolio/new' do
      if params[:portfolioname].empty?
          flash[:message] = "Please Enter Portfolio Name - Error Code: #{response.status}"
          erb :'/portfolio/create_portfolio'
      else
          @user = current_user
          @portfolio = Portfolio.create(portfolioname:params[:portfolioname], user_id:@user.id)
          redirect to "/home"
      end
    end

    get '/portfolio/:id' do
      @portfolio = Portfolio.find_by_id(params[:id])
      if @portfolio
            if logged_in? 
              erb :'/portfolio/show_portfolio'
            else
              flash[:nocredential] = "Please Sign Up or Log in - Error Code: #{response.status}"
              not_log_redirect
            end
      else
        flash[:noportfolio] = "No Portfolio Name - Error Code: #{response.status}" 
        redirect '/home'
      end
    end

    get '/portfolio/:id/edit' do
      @portfolio = Portfolio.find_by_id(params[:id])
        if @portfolio 
          if logged_in? 
            if @portfolio.user_id == current_user.id
              erb :'/portfolio/edit_portfolio'
            else
              flash[:not_current_portfolio] = "You don't have the current portfolio ID to edit - Error Code: #{response.status}"
              redirect '/home'
            end
          else
            not_log_redirect
          end
        else
          flash[:noportfolio] = "No Portfolio Name"
          redirect '/home'
        end
    end

    patch '/portfolio/:id' do
      @portfolio = Portfolio.find_by_id(params[:id])
      if !params[:portfolioname].empty?
          @portfolio = Portfolio.find(params[:id])
          @portfolio.update(portfolioname:params[:portfolioname])
          flash[:message] = "Your category has been updated successfully - Response Code: #{response.status}"
          portfolio_redirect
      else
          flash[:message] = "Please don't leave blank Portfolio Name - Error Code: #{response.status}"
          redirect to "/portfolio/#{params[:id]}/edit"
      end

    end

    delete '/portfolio/:id/delete' do
      if logged_in?
        if current_user.portfolios.size <= 0
          flash[:portfolio_message] = "Require at least one Portfolio - Error Code: #{response.status}"
          redirect "/home"
        else
          @portfolio = Portfolio.find_by_id(params[:id])
          if @portfolio.user_id == current_user.id
             @portfolio.destroy
             flash[:portfolio_del_message] = "Portfolio Name Successfully Deleted - Response Code: #{response.status}"
             redirect "/home"
          end
        end
      else
        not_log_redirect
      end
    end

end
