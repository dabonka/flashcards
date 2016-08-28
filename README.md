[![Build Status](https://travis-ci.org/dabonka/flashcards.svg?branch=master)](https://travis-ci.org/dabonka/flashcards)
[![Code Climate](https://codeclimate.com/github/dabonka/flashcards/badges/gpa.svg)](https://codeclimate.com/github/dabonka/flashcards)
[![Test Coverage](https://codeclimate.com/github/dabonka/flashcards/badges/coverage.svg)](https://codeclimate.com/github/dabonka/flashcards/coverage)


# Flashcards
This is an application for learning foreign languages

## Description
User has decks and cards in these decks.
Every card has word and translation of this word.
User has to write the translation of the random active card.
If translation correct, next time the card will be active after 3 days.
Each user has his/her set of decks and cards.
User can create/edit/delete decks and cards


## Used gems
  - **nokogiri**        - parsing words
  - **sorcery**         - authorization
  - **whenever**        - mailing
  - **rails_12factor**  - heroku deploy