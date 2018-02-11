# active_scaffold.cr [![Build Status](https://travis-ci.org/maiha/active-scaffold.cr.svg?branch=master)](https://travis-ci.org/maiha/active-scaffold.cr)

ActiveScaffold for Amber on Crystal.
- amber-0.6.5
- granite-orm-0.8.4+1
- crystal-0.24.1

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  active_scaffold:
    github: maiha/active_scaffold.cr
    version: 0.1.0
```

## Usage

```crystal
require "active_scaffold"

class UserController < ApplicationController
  include ActiveScaffold(User)

  active_scaffold do |config|
    config.columns = ["first_name", "last_name"]
    config.actions = ["list", "show"]
    config.action_links["show"].label = "View"

    config.show.label = "user(%s)"
    config.show.action_links = ["top", "list"]
    config.show.action_links["top"].label = "TOP"
    config.show.action_links["list"].label = "back"
  end
end
```

## Development

```shell
crystal spec -v
```

## Contributing

1. Fork it ( https://github.com/maiha/active_scaffold.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
