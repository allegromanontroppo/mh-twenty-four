## MH:24 The SH:24 Full Stack Engineer Tech Test by [Mark Holland](https://mark-holland.netlify.app/)

https://sh24.notion.site/SH-24-Full-Stack-Engineer-Tech-Test-8923d2183d5d413c95d77cd7eb823c29

---

## See it live

https://mh-24.herokuapp.com/

## Prerequisites

-   ruby-3.1.2
-   Bundler
-   Node.js and NPM

## To install

Using the terminal:

-   Run `bundle install` to install Ruby Gems.
-   Within the `client` directory run `npm install`.
-   Back in the top level application directory install the [Foreman](https://github.com/ddollar/foreman) gem with `gem install foreman` .

## To run up the web app

Using the terminal simply run `foreman start -f Procfile.dev`. This will use the Procfile.dev to start the Rails server for the api and local webpack server for the client side.

## To run the tests

### Ruby

We use [RSPEC](https://rspec.info/) for unit tests against tbe business logic found in `app/external_services` and `app/interactors` and as a full request integration test against the api controller.
[VCR](https://relishapp.com/vcr/vcr/docs) is used to mock external network requests.

Using the terminal simply run `bin/rspec spec`

### React

We use [Jest](https://jestjs.io/), [Testing Library](https://testing-library.com/) and [Fetch Mock](https://www.wheresrhys.co.uk/fetch-mock/) for testing client-side JavaScript and UI.

Using the terminal simply run `npm test` to run the UI tests in service-checker.test.js.
