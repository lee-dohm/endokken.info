# endokken.info

This is the website code for http://endokken.info.

## Setup

### Heroku

This process is going to be deprecated soon in preparation for moving to Digital Ocean.

1. Install the [Heroku Toolbelt][heroku]
1. Install [Node.js][node]
1. Clone the repository
1. Execute `npm install` to install the prerequisites
1. Launch the local server with `foreman start`

### Docker

1. Install Homebrew
1. Install Docker
    ```bash
    $ brew install docker
    $ brew install boot2docker
    ```
1. Build the Docker image
    ```bash
    $ docker build -t endokken.info .
    ```
1. Run the Docker image
    ```bash
    $ docker run -it --rm -p 4000:3000 --name www.endokken.info endokken.info
    ```
1. Get the running Docker image's IP
    ```bash
    $ boot2docker ip
    ```
1. View the home page by navigating to `http://$(ip):4000`

### Helpful Atom Packages

* [language-docker](https://atom.io/packages/language-docker)
* [language-jade](https://atom.io/packages/language-jade)

## Copyright

Copyright &copy; 2015 by [Lee Dohm][lee-dohm]. All Rights Reserved.

[heroku]: https://toolbelt.heroku.com/
[lee-dohm]: http://www.lee-dohm.com
[node]: http://nodejs.org/
