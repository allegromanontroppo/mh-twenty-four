## MH:24 The SH:24 Full Stack Engineer Tech Test by [Mark Holland](https://mark-holland.netlify.app/)

https://sh24.notion.site/SH-24-Full-Stack-Engineer-Tech-Test-8923d2183d5d413c95d77cd7eb823c29

---

## See it live

https://mh-24.herokuapp.com/

## Prerequisites

-   ruby-3.1.2
-   Node.js and NPM

## To install

Using the terminal:

-   Run `bundle install` to install Ruby Gems.
-   Within the `client` directory run `npm install`.
-   Back in the top level application directory install the [foreman gem](https://github.com/ddollar/foreman) with `gem install foreman` .

## To run up the web app

Using the terminal simply run `foreman start -f Procfile.dev`. This will use the Procfile.dev to start the Rails server for the api and local webpack server for the client side.

## To run the tests

Using the terminal simply run `bin/rspec spec`
