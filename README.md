# Full Stack Challenge

---

:warning: This README file was edited to remove the company name that created the challenge.

---

This repo holds the code to resolve the below challenge, made by [David
Díaz](https://www.linkedin.com/in/diazglezdavid/) in Aug 2017.

> ### The application
>
> We want to create a simple frontend + backend microservice,
> that display data from two external services:
>
> * https://restcountries.eu/
> * https://openweathermap.org/api
>
> #### User stories
>
> 1. As a user, I access to the root path and see:
> * The Berlin country name
> * The Berlin weather description
> * The Berlin temperature
> * The Berlin currency
>
> 2. As a user, if I add a `rootPAth/:city-name` sub-path:
> * The city country name
> * The city weather description
> * The city temperature
> * The city currency

It consists of four small, simple applications built on top of Ruby and
JavaScript programming languages, using the [Hanami](http://hanamirb.org/)
framework and [Preact](https://github.com/developit/preact) library.

:exclamation: **Among others, were included here the
[Installation](#installation) and [Impressions](#impressions) requested
sections.**

## Why those tools?

I chose the quoted tools because at the time to read the given instructions, and
due to no limitations on how to do it, I thought that _it was a good moment to
try something new_.

So, I picked them out among those that I wanted to try with only one
self-restriction: based/built on languages which I already worked. At the end,
it is a challenge to apply in an open position, not `just for fun`.

The "penalty" of this decision could be the extra "effort" learning something
new. But to learn it could not be considered either penalty or effort :wink:.

### Criteria

* `Hanami`: I found it when was known as `Lotus.rb` and I was working with Ruby
  on Rails. I wanted to play with it since it is supposed that is designed to
  build, in a simple and productive way, microservices applications but
  following the [Monolith
  first](https://martinfowler.com/bliki/MonolithFirst.html) principle.

* `Preact`: I was working with React/React Native for a short period of time. I
  must admit that I liked the React component-based approach. Meanwhile, I saw
  the Preact alternative and I put it on the radar to test some day. Its
  [benchmark](https://github.com/developit/preact-perf) is impressive.

» Also I was estimating to use [Vue](https://vuejs.org/), but for time reasons
finally I ended using Preact.

## Installation

Because in the original Challenge's README it is stated the high usage of Docker in
the company, I took the opportunity to dive into it a little, making use of
`Docker` and `docker-compose`.

The result is, apart from my own learning about containers, that this
apps/project can be started easily just executing the `docker-compose up`
command. When containers are ready for use, following services should be
available:

  - `[Hanami Front]`: [`http:localhost:2300`](http:localhost:2300)
  - `[Preact Client]`: [`http:localhost:8080`](http:localhost:8080) _(*) Do not
    forget to put right IP/URL to API in the [config
    file](preact_client/src/config.js) if your want to try it on a mobile device._
  - `[Preact Standalone]`: [`http:localhost:9090`](http:localhost:9090)

_Also `[Hanami API]` `http:localhost:2300/api/city/:name` could be reached; in
fact, is the service that fetches and provides information for `[Hanami Front]`
and `[Preact Client]`_

**:warning: Of course, [Docker](https://www.docker.com/) and
[docker-compose](https://github.com/docker/compose) must be available in the
host system**

## Folder Structure

  - **main** - where the Hanami applications live. There are two applications
    * _api_: with a single endpoint `/city` that returns a JSON as response
    * _front_: wich build a simple user interface to display the data provided
      by `api`; has two routes
      - `/` show information for `Berlin`
      - `/:city` show information for `:city`
  - **preact_client** - wich contains a JavaScript PWA that makes request to
    _main/api_ in order to show the user interface (the same provided by
    _main/front_)
  - **preact_standalone** - a standalone JavaScript application, on basis of
    previous, wich makes requests directly to external services and build itself
    the data necessary for the user interface.

## Impressions

Regarding challenge, I do not have any particluar impressions, apart from the
general thoughts for this kind of applications that seems simple at first look,
but you could spend a lot of time if you switch to a "perfectionist" mode and
start to

> improve, change or use this and that; why not use this thing here; how about
> move that, etc

However, I want to add some notes in this section

### Tests

To be honest, testing is the area where I have less experience/training. For
this challenge, I tried to add some (and simple) unit testing, but probably they
are not enough. On the other side, Preact applications don't have any tests,
although I wanted to have added a couple of them using
[Enzyme](https://github.com/airbnb/enzyme) because [I was playing a
little](https://github.com/proiectus/bus-stop/blob/4047ece88a3a47e905bd936d679e0f3a1515afb1/src/containers/BusStop.test.js)
with it one year ago. Also could be great to use
[Jest](https://facebook.github.io/jest/).

But, sincerely, for the challenge purpose they would consume a lot of time to
me.

### Estimated time

Regarding estimated time said in the original readme file, I think it is
reasonable but it took more time for me due to:

  - My interest in using Docker
  - The lack of availability to work on it more than few hours in the nights
  - Some issues with the assets, which are described below

However, it could be said that first thing I did was making a functional "draft"
of the application that was working with 2-3 hours of code.

### Assets

I had some troubles with assets:

#### Berlin skyline

It is not included in the `assets` directory of received
`challenge(2).git` bundle. So, I did a simple search and downloaded a
`Free for commercial use` SVG version that I found at
[pixabay](https://pixabay.com/en/berlin-skyline-urban-tv-tower-307382/).

In addition, in order to achieve the desired aspect, I had to perform some
improvements to it

  - Edit with [Inkscape](https://inkscape.org) to fix document dimensions,
    because it had extra blank space/padding.
  - Change its color to `#E8E8E8`, since it is not trivial to change it by CSS
    when is used as a background. There are some techniques (use of JavaScript,
    include SVG as a path instead of as a file, etc) that I would not apply in
    this case.
  - Clean it up using [SVGOMG](https://jakearchibald.github.io/svgomg/), which
    reduces its weight considerably, removing unnecessary information.
  - Add the `preserveAspectRatio` to SVG property as is stated in [this answer
    in StackOverflow](https://stackoverflow.com/a/25837986).

#### Weather icons

Provided weather icons seem to me not complete. Or at least they do not cover
all of the [weather conditions](https://openweathermap.org/weather-conditions)
supplied by OpenWeatherMap. In addition, the fact that all of them contain a
cloud is a little confusing, in my opinion.

After thinking about it for a while, finally I decided to map them with the
service `Icon List`, using the icon code (ideally, it would be great to have an
icon for each `weather condition code`).


| icon_code | description      | day icon            | night icon           |
|-----------|------------------|---------------------|----------------------|
| 01        | clear sky        | cloud-sun           | cloud-moon           |
| 02        | few clouds       | clouds              | clouds               |
| 03        | scattered clouds | clouds              | clouds               |
| 04        | broken clouds    | clouds2             | clouds2              |
| 09        | shower rain      | cloud-sun-raindrops | cloud-moon-raindrops |
| 10        | rain             | cloud-sun-rain      | cloud-moon-rain      |
| 11        | thunderstorm     | cloud-sun-lightning | clouds-moon-lightning |
| 13        | snow             | clouds-sun-snow      | cloud-moon-snow      |
| 50        | mist             | cloud-sun-fog       | cloud-moon-fog       |

And also generate an icon font through [Icomoon.io](https://icomoon.io) using
the SVG files.

#### Fonts

It was generated two "web" fonts

  - `Challenge Icons`, generated according to the described above, using
    [Icomoon.io](htts://icomoon.io).
  - `Cabin`, from the `.ttf` file given and using
    [Transfonter](https://transfonter.org/) to obtain other extensions.

#### CSS / SASS

As this is a simple project, I decided to not use any CSS frameworks (it did not
make sense) or methodologies such as [BEM](http://getbem.com/),
[SMACSS](https://smacss.com/) or [MaintainableCSS](http://maintainablecss.com/).

I used the CSS pre-processor SASS to simplify the rules related to the weather
icons and put some values into variables.

To center vertically the content in the desktop version, and trying to avoid to
use another flexbox wrapper, `padding technique` was used. It works well, but
Android/iOS Google Chrome [has a bug with `vh`
units](https://stanko.github.io/mobile-chrome-vh-units-fix/) and render it a
little scrolled down.

In relation to CSS maintainability, but not related to this project, I have to
say that, at least for now,  I like the approach proposed in this
[article](https://adamwathan.me/css-utility-classes-and-separation-of-concerns/).

## Methodologies

To do this small project, I must admit that no specific methodology was
followed. Just starting to read the documentation, learn the necessary things
(specially about `Docker`) to build the application and start to programming.

I did not apply TDD or BDD (see [Tests](#test) section), neither agile
methodologies such as Scrum or Kanban because, despite I know them, I do not
have experience.

Finally, although it is not directly related to methodology, I tried to follow
this basic rules

  - **Use code guide styles** although a linter on [Hanami] did not add.
  - **Add necessary/basic documentation**
  - **Keep project(s) lightweight** avoiding to add additional dependencies /
    layers to ease the work (it is only a small challenge). E.g. it could be
    added [`HTTParty`](https://github.com/jnunemaker/httparty) in main/web to
    manage HTTP request/responses in more fancy way.

## Caveats

I had problems with Docker and `node_modules` directory. I solved it using the
trick seen at [Developing NodeJS services and module dependencies with
Docker-Compose](http://petemill.com/writing/docker-compose-node-development/):
**to use a volume for node_modules directory**. It works, but I do not have
enough Docker knowledge to make sure that it is the best option.

## Things `#TODO`

If this was a production project, there are some things to do. From top of my
head, the following are most of them:

  - **MUST** :bangbang:
    * Improve/increase the test suite. In the `[Preact *]` projects the correct
      word it is `Add`, since there is none test.
    * Remove unused files and/or dependencies (such as `preact-compat`
      introduced automatically by `preact-cli`.
    * I18n.
    * `[Hanami]` Use Rubocop.
    * Replace default `favicons`.
  - **NICE TO HAVE** :tada:
    * Round the temperature value (I kept it untouched).
    * Switch to `HTTParty`
    * Try to use [CSS Variables](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_variables).
    * `[Preact *]` Use _loading_ icons while information is being retrieved.
    * `[Hanami Front]` Use webpack.
