# lita-github-status

[![Build Status](https://travis-ci.org/miketheman/lita-github-status.svg?branch=master)](https://travis-ci.org/miketheman/lita-github-status)
[![Coverage Status](https://coveralls.io/repos/miketheman/lita-github-status/badge.svg)](https://coveralls.io/r/miketheman/lita-github-status)

A [Lita](http://lita.io) handler to display current GitHub Status.

## Installation

Add `lita-github-status` to your Lita instance's `Gemfile`:

``` ruby
gem 'lita-github-status'
```

## Configuration

None

## Usage

Ask the bot how GitHub is doing:

    Lita github status
    Status: good (300 seconds ago)

See `Lita: help github` for all commands.

## Prior Art

Pretty much a direct port of Hubot's [GitHub Status plugin](https://github.com/github/hubot-scripts/blob/master/src/scripts/github-status.coffee).
