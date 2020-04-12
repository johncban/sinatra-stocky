<img align="right" width="100" height="100" src="https://raw.githubusercontent.com/johncban/sinatra-stocky/master/public/images/stocky_logo.png">

<img align="right" width="100" height="100" src="http://sinatrarb.com/images/logo.png">


# Sinatra-stocky

Second Flatiron Project, a Sinatra portfolio project that creates user account, collects stock symbols and its data.
Capable of CRUD or Create Update Delete the user, portfolio and stocks.

## Top Project Api Used

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
│       ├── user_portfolio.erb
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
│   ├── favicon.ico
│   ├── images
│   │   ├── corneal-small.png
│   │   ├── favicon.ico
│   │   ├── minimal_abstract1.png
│   │   ├── minimal_abstract2.png
│   │   ├── ny.jpg
│   │   ├── ny.png
│   │   ├── stocky_logo.jpg
│   │   └── stocky_logo.png
│   ├── javascripts
│   │   ├── Chart.bundle.js
│   │   ├── chartkick.js
│   │   ├── util.js
│   │   └── vanta.waves.js
│   └── stylesheets
│       └── main.css
├── slim2erb
│   └── README.md
├── spec
│   ├── application_controller_spec.rb
│   └── spec_helper.rb
└── spec.md
```
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
