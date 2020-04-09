require 'pry'


class StockController < ApplicationController
    alpha_token = ""
    iex_token = ""

    get '/stocks' do
        if logged_in?
                erb :'stocks/stock'
        else
                not_log_redirect
        end
        
    end

    get '/stocks/new' do
        if logged_in?
                erb :'stocks/new_stock'
        else
                not_log_redirect
        end
    end


    post '/stocks' do
        if params[:stock].empty? || params[:quantity].empty? || params[:portfolioname].empty?
                flash[:stocksform_error] = "Please don't leave blank content - Error Code: #{response.status}"
                redirect to "/stocks/new"
        else
                @user = current_user
                @portfolio = @user.portfolios.find_or_create_by(portfolioname:params[:portfolioname])
                @portfolio.user_id = @user.id
                @stock = Stock.create(stock:params[:stock], quantity:params[:quantity], portfolio_id:@portfolio.id, user_id:@user.id)
                redirect to "/stocks/#{@stock.id}"
        end

    end



    post '/stocks/new' do
        # IEX - Stock Screening -- begin
        qt = params[:stock_search].to_s
        client = IEX::Api::Client.new(
                publishable_token: iex_token,
                endpoint: 'https://sandbox.iexapis.com/v1'
        )
        
        if qt == ""
                flash[:qt_empty] = "Please Enter Stock Symbol."
        else 
                quote = client.quote(qt)

                @quote_symbol = qt
                @q_price = quote.latest_price

                key_stats = client.key_stats(qt)

                @company_name = key_stats.company_name

                @quote_price = "Current Price $#{@q_price}"
                @symbol_price = @q_price
        
        
                @sv10 = "10 Day Volume:  #{key_stats.avg_10_volume}"
                @sv30 = "30 Day Volume:  #{key_stats.avg_30_volume}"
        
                @low = "52 Week Low #{key_stats.week_52_low_dollar}" 
                @high = "52 Week High #{key_stats.week_52_high_dollar}"
        
                @eps = "Earnings Per Share (EPS)  #{key_stats.ttm_eps}"
                @five_change = "Five Day Price Percentage Change:  #{key_stats.day_5_change_percent_s}"

                # IEX - Stock Screening -- end        
        end

       
        url = "https://newsapi.org/v2/everything?q=#{@company_name}&apiKey=28a8355a5a5a4b25a5cb7983009aa602"
        resp = Net::HTTP.get_response(URI.parse(url))
        @data = JSON.parse(resp.body)


        erb :'stocks/new_stock'
    end

    
    get '/stocks/:id' do
        if logged_in?
                @stock = Stock.find(params[:id])
                
                sym = @stock.stock

                client = IEX::Api::Client.new(
                        publishable_token: iex_token,
                        endpoint: 'https://sandbox.iexapis.com/v1'
                )
                quote = client.quote(sym)
                @q_price = quote.latest_price

                key_stats = client.key_stats(sym)
                @company_name = key_stats.company_name

                client = Alphavantage::Client.new key: alpha_token
                stocks_found = client.search keywords: sym
                @stock_type = stocks_found.stocks[0].type

                total = @q_price * @stock.quantity

                @o_total = "Total Cost   $#{total.round()}"

        
                timeseries = Alphavantage::Timeseries.new symbol: sym, key: alpha_token
                @stock_vol = timeseries.volume
                @stock_high = timeseries.high
                @stock_low = timeseries.low
                        
                erb :'stocks/user_stock_info'
        else
                not_log_redirect
        end
    end

    get '/stocks/:id/edit' do
        if logged_in?
                @stock = Stock.find(params[:id])
                @portfolio = Portfolio.find(@stock.portfolio_id)
                sym = @stock.stock

                client = IEX::Api::Client.new(
                        publishable_token: iex_token,
                        endpoint: 'https://sandbox.iexapis.com/v1'
                )

                quote = client.quote(sym)
                @q_price = quote.latest_price

                key_stats = client.key_stats(sym)
                @company_name = key_stats.company_name

                cl = Alphavantage::Client.new key: alpha_token
                stocks_found = cl.search keywords: sym
                @stock_type = stocks_found.stocks[0].type

                total = @q_price * @stock.quantity

                @o_total = "#{total.round()}"


                if @stock.user_id == current_user.id
                        erb :'stocks/stock_edit'
                else
                        portfolio_redirect
                end
        else
                not_log_redirect
        end
    end

    post '/stocks/:id/edit' do
        @stock = Stock.find(params[:id])
        if !params[:stock_search].empty?
                # IEX - Stock Screening -- begin
                qt = params[:stock_search].to_s

                client = IEX::Api::Client.new(
                        publishable_token: iex_token,
                        endpoint: 'https://sandbox.iexapis.com/v1'
                )

                quote = client.quote(qt)

                @quote_symbol = qt
                @qp_price = quote.latest_price

                key_stats = client.key_stats(qt)

                @comp_name = key_stats.company_name
                # IEX - Stock Screening -- end

                erb :'stocks/stock_edit'
        else 
                flash[:message_stocks_edit_fail] = "Please enter the Stock Symbol! - Error Code #{response.status}"
                redirect to "/stocks/#{params[:id]}/edit"
        end


    end

    patch '/stocks/:id' do
        if !params[:stock].empty? && !params[:quantity].empty? 
                @stock = Stock.find(params[:id])
                @stock.update(stock:params[:stock], quantity:params[:quantity])
                @portfolio = current_user.portfolios.find_by(portfolioname:params[:portfolioname])
                @stock.portfolio_id = @portfolio.id 
                @stock.save
                flash[:message_stocks_edit] = "Stock unit successfully updated! - Response Code: #{response.status}"
                portfolio_redirect
        else
                flash[:message_stocks_edit_fail] = "Please enter the Stock Symbol and Stock Unit Quantity! - Error Code: #{response.status}"
                redirect to "/stocks/#{params[:id]}/edit"
        end

    end

    delete '/stocks/:id/delete' do
        if logged_in?
                @stock = Stock.find_by_id(params[:id])
                if @stock.user_id == current_user.id
                        @stock.delete
                        flash[:message_stocks_delete] = "Your stock has been deleted successfully! - Response Code: #{response.status}"
                        portfolio_redirect
                else 
                        portfolio_redirect
                end
        else
                not_log_redirect
        end
    end

end
