# Contributing to move.mil

Anyone is welcome to contribute code changes and additions to this project. If you'd like your changes merged into the master branch, please read the following document before opening a [pull request][pulls].

There are several ways in which you can help improve this project:

1. Fix an existing [issue][issues] and submit a [pull request][pulls].
1. Review open [pull requests][pulls].
1. Report a new [issue][issues]. _Only do this after you've made sure the behavior or problem you're observing isn't already documented in an open issue._

## Getting started

move.mil is a static website built using [Jekyll](http://jekyllrb.com/), a popular static site generator written in [Ruby](https://www.ruby-lang.org/). Development dependencies are managed using the [Bundler](http://bundler.io/) gem.

This project uses Ruby version 2.3.3 which can be installed using a Ruby version manager like [rbenv](https://github.com/rbenv/rbenv) (macOS, Linux) or a package manager like [Chocolatey](https://chocolatey.org/) (Windows). The Jekyll documentation website has additional instructions for [using Ruby and Jekyll on Windows platforms](https://jekyllrb.com/docs/windows/).

Once you've installed Ruby 2.3.3 using the method most appropriate to your environment, install the Bundler gem:

```sh
gem install bundler
```

After successfully installing Bundler, run the following command from the root of the project to install the dependencies specified in the [Gemfile][gemfile]:

```sh
bundle install
```

## Making changes

1. Fork and clone the project's repo.
1. Install development dependencies as outlined above.
1. Create a feature branch for the code changes you're looking to make: `git checkout -b your-descriptive-branch-name origin/master`.
1. _Write some code!_
1. Build the site and verify that your changes function as intended: `bundle exec rake jekyll:build`.
1. Commit your changes: `git commit -am 'Add some new feature or fix some issue'`.
1. Push the branch to your fork: `git push -u origin your-descriptive-branch-name`.
1. Create a new pull request and we'll review your changes.

## Code Style

Code formatting conventions are defined in the `.editorconfig` file which uses the [EditorConfig](http://editorconfig.org/) syntax. There are [plugins for a variety of editors](http://editorconfig.org/#download) that utilize the settings in the `.editorconfig` file. It is recommended that you install EditorConfig plugin for your editor of choice.

Your bug fix or feature addition won't be rejected if it runs afoul of any (or all) of these guidelines, but following the guidelines will definitely make everyone's lives a little easier.

## Legalese

Before submitting a pull request to this repository for the first time, you'll need to sign a [Developer Certificate of Origin](https://developercertificate.org/) (DCO). To read and agree to the DCO, you'll add your name and email address to [CONTRIBUTORS.md][contributors]. At a high level, this tells us that you have the right to submit the work you're contributing in your pull request and says that you consent to us treating the contribution in a way consistent with the license associated with this software (as described in [LICENSE][license]) and its documentation ("Project").

You may submit contributions anonymously or under a pseudonym if you'd like, but we need to be able to reach you at the email address you provide when agreeing to the DCO. Contributions you make to this public Department of Defense repository are completely voluntary. When you submit a pull request, you're offering your contribution without expectation of payment and you expressly waive any future pay claims against the U.S. Federal Government related to your contribution.

[contributors]: https://github.com/deptofdefense/move.mil/blob/master/CONTRIBUTORS.md
[gemfile]: https://github.com/deptofdefense/move.mil/blob/master/Gemfile
[issues]: https://github.com/deptofdefense/move.mil/issues
[license]: https://github.com/deptofdefense/move.mil/blob/master/LICENSE
[pulls]: https://github.com/deptofdefense/move.mil/pulls
