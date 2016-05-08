# README

## Name

rroonga-iruby

## Description

rroonga-iruby adds [IRuby](https://github.com/SciRuby/iruby)
integration features to [Rroonga](http://ranguba.org/#about-rroonga).

rroonga-iruby provides table view, table visualization and so on.

## Authors

  * Kouhei Sutou `<kou@clear-code.com>`

## License

LGPL 2.1 or later. See doc/text/lgpl-2.1.txt for details.

(Kouhei Sutou has a right to change the license including
contributed patches.)

## How to use

Create `Gemfile` with the following content:

```ruby
source "https://rubygems.org/"

gem "rbczmq"
gem "rroonga-iruby"
```

Install libraries:

```text
% bundle install --binstubs
```

Run IRuby:

```text
% bin/iruby notebook
```

`require "rroonga-iruby"` in the notebook:

```ruby
require "rroonga-iruby"
```

## Mailing list

  * English: [groonga-talk](http://lists.sourceforge.net/mailman/listinfo/groonga-talk)
  * Japanese: [groonga-dev](http://lists.sourceforge.jp/mailman/listinfo/groonga-dev)
