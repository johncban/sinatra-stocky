<img align="right" width="100" height="100" src="https://raw.githubusercontent.com/johncban/sinatra-stocky/master/public/images/stocky_logo.png">

<img align="right" width="100" height="100" src="http://sinatrarb.com/images/logo.png">


# Sinatra-stocky

Second Flatiron Project, a Sinatra portfolio project that creates user account, collects stock symbols and its data.
Capable of CRUD or Create Update Delete the user, portfolio and stocks.

## Top Project API

[<img align="left" width="500" height="300" src="https://apifriends.com/wp-content/uploads/2018/02/alpha-vantage-home.png">](https://www.alphavantage.co/)

[<img width="500" height="300" src="https://mms.businesswire.com/media/20190522005193/en/723157/23/logo-color.jpg">](https://iexcloud.io/)

### Directory Tree
```
stocky
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── portfolio_controller.rb
│   │   ├── stock_controller.rb
│   │   └── user_controller.rb
│   ├── models
│   │   ├── portfolio.rb
│   │   ├── stock.rb
│   │   ├── stocks.rb
│   │   └── user.rb
│   └── views
│       ├── admin
│       │   └── allusers.erb
│       ├── failure.erb
│       ├── home.erb
│       ├── index.erb
│       ├── layout.erb
│       ├── portfolio
│       │   ├── create_portfolio.erb
│       │   ├── edit_portfolio.erb
│       │   ├── show_portfolio.erb
│       │   └── user_portfolio.erb
│       ├── stocks
│       │   ├── new_stock.erb
│       │   ├── stock.erb
│       │   ├── stock_edit.erb
│       │   └── user_stock_info.erb
│       └── users
│           ├── edit.erb
│           ├── login.erb
│           ├── profile.erb
│           └── signup.erb
├── config
│   ├── environment.rb
│   └── initializers
├── config.ru
├── db
│   ├── development.sqlite
│   ├── migrate
│   │   ├── 20191223030736_create_users.rb
│   │   ├── 20200103093559_create_portfolio.rb
│   │   └── 20200103093820_create_stocks.rb
│   ├── schema.rb
│   └── test.sqlite
├── doc
│   ├── ApplicationController.html
│   ├── Portfolio.html
│   ├── PortfolioController.html
│   ├── Stock.html
│   ├── StockController.html
│   ├── Stocks.html
│   ├── User.html
│   ├── UserController.html
│   ├── _index.html
│   ├── class_list.html
│   ├── css
│   │   ├── common.css
│   │   ├── full_list.css
│   │   └── style.css
│   ├── debug.log
│   ├── file.README.html
│   ├── file_list.html
│   ├── frames.html
│   ├── index.html
│   ├── js
│   │   ├── app.js
│   │   ├── full_list.js
│   │   └── jquery.js
│   ├── method_list.html
│   └── top-level-namespace.html
├── lib
├── public
│   ├── images
│   │   ├── corneal-small.png
│   │   ├── favicon.ico
│   │   ├── stocky_logo.jpg
│   │   └── stocky_logo.png
│   ├── javascripts
│   │   ├── Chart.bundle.js
│   │   ├── chartkick.js
│   │   └── util.js
│   └── stylesheets
│       └── main.css
├── spec
│   ├── application_controller_spec.rb
│   └── spec_helper.rb
└── spec.md
```
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Prerequisites

In your PC or MAC, it require [Ruby](https://www.ruby-lang.org/en/news/2020/03/31/ruby-2-6-6-released/) to be installed (i.e. Ruby 2.6.6).

#### Installing Ruby on PC
To install Ruby on PC, follow this [video instructions](https://www.youtube.com/watch?v=OzijLscV3BQ).
Here's the [Ruby Installer](https://rubyinstaller.org/) for Windows 10.


#### Installing Ruby on Mac or Linux
Installing ruby on Mac or Linux is quite easy than PC and here are the following YouTube steps:

1. [Mac or OSX](https://www.youtube.com/watch?v=IXyPLDJDxcM)
2. [Linux or Ubuntu](https://www.youtube.com/watch?v=Fm5wz74JKmo)

#### Git clone the repo
I recommend using git instead of gem as this app or project is not yet publish for gem use.

To clone this repo, just click Clone or Download this repo as Zip; otherwise if you're system have a git app installed ([Windows Steps](https://help.github.com/en/desktop/getting-started-with-github-desktop/installing-github-desktop) - [OSX Steps](https://help.github.com/en/desktop/getting-started-with-github-desktop/installing-github-desktop)) do the following in your terminal or command line:

```$ git clone https://github.com/johncban/sinatra-stocky.git```

In the terminal or command prompt, change the current directory to sinatra-stocky folder.

And then execute the following command in the repo root folder to install the necessary gems:

    $ bundle

#### API Registration for Token
In order to run the project properly, it will require you to register to the following API providers for free API token.
1.  [AlphaVantage API Key Registration.](https://www.alphavantage.co/support/#api-key)
2. In [IEX Cloud](https://iexcloud.io/cloud-login#/register), select the account type as Individual for free account.


## Running the Project
After obtaining the API keys and Tokens, it will require to enter the API and token keys to the following controllers.

### StockController
Inside the StockController or ```stock_controller.rb```, enter the Alpha Vantage token in line 5 then enter the IEX Cloud token to line 6.

```
class StockController < ApplicationController
    alpha_token = "TOKEN HERE"
    iex_token = "TOKEN HERE"
    ...
```

In line 80 inside StockController, it requires IEX API Key in the following code block.

```
url = "https://newsapi.org/v2/everything?q=#{@company_name}&apiKey=API TOKEN HERE"
        resp = Net::HTTP.get_response(URI.parse(url))
        @data = JSON.parse(resp.body)
```

### UserController
Inside UserController or ```user_controller.rb```, enter the AlphaVantage token in line 6.

```
require 'pry'


class UserController < ApplicationController

	token = "TOKEN HERE"
    ...
```

### The Shotgun Server
The project's server is Shotgun, the said server is Ruby Rack-based that atomate code reloading of sinatra-stocky and make the app's test faster.

After applying the API keys type ```shotgun``` then press enter, then copy and paste the server address to the web browser.
```
== Shotgun/WEBrick on http://127.0.0.1:9393/
[2020-04-12 04:30:46] INFO  WEBrick 1.4.2
[2020-04-12 04:30:46] INFO  ruby 2.6.5 (2019-10-01) [x86_64-linux]
[2020-04-12 04:30:46] INFO  WEBrick::HTTPServer#start: pid=2343 port=9393
```



## Built With
1. [sinatra](https://rubygems.org/gems/sinatra)
2. [yard-ghpages](https://rubygems.org/gems/yard-ghpages)
3. [sqlite3](https://rubygems.org/gems/sqlite3)
4. [sinatra-flash](https://rubygems.org/gems/sinatra-flash)
5. [alphavantagerb](https://rubygems.org/gems/alphavantagerb)
6. [iex-ruby-client](https://rubygems.org/gems/iex-ruby-client)
7. [bcrypt](https://rubygems.org/gems/bcrypt)
8. [email_validator](https://rubygems.org/gems/email_validator)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sinatra-stocky. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Newsjournal project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/newsjournal/blob/master/CODE_OF_CONDUCT.md).
