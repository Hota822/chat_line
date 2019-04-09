# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Faoundation使用時の注意
  * MotionUI未使用、使用したいときは faundation_and_overrides.scss:
    // @imort ;motion-ui/motion-ui
    // @include motion-ui-transitions;
    // @include motion-ui-animations;
  のコメントを外す
  * ページレイアウトのヘッドタグに
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    を入れる